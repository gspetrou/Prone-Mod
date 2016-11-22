-- This file contains my gross attempts at adding support for other people's addons/gamemodes.
-- This file wont even load if prone.EnableAddonCompatibility is false.

-- Customizable Weaponry 2 view model support
if type(CustomizableWeaponry) == "table" then
	hook.Add("PlayerSwitchWeapon", "prone.CW2Support", function(ply, _, new)
		if type(new.Base) == "string" and string.sub(new.Base, 1, 3) == "cw_" then
			prone.ShouldModify.CalcViewModelView = false
		else
			prone.ShouldModify.CalcViewModelView = true
		end
	end)
end