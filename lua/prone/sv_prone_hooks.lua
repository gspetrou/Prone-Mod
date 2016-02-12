-- Made by George "Stalker" Petrou, enjoy!

local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()

net.Receive("Prone_HandleProne", function(len, ply)
	ply:HandleProne()
end)

hook.Add("PlayerInitialSpawn", "Prone_SetupVariables", function(ply)
	ply.Prone_LastBindKeyRelease = 0
	ply.Prone_LastProneRequestDelay = 0
end)

net.Receive("Prone_LoadPronedPlayers", function(len, ply)
	for i, v in ipairs(player.GetAll()) do
		if v:IsProne() then
			net.Start("Prone_StartProne")
				net.WriteEntity(v)
				net.WriteString(v.Prone_OldModel)
				net.WriteColor(Color(v.Prone_OldColor.r, v.Prone_OldColor.g, v.Prone_OldColor.b, v.Prone_OldColor.a))
			net.Send(ply)
		end
	end
end)

hook.Add("PlayerDisconnected", "Prone_CleanupFakeModels", function(ply)
	if ply:IsProne() then
		net.Start("Prone_EndProne")
		net.Broadcast()
	end
end)

hook.Add("PlayerLoadout", "Prone_ModelFix", function(ply)
	if ply:IsProne() then
		ply.Prone_OldModel = ply:GetModel()
		prone.UpdateProneModel(ply, ply.Prone_OldModel)

		ply:SetModel("models/player/p_kleiner.mdl")

		ply.Prone_OldWalkSpeed = ply:GetWalkSpeed()
		ply.Prone_OldRunSpeed = ply:GetRunSpeed()
		ply.Prone_CanAltWalk = ply:GetCanWalk()
		ply.Prone_OldColor = ply:GetColor()

		ply:SetWalkSpeed(prone.ProneSpeed)
		ply:SetRunSpeed(prone.ProneSpeed)
		ply:SetCanWalk(false)
	end
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
		elseif not ply.Prone_AnimWaterFix and ply:WaterLevel() > 1 then
			prone.EndProne(ply)
			ply.Prone_AnimWaterFix = true
		end
	end
end)

hook.Add("PlayerFootstep", "Prone_MuteFootstepSound", function(ply)
	return ply:IsProne()
end)

if GameMode == "terrortown" then
	hook.Add("TTTPrepareRound", "Prone_FixRemove", function()
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				prone.EndProne(v)
			end
		end
	end)

	hook.Add("TTTBeginRound", "Prone_FixRemove", function()
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				prone.EndProne(v)
			end
		end
	end)
end