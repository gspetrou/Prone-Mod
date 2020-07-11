-- Copyright 2020, George "Stalker" Petrou. Enjoy!

--[[	DOCUMENTATION
prone.Version
	- Version of Prone Mod in YearMonthDay form.

COMMANDS:
	prone
		- Client
		- Enters or exits prone.
	prone_config
		- Client
		- Opens a little config menu for your prone keys.

HOOKS:
	prone.Initialized
		- Shared
		- Called after the Prone Mod has finished loading.
	prone.ShouldChangeCalcView
		- Client
		- Should the Prone Mod handle the transition of the player's view down/up from prone.
		- Arg One:	Local player.
		- Return:	Boolean. False to disable, anything else to enable.
	prone.ShouldChangeCalcViewModelView
		- Client
		- Same as prone.ShouldChangeCalcView but for their view model.

	Note:	These hooks are called on the server and client entering prone
			They are also predicted:
	
	prone.OnPlayerEntered
		- Called when a player is getting down to go prone.
		- Arg One:	Player entering prone.
		- Arg Two:	The length of their get down animation.
	prone.OnPlayerExitted
		- Called when a player just completely exitted prone.
		- Arg One:	The player that exitted prone.
	prone.CanEnter
		- Called to see if a player can enter prone.
		- Arg One:	The player that wants to go prone.
		- Return:	A boolean determining if they can enter prone or not.
	prone.CanExit
		- Called to see if a player can exit prone.
		- Arg One:	The player that wants to exit prone.
		- Return:	A boolean determining if they can exit prone or not.
		
FUNCTIONS:
	Note: None of these functions exist till after the initialize hook is called.
	
	PLAYER:IsProne()
		- Shared
		- Returns true if the player is prone.
	PLAYER:GetProneAnimationState()
		- Shared
		- Returns one of the PRONE_ enums mentionned below.
	prone.Handle(Player)
		- Shared
		- If the player is prone this will make them end, otherwise it will make them enter prone.
		- For prediction try to call this shared if you can.
	prone.Enter(Player)
		- Shared
		- Will make the player go prone, doesn't check to see if they should or if they are already in prone.
		- You should probably check with ply:IsProne() and prone.CanEnter(Player) before using this function.
		- For prediction try to call this shared if you can.
	prone.End(Player)
		- Shared
		- Will make the given player exit prone, doesn't check to see if they should or if they are already out of prone.
		- You should probably check with ply:IsProne() and prone.CanExit(Player) before using this function.
		- For prediction try to call this shared if you can.
	prone.Exit(Player)
		- Shared
		- Will make the player immediately exit prone, skipping the get up animation. Doesn't check to see if a player is already prone.
	prone.Request()
		- Client
		- Will ask the server to exit prone if they are prone or to enter prone if they aren't.
	RunConsoleCommand("prone_config")
		- Client
		- Will open up the in-game prone configuration menu.

	Note: These functions below MUST be called in or after the prone.Initialzed hook has been called.
	prone.AddNewHoldTypeAnimation(holdtype, movingSequenceName, idleSequenceName)
		- Shared
		- Registers a new hold type animation. Requires a sequence name for the moving animation and idle animation for that holdtype.
		- Can be used to override pre-existing holdtypes. Must be called shared.
	prone.GetIdleAnimation(holdtype)
		- Shared
		- Returns the name of the sequence corresponding the idle stance of the given holdtype.
	prone.GetMovingAnimation(holdtype)
		- Shared
		- Returns the name of the sequence corresponding the moving stance of the given holdtype.

ENUMERATIONS:
	PRONE_GETTINGDOWN	= 0
		-- Prone state. Set when the player is getting down into prone.
	PRONE_INPRONE		= 1
		-- Prone state. Set when the player is down in prone.
	PRONE_GETTINGUP		= 2
		-- Prone state. Set when the player is getting up.
	PRONE_NOTINPRONE	= 3
		-- Prone state. Set when a player is not prone.
	PRONE_IMPULSE		= 217
		-- Sent to server from client using CUserCmd:SetImpulse() to signify the user wanting to go prone.
	PRONE_CUSTOM_ANIM_EVENT_NUM		= 69420
		-- Passed as a data arg with Player:DoCustomAnimEvent() to be used in the GM:DoAnimationEvent hook.

CONVARS:
	prone_movespeed
		-- Server (replicated and archived)
		-- Number, speed of moving while prone.
	prone_bindkey_enabled
		-- Client (archived)
		-- Boolean (1 or 0), should a bind key be pressed to enter prone, or just the "prone" command.
	prone_bindkey_key
		-- Client (archived)
		-- Number, representing a KEY enum, for what the bind key should be.
	prone_bindkey_doubletap
		-- Client (archived)
		-- Boolean, should we have to double press the bind key to go prone.
	prone_jumptogetup
		-- Client (archived)
		-- Boolean, should the jump key toggle prone.
	prone_jumptogetup_doubletap
		-- Client (archived)
		-- Boolean, if prone_jumptogetup is enabled, should we have to double tap it.
	prone_disabletransitions
		-- Client (archived)
		-- Boolean, should we disable view transitions when entering and exitting prone.
]]

----------------------------------------------------------------
-- Initialization
----------------------------------------------------------------
prone = prone or {}
prone.Config = prone.Config or {}
prone.Animations = prone.Animations or {}

-- YearMonthDay
prone.Version = 20200711

-- States
PRONE_GETTINGDOWN	= 0
PRONE_INPRONE		= 1
PRONE_GETTINGUP		= 2
PRONE_NOTINPRONE	= 3

-- The impulse number to be used for toggling prone.
-- If anybody steals my number there will be hell to pay.
PRONE_IMPULSE = 127

-- This number is passed as the "data" arg to ply:DoCustomAnimEvent().
-- Again, steal this number and there will be hell to pay.
PRONE_CUSTOM_ANIM_EVENT_NUM = 69420

if SERVER then
	-- https://steamcommunity.com/sharedfiles/filedetails/?id=775573383
	resource.AddWorkshop("775573383")
end

hook.Add("Initialize", "prone.Initialize", function()
	-- Send files
	if SERVER then
		AddCSLuaFile("prone/class_prone_statedata.lua")
		AddCSLuaFile("prone/config.lua")
		AddCSLuaFile("prone/sh_prone.lua")
		AddCSLuaFile("prone/sh_thirdparty_compat.lua")
		AddCSLuaFile("prone/cl_prone.lua")
	end

	-- Load files (in order)
	include("prone/class_prone_statedata.lua")
	include("prone/config.lua")
	include("prone/sh_prone.lua")
	include("prone/sh_thirdparty_compat.lua")
	if SERVER then
		include("prone/sv_prone.lua")
	else
		include("prone/cl_prone.lua")
	end

	print("Initialized The Prone Mod, by Stalker and Stiffy360 (wOS version)")
	hook.Call("prone.Initialized")
end)


----------------------------------------------------------------
-- Pre-Library
---------------
-- Collection of small functions used throughout the addon.
----------------------------------------------------------------

---------------------
-- prone.WritePlayer
---------------------
-- Desc:		Writes a player entity via the net library.
-- Arg One:		Player, to write.
function prone.WritePlayer(ply)
	if IsValid(ply) then
		net.WriteUInt(ply:EntIndex(), 7)
	else
		net.WriteUInt(0, 7)
	end
end

--------------------
-- prone.ReadPlayer
--------------------
-- Desc:		Reads a player entity via the net library.
-- Arg One:		Player, to read.
function prone.ReadPlayer()
	local i = net.ReadUInt(7)
	if not i then
		return
	end
	return Entity(i)
end

-- Sandbox C-Menu
if CLIENT then
	hook.Add("PopulateToolMenu", "prone.SandboxOptionsMenu", function()
		spawnmenu.AddToolMenuOption("Utilities", "User", "prone_options", "Prone Options", "", "", function(panel)
			panel:SetName("Prone Mod")
			panel:AddControl("Header", {
				Text = "",
				Description = "Configuration menu for the Prone Mod."
			})

			panel:AddControl("Checkbox", {
				Label = "Enable the bind key",
				Command = "prone_bindkey_enabled"
			})

			panel:AddControl("Checkbox", {
				Label = "Double-tap the bind key",
				Command = "prone_bindkey_doubletap"
			})

			panel:AddControl("Checkbox", {
				Label = "Can press jump to get up",
				Command = "prone_jumptogetup"
			})

			panel:AddControl("Checkbox", {
				Label = "Double-tap jump to get up",
				Command = "prone_jumptogetup_doubletap"
			})

			panel:AddControl("Numpad", {
				Label = "Set the Bind-Key",
				Command = "prone_bindkey_key"
			})
		end)
	end)
end