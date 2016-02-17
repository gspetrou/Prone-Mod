-- Made by George "Stalker" Petrou, enjoy!

function prone.CreateFakeProneModel(ply, model, color, bodygroups)
	ply.ProneModel = ClientsideModel(model)
		ply.ProneModel:SetOwner(ply)
		ply.ProneModel:SetParent(ply)
		ply.ProneModel:AddEffects(EF_BONEMERGE)

		ply.ProneModel:Spawn()
		ply.ProneModel:Activate()

		ply.ProneModel:SetColor(color)

		ply:SetSequence("ProneDown_Stand")
		ply:SetCycle(0)
		ply:SetPlaybackRate(1)

		ply.ProneModel:SetBodyGroups(bodygroups)
end

concommand.Add("prone", function()
	net.Start("Prone_HandleProne")
	net.SendToServer()
end)

net.Receive("Prone_UpdateProneModel", function()
	local ply, model = net.ReadEntity(), net.ReadString()

	if ply.ProneModel then
		ply.ProneModel:SetModel(model)
	end
end)

net.Receive("Prone_StartProne", function()
	local ply, model, color, bodygroups = net.ReadEntity(), net.ReadString(), net.ReadColor(), net.ReadString()

	if IsValid(ply) then
		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))		-- For prediction
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))

		prone.CreateFakeProneModel(ply, model, color, bodygroups)
	end
end)

net.Receive("Prone_EndProne", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		if ply.ProneModel then
			ply.ProneModel:Remove()
			ply.ProneModel = nil
		end

		if ply:IsPlayer() then
			ply:ResetHull()	-- For prediction
		end
	else -- They disconnected or something
		for i, v in ipairs(ents.FindByClass("class C_BaseFlex")) do
		local owner = v:GetOwner()

		if not IsValid(owner) then
				v:Remove()
				v = nil
			end
		end
	end
end)

timer.Create("Prone_WaitForValidPlayers", .5, 0, function()
	if IsValid(LocalPlayer()) then
		timer.Simple(.25, function()
			net.Start("Prone_LoadPronedPlayers")
			net.SendToServer()

			timer.Remove("Prone_WaitForValidPlayers")
		end)
	end
end)

-- Where we put stuff that can't really be tested in a better way
-- An example is if a player leaves your pvs
timer.Create("Prone_ManageFakeModels", 1, 0, function()
	for i, v in ipairs(player.GetAll()) do
		if IsValid(v.ProneModel) then
			if v.ProneModel:GetParent() ~= v then
				v.ProneModel:SetParent(v)
			end

			if not v:Alive() then
				v.ProneModel:Remove()
				v.ProneModel = nil
			end
		end
	end
end)

net.Receive("Prone_SendWarningText", function()
	local text = net.ReadString()

	chat.AddText(Color(210, 10, 10), text)
end)