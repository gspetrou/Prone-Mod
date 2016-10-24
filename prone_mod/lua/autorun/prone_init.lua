-- Copyright 2016 George "Stalker" Petrou, enjoy!
prone = prone or {}
prone.config = prone.config or {}
prone.animations = prone.animations or {}

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

CreateConVar("prone_compatibility", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enable this to gurantee model support. This feature is experimental and probably unstable.")
cvars.AddChangeCallback("prone_compatibility", function(convar, old, new)
	MsgC(Color(240, 20, 20), "Change the map to ".. (new == "1" and "enable" or "disable") .." compatibility mode!\n")
end)

hook.Add("Initialize", "Prone.Initialize", function()
	local compatibility = GetConVar("prone_compatibility"):GetBool() == true or GAMEMODE.DerivedFrom == "clockwork" or GAMEMODE.DerivedFrom == "nutscript"

	function prone.IsCompatibility()
		return compatibility
	end

	if SERVER then
		resource.AddWorkshop("775573383")

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

-- This has to be ran here because after initialize is too late.
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