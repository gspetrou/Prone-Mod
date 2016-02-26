function PLUGIN:PostPlayerSpawn(ply, lightSpawn, changeClass, firstSpawn)
	if ply:IsProne() then
		if not ply:GetSharedVar("FallenOver") then
			ply.Prone_OldModel = ply:GetModel()

			if not lightSpawn then
				prone.EndProne(ply, true)
			else
				prone.UpdateProneModel(ply, ply.Prone_OldModel)
				ply:SetModel("models/player/p_kleiner.mdl")
				ply.Prone_OldColor = ply:GetColor()
			end
		end
	end
end

function PLUGIN:PlayerModelChanged(ply, model)
	if ply:IsProne() and model ~= "models/player/p_kleiner.mdl" then
		ply.Prone_OldModel = model
		ply.Prone_OldColor = ply:GetColor()
		prone.UpdateProneModel(ply, ply.Prone_OldModel)

		timer.Simple(.1, function()
			if ply:IsProne() then
				ply:SetModel("models/player/p_kleiner.mdl")
			end
		end)
	end
end

function PLUGIN:PlayerRagdolled(ply, state, ragdollInfo)
	if ply:IsProne() then
		ragdollInfo.entity:SetModel(ply.Prone_OldModel)
		ragdollInfo.entity:GetPhysicsObject():EnableCollisions(false)
	end
end

function PLUGIN:PlayerUnragdolled(ply, state, ragdollInfo)
	if ply:IsProne() then
		prone.EndProne(ply, true)
		ply.ProneModel:SetColor(ply.Prone_OldColor)
	end
end