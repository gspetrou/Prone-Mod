net.Receive("Prone.GetUpWarning", function()
	chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
end)

net.Receive("Prone.Entered", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
	end
end)

net.Receive("Prone.Exit", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:ResetHull()	-- For prediction
	end
end)

net.Receive("Prone.EndAnimation", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()
	end
end)

hook.Add("InitPostEntity", "Prone.WaitForInitialization", function()
	net.Start("Prone.PlayerFullyLoaded")
	net.SendToServer()
end)

net.Receive("Prone.PlayerFullyLoaded", function()
	local numplayers = net.ReadUInt(7)

	for i = 1, numplayers do
		local ply = net.ReadEntity()
		if IsValid(ply) then
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		end
	end
end)