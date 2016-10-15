net.Receive("Prone.GetUpWarning", function()
	chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
end)

net.Receive("Prone.Entered", function()
	local ply = net.ReadPlayer()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
	end
end)

net.Receive("Prone.Exit", function()
	local ply = net.ReadPlayer()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:ResetHull()	-- For prediction
	end
end)

net.Receive("Prone.EndAnimation", function()
	local ply = net.ReadPlayer()

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
		local ply = net.ReadPlayer()
		if IsValid(ply) then
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		end
	end
end)

local key_waspressed = false
local last_prone_request = 0
local doubletap_shouldsend = true
local doubletap_keypress_resettime = false
hook.Add("Think", "Prone.BindkeySingleClick", function()
	-- The shit I do so that kiddies can use their beloved KEY enums
	if LocalPlayer():IsFlagSet(FL_ONGROUND) and not system.IsLinux() and system.HasFocus() and not vgui.GetKeyboardFocus() and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
		if input.IsKeyDown(prone.config.BindKey) then
			key_waspressed = true

			-- If doubletap is enabled they have a second to double click the bind key.
			doubletap_keypress_resettime = CurTime() + 1
		else
			if key_waspressed then
				if last_prone_request < CurTime() then
					doubletap_shouldsend = not doubletap_shouldsend
					
					if not prone.config.BindKey_DoubleClick or doubletap_shouldsend then
						net.Start("Prone.RequestedProne")
						net.SendToServer()

						last_prone_request = CurTime() + 1.25
					end
				end

				key_waspressed = false
			end
		end

		if doubletap_keypress_resettime ~= false and doubletap_keypress_resettime < CurTime() then
			doubletap_keypress_resettime = false
			doubletap_shouldsend = true
		end
	end
end)

concommand.Add("prone", function()
	net.Start("Prone.RequestedProne")
	net.SendToServer()
end)