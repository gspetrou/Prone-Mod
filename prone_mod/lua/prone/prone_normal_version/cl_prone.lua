-- Copyright 2016 George "Stalker" Petrou, enjoy!

local GameMode

CreateClientConVar("prone_bindkey_enabled", "1", true, true, "If set to 0 clicking the prone bind key wont do anything.")

net.Receive("Prone_StartProne", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))		-- For prediction
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
	end
end)

net.Receive("Prone_EndProne", function()
	local ply = net.ReadEntity()

	if IsValid(ply) and ply:IsPlayer() then
		ply:AnimRestartMainSequence()

		ply:ResetHull()	-- For prediction
	end
end)

net.Receive("Prone_EndProneAnimation", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()
	end
end)

concommand.Add("prone", function()
	prone.ProneToggle()
end)

function prone.ProneToggle()
	net.Start("Prone_HandleProne")
	net.SendToServer()
end

net.Receive("Prone_LoadPronePlayersOnConnect", function()
	local PronePlayers = net.ReadTable()

	for i, v in ipairs(PronePlayers) do
		local ply = Entity(v)

		if IsValid(ply) then
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))		-- For prediction
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
		end
	end
end)

net.Receive("Prone_CantExitProne", function()
	if GameMode ~= "combinecontrol" then
		chat.AddText(Color(210, 10, 10), "There isn't enough room to stand up!")
	else
		GAMEMODE:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
	end
end)

hook.Add("InitPostEntity", "Prone_InitPostEntity", function()
	net.Start("Prone_PlayerFullyLoaded")
	net.SendToServer()
	GameMode = string.lower(engine.ActiveGamemode())		
end)
