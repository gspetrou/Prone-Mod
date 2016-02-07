-- Made by George "Stalker" Petrou, enjoy!

function prone.CreateFakeProneModel(ply, model, color)
	if not IsValid(ply) then return end

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
end

concommand.Add("prone", function()
	net.Start("Prone_HandleProne")
	net.SendToServer()
end)

net.Receive("Prone_StartProne", function()
	local ply, model, color = net.ReadEntity(), net.ReadString(), net.ReadColor()

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))

	prone.CreateFakeProneModel(ply, model, color)
end)

net.Receive("Prone_EndProne", function()
	local ply = net.ReadEntity()

	if ply.ProneModel then
		ply.ProneModel:Remove()
		ply.ProneModel = nil
	end

	ply:ResetHull()
end)