-- Copyright 2016, George "Stalker" Petrou. Enjoy!
prone = prone or {}
prone.animations = prone.animations or {}
prone.config = prone.config or {}

-- YearMonthDay
prone.Version = 20161120

-- States
PRONE_GETTINGDOWN	= 0
PRONE_INPRONE		= 1
PRONE_GETTINGUP		= 2
PRONE_EXITTING		= 3
PRONE_NOTINPRONE	= 4

-- The impulse number to be used for toggling prone.
-- If anybody steals my number there will be hell to pay.
PRONE_IMPULSE = 127

hook.Add("Initialize", "prone.Initialize", function()
	if GAMEMODE.DerivedFrom == "clockwork" or GAMEMODE.DerivedFrom == "nutscript" then
		timer.Create("prone.Annoy", 10, 0, function()
			if SERVER then
				MsgC(Color(255, 20, 20), "The prone mod no longer supports Clockwork or Nutscript. Use an older version from the github: github.com/gspetrou/Prone-Mod/\n")
			else
				chat.AddText(Color(255, 20, 20), "The prone mod no longer supports Clockwork or Nutscript. Use an older version from the github: github.com/gspetrou/Prone-Mod/")
			end
		end)

		return
	end

	-- Make sure we load the files in the right order. Config then sh_prone then the rest.
	if SERVER then
		resource.AddWorkshop("775573383")

		AddCSLuaFile("prone/config.lua")
		AddCSLuaFile("prone/sh_prone.lua")
		AddCSLuaFile("prone/cl_prone.lua")

		include("prone/config.lua")
		include("prone/sh_prone.lua")
		include("prone/sv_prone.lua")
	else
		include("prone/config.lua")
		include("prone/sh_prone.lua")
		include("prone/cl_prone.lua")
	end
end)

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
				Command = "prone_jumptogetup"
			})

			panel:AddControl("Numpad", {
				Label = "Set the Bind-Key",
				Command = "prone_bindkey_key"
			})
		end)
	end)
end