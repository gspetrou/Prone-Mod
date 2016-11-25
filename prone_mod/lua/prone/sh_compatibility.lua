-- This file contains extra compatibility for certain addons.

-- Customizable Weaponry 2 support.
if CLIENT and type(CustomizableWeaponry) == "table" then
	local function HandleCWWeapon(weapon)
		if weapon.CW20Weapon then
			prone.DisableCalcViewModelView = true
		else
			prone.DisableCalcViewModelView = false
		end
	end
	hook.Add("PlayerSwitchWeapon", "prone.CWSupport", function(_, _, new)
		HandleCWWeapon(new)
	end)
	hook.Add("HUDWeaponPickedUp", "prone.CWSupport", HandleCWWeapon)

	gameevent.Listen("player_spawn")
	hook.Add("player_spawn", "prone.CWSupport", function(uid)
		local ply = Entity(uid.userid)
		if not (IsValid(LocalPlayer()) and IsValid(ply) and ply == LocalPlayer()) then
			return
		end
		
		local weapon = ply:GetActiveWeapon()
		if IsValid(weapon) then
			HandleCWWeapon(weapon)
		end
	end)
end