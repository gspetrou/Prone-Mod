-- Made by George "Stalker" Petrou, enjoy!

local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()

net.Receive("Prone_HandleProne", function(len, ply)
	ply:HandleProne()
end)

hook.Add("PlayerInitialSpawn", "Prone_SetupVariables", function(ply)
	ply.Prone_LastBindKeyRelease = 0
	ply.Prone_LastProneRequestDelay = 0
end)

if prone.BindKey then
	if prone.BindKeyDoubleTap then
		hook.Add("KeyRelease", "Prone_BindKeyRelease", function(ply, key)
			if IsFirstTimePredicted() and key == prone.BindKey then
				if CurTime() < ply.Prone_LastBindKeyRelease then
					ply:HandleProne()
				else
					ply.Prone_LastBindKeyRelease = CurTime() + 1
				end
			end
		end)
	else
		hook.Add("KeyPress", "Prone_BindKeyPress", function(ply, key)
			if IsFirstTimePredicted() and key == prone.BindKey then
				prone.HandleProne(ply)
			end
		end)
	end
end

hook.Add("DoPlayerDeath", "Prone_ExitOnDeath", function(ply)
	if IsFirstTimePredicted() and ply:IsProne() then
		prone.EndProne(ply, true)
	end
end)

hook.Add("PlayerNoClip", "Prone_ExitOnEnterNoclip", function(ply)
	if IsFirstTimePredicted() and ply:IsProne() then
		prone.EndProne(ply, true)
	end
end)

hook.Add("VehicleMove", "Prone_ExitOnEnterVehicle", function(ply)
	if IsFirstTimePredicted() and ply:IsProne() then
		prone.EndProne(ply, true)
	end
end)

hook.Add("PlayerTick", "Prone_ExitProneOnConditions", function(ply)
	if IsFirstTimePredicted() and ply:IsProne() then
		if ply:IsRagdoll() or ply:InVehicle() then
			prone.EndProne(ply, true)
		elseif ply:WaterLevel() > 1 then
			prone.EndProne(ply, false)
		end
	end
end)

hook.Add("PlayerFootstep", "Prone_MuteFootstepSound", function(ply)
	return ply:IsProne()
end)