-- This file adds various checks and fixes depending on the gamemode and thirdparty addons.

-- Checked for prone.CanEnter depending on the gamemode.
if DarkRP or GAMEMODE_NAME == "darkrp" or GAMEMODE.DerivedFrom == "darkrp" then
	hook.Add("prone.CanEnter", "prone.CanEnterDarkRP", function(ply)
		if prone.Config.Darkrp_RestrictJobs then
			local rank = ply:GetUserGroup()
			for i, v in ipairs(prone.Config.Darkrp_BypassRanks) do
				if v == rank then
					return true
				end
			end

			local ply_darkrpjob = ply:Team()
			for i, v in ipairs(prone.Config.Darkrp_Joblist) do
				if ply_darkrpjob == v then
					if prone.Config.Darkrp_IsWhitelist then
						return true
					else
						return false
					end
				end
			end

			-- If their job was not on the list and that list was not a whitelist then they can go prone.
			return not prone.Config.Darkrp_IsWhitelist
		end

		return true
	end)

elseif GAMEMODE_NAME == "prop_hunt" or GAMEMODE.DerivedFrom == "prop_hunt" then
	hook.Add("prone.CanEnter", "prone.CanEnterPropHunt", function(ply)
		if not GetGlobalBool("InRound", false) or (GetGlobalFloat("RoundStartTime", 0) + (HUNTER_BLINDLOCK_TIME or 0)) > CurTime() or ply:Team() ~= TEAM_HUNTERS then
			return false
		else
			return true
		end
	end)

elseif Clockwork then
	hook.Add("prone.CanEnter", "prone.CanEnterClockwork", function(ply)
		return not ply:IsRagdolled()
	end)
end

-- Disable viewmodel calcview for CW2.0
hook.Add("prone.ShouldChangeCalcViewModelView", "prone.DisableForCW2", function(localply)
	if CustomizableWeaponry then
		local weapon = localply:GetActiveWeapon()
		if IsValid(weapon) and weapon.CW20Weapon then
			return false
		end
	end
end)


-- TTT Movement support
hook.Add("TTTPlayerSpeed", "prone.RestrictMovement", function(ply)
	if ply:IsProne() then
		return prone.Config.MoveSpeed / 220	-- 220 is the default run speed in TTT
	end
end)

-- CombineControl's weird chatbox support.
if CLIENT and (GAMEMODE_NAME == "combinecontrol" or GAMEMODE.DerivedFrom == "combinecontrol") then
	local lastGetUpPrintTime = 0		-- Last time a print was made.
	local getUpWarningPrintDelay = 2	-- Time it takes before allowing another print.
	function prone.CantGetUpWarning()
		local ct = CurTime()

		if lastGetUpPrintTime < ct then
			GAMEMODE:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
			lastGetUpPrintTime = ct + getUpWarningPrintDelay
		end
	end
end

-- Disable ragdolling while prone to avoid dealing with annoying stuff.
-- This is untested but honestly Im not giving any attention to a commercial, non open-source, out-dated gamemode.
hook.Add("PlayerCanRagdoll", "prone.FixClockworkRagdoll", function(ply)
	if ply:IsProne() then
		return false
	end
end)