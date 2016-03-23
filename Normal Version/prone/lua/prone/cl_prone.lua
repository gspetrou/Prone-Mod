-- Made by George "Stalker" Petrou, enjoy!

local GameMode
local Prone_LastBindKeyRelease = 0

CreateClientConVar("prone_bindkey_enabled", "1", true, false, "Set to 1 to enable pressing a key to go prone.")
CreateClientConVar("prone_bindkey_doubletap", "1", true, false, "If this is set to 1 then you must double tap the prone bind key.")
CreateClientConVar("prone_bindkey", tostring(prone.BindKey), true, false, "Set this to a IN_ enum number to change the prone bind key.")

net.Receive("Prone_StartProne", function()
	local ply = net.ReadEntity()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))		-- For prediction
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))
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

timer.Create("Prone_WaitForValidPlayers", .5, 0, function()
	if IsValid(LocalPlayer()) then
		timer.Simple(.25, function()
			net.Start("Prone_PlayerFullyLoaded")
			net.SendToServer()

			GameMode = string.lower(engine.ActiveGamemode())

			timer.Remove("Prone_WaitForValidPlayers")
		end)
	end
end)

net.Receive("Prone_LoadPronePlayersOnConnect", function()
	local PronePlayers = net.ReadTable()

	for i, v in ipairs(PronePlayers) do
		local ply = Entity(v)

		if IsValid(ply) then
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))		-- For prediction
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))
		end
	end
end)

net.Receive("Prone_CantExitProne", function()
	if GameMode ~= "combinecontrol" then
		chat.AddText(Color(210, 10, 10), "There isn't enough room to stand up!")
	else
		self:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
	end
end)

if prone.BindKeyEnabled then
	hook.Add("Move", "Prone_BindKey", function()
		if not (gui.IsConsoleVisible() or gui.IsGameUIVisible() or vgui.GetKeyboardFocus()) then
			if input.WasKeyPressed(prone.BindKey) and GetConVar("prone_bindkey_enabled"):GetInt() >= 1 then
				if GetConVar("prone_bindkey_doubletap"):GetInt() >= 1 then
					if CurTime() < Prone_LastBindKeyRelease then
						prone.ProneToggle()
					else
						Prone_LastBindKeyRelease = CurTime() + 1
					end
				else
					prone.ProneToggle()
				end
			end
		end
	end)
end

cvars.AddChangeCallback("prone_bindkey", function(cvar, oldVal, newVal)
	prone.BindKey = newVal
end)

local function Prone_ConfigUI()
	local frame = vgui.Create("DFrame")
	frame:SetSize(230, 140)
	frame:Center()
	frame:SetTitle("Prone Mod Config")
	frame:SetDraggable(true)
	frame:MakePopup()

	local toggle = vgui.Create("DCheckBoxLabel", frame)
	toggle:SetPos(15, 35)
	toggle:SetText("Enable the bind key")
	toggle:SizeToContents()
	toggle:SetValue(GetConVar("prone_bindkey_enabled"):GetInt())
	toggle:SetConVar("prone_bindkey_enabled")

	local doubletap = vgui.Create("DCheckBoxLabel", frame)
	doubletap:SetPos(15, 55)
	doubletap:SetText("Double tap the bind key to go prone")
	doubletap:SizeToContents()
	doubletap:SetValue(GetConVar("prone_bindkey_doubletap"):GetInt())
	doubletap:SetConVar("prone_bindkey_doubletap")

	local binder = vgui.Create("DBinder", frame)
	binder:SetSize(200, 50)
	binder:SetPos(15, 80)
	binder:SetSelected(prone.BindKey)
	function binder:SetSelectedNumber(num)
		self.m_iSelectedNumber = num
		GetConVar("prone_bindkey"):SetInt(num == 84 and prone.BindKey or num)	-- RControl doesn't work
	end
end
concommand.Add("prone_config", function() Prone_ConfigUI() end)

hook.Add("OnPlayerChat", "Prone_OpenClientConfig", function(ply, text)
	if text == "!proneconfig" or text == "/proneconfig" then
		Prone_ConfigUI()
	end
end)