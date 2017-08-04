-- Copyright 2016 George "Stalker" Petrou, enjoy!

--[[	DOCUMENTATION	
HOOKS:
	Note: These hooks only exist serverside.
	
	Prone.OnPlayerEntered
		- Called when a player is getting down to go prone.
		- Arg One:	Player entering prone.
		- Arg Two:	The length of their get down animation.
	Prone.OnPlayerExitted
		- Called when a player just completely exitted prone.
		- Arg One:	The player that exitted prone.
	Prone.CanEnter
		- Called to see if a player can enter prone.
		- Arg One:	The player that wants to go prone.
		- Return:	A boolean determining if they can enter prone or not.
	Prone.CanExit
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
		- Returns one of the PRONE_ enums.
	prone.IsCompatiblity()
		- Shared
		- Returns true if prone_compatibility is 1 or the gamemode is derived from Nutscript or Clockwork.

	prone.Handle(Player)
		- Server
		- If the player is prone this will make them exit, otherwise it will make them enter prone.
	prone.Enter(Player)
		- Server
		- Will make the player go prone, doesn't check to see if they should or if they are already in prone.
		- You should probably check with ply:IsProne() and prone.CanEnter(Player) before using this function.
	prone.End(Player)
		- Server
		- Will make the given player exit prone, doesn't check to see if they should or if they are already out of prone.
		- You should probably check with ply:IsProne() and prone.CanExit(Player) before using this function.
	prone.Exit(Player)
		- Server
		- Will make the player immediately exit prone, skipping the get up animation. Doesn't check to see if a player is already prone.

	prone.Request()
		- Client
		- Will ask the server to exit prone if they are prone or to enter prone if they aren't.
	RunConsoleCommand("prone_config")
		- Client
		- Will open up the in-game prone configuration menu.

ENUMERATIONS:
	PRONE_GETTINGDOWN	= 0
		-- Set when the player is getting down into prone.
	PRONE_INPRONE		= 1
		-- Set when the player is down in prone.
	PRONE_GETTINGUP		= 2
		-- Set when the player is getting up.
	PRONE_EXITTINGPRONE	= 3
		-- Set when the player's get up animation is over and they should be completely exitting prone.
	PRONE_NOTINPRONE	= 4
		-- Set when a player is not prone.
]]

prone = prone or {}
prone.config = prone.config or {}
prone.animations = prone.animations or {}

-- Version formatted as YearMonthDay of the update.
prone.Version = 20161112

-- States
PRONE_GETTINGDOWN	= 0
PRONE_INPRONE		= 1
PRONE_GETTINGUP		= 2
PRONE_EXITTINGPRONE	= 3
PRONE_NOTINPRONE	= 4

function net.WritePlayer(ply)
	if IsValid(ply) then
		net.WriteUInt(ply:EntIndex(), 7)
	else
		net.WriteUInt(0, 7)
	end
end

function net.ReadPlayer()
	local i = net.ReadUInt(7)
	if not i then
		return
	end
	return Entity(i)
end

CreateConVar("prone_compatibility", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Enable this to enhance prone model support. This is experimental and therefore unstable.")

-- We wait till initialize to see what the active gamemode is.
hook.Add("Initialize", "Prone.Initialize", function()
	local IsSpecialGamemode = GAMEMODE.DerivedFrom == "clockwork" or GAMEMODE.DerivedFrom == "nutscript"
	function prone.IsCompatibility()
		return true
		--return GetConVar("prone_compatibility"):GetBool() or IsSpecialGamemode
	end

	if SERVER then
		resource.AddWorkshop("609281761")

		AddCSLuaFile("prone/config.lua")
		AddCSLuaFile("prone/sh_prone.lua")
		AddCSLuaFile("prone/cl_prone.lua")

		include("prone/config.lua")
		include("prone/sv_prone.lua")
	else
		include("prone/config.lua")
		include("prone/cl_prone.lua")
	end
	include("prone/sh_prone.lua")
end)

-- Sandbox C-Menu
if CLIENT then
	hook.Add("PopulateToolMenu", "Prone.SandboxOptionsMenu", function()
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
				Command = "prone_jumptogetup"
			})

			panel:AddControl("Numpad", {
				Label = "Set the Bind-Key",
				Command = "prone_bindkey_key"
			})
		end)
	end)
end