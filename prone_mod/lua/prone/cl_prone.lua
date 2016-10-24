-- Copyright 2016 George "Stalker" Petrou, enjoy!
if GAMEMODE_NAME == "combinecontrol" or GAMEMODE.DerivedFrom == "combinecontrol" then
	net.Receive("Prone.GetUpWarning", function()
		GAMEMODE:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
	end)
else
	net.Receive("Prone.GetUpWarning", function()
		chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
	end)
end

net.Receive("Prone.Entered", function()
	local ply = net.ReadPlayer()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

		if prone.IsCompatibility() then
			local model, clr, bodygroups, playercolor, playerskin = net.ReadString(), net.ReadColor(), net.ReadString(), net.ReadVector(), net.ReadUInt(5)
			prone.CreateFakeModel(ply, model, clr, bodygroups, playerskin, playercolor)
		end
	end
end)

net.Receive("Prone.Exit", function()
	local ply = net.ReadPlayer()

	if IsValid(ply) then
		ply:AnimRestartMainSequence()
		ply:ResetHull()	-- For prediction

		if prone.IsCompatibility() and IsValid(ply.prone.cl_model) then
			ply.prone.cl_model:Remove()
			ply.prone.cl_model = nil
		end
	elseif prone.IsCompatibility() then
		for i, v in ipairs(ents.FindByClass("class C_BaseFlex")) do
			local owner = v:GetOwner()

			if not IsValid(owner) then
				v:Remove()
				v = nil
			end
		end
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

			if prone.IsCompatibility() then
				local model, clr, bodygroups, playercolor, playerskin = net.ReadString(), net.ReadColor(), net.ReadString(), net.ReadVector(), net.ReadUInt(5)
				prone.CreateFakeModel(ply, model, clr, bodygroups, playerskin, playercolor)
			end
		end
	end
end)

function prone.Request()
	net.Start("Prone.RequestedProne")
	net.SendToServer()
end

local bindkey_enabled = CreateClientConVar("prone_bindkey_enabled", "1", true, false, "Disable this to disable the prone bind key from working.")
local bindkey_key = CreateClientConVar("prone_bindkey_key", tostring(KEY_LCONTROL), true, false, "Don't directly change this convar. Use the command prone_config.")
local bindkey_doubletap = CreateClientConVar("prone_bindkey_doubletap", "1", true, false, "Enable to make them double tap the bind key to go prone.")
local jumptogetup = CreateClientConVar("prone_jumptogetup", "1", true, false, "If enabled you can press the jump key to get up.")
local jumptogetup_doubletap = CreateClientConVar("prone_jumptogetup_doubletap", "1", true, false, "If enabled you must double press jump to get up.")

local key_waspressed = false
local last_prone_request = 0
local doubletap_shouldsend = true
local doubletap_keypress_resettime = false
hook.Add("Think", "Prone.BindkeySingleClick", function()
	-- The shit I do so that kiddies can use their beloved KEY enums
	if bindkey_enabled:GetBool() and LocalPlayer():IsFlagSet(FL_ONGROUND) and not system.IsLinux() and system.HasFocus() and not vgui.GetKeyboardFocus() and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
		if input.IsKeyDown(bindkey_key:GetInt()) then
			key_waspressed = true

			-- If doubletap is enabled they have a second to double click the bind key.
			doubletap_keypress_resettime = CurTime() + 1
		else
			if key_waspressed then
				if last_prone_request < CurTime() then
					doubletap_shouldsend = not doubletap_shouldsend

					if not bindkey_doubletap:GetBool() or doubletap_shouldsend then
						prone.Request()

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

local jumptogetup_presstime = 0
hook.Add("KeyPress", "Prone.JumpToGetUp", function(ply, key)
	if IsFirstTimePredicted() and ply == LocalPlayer() and ply:IsProne() and jumptogetup:GetBool() and key == IN_JUMP then
		if not jumptogetup_doubletap:GetBool() then
			prone.Request()
		else
			if jumptogetup_presstime > CurTime() then
				prone.Request()
			else
				jumptogetup_presstime = CurTime() + 1.25
			end
		end
	end
end)

concommand.Add("prone", function()
	prone.Request()
end)

concommand.Add("prone_config", function()
	local frame = vgui.Create("DFrame")
	frame:SetSize(200, 210)
	frame:Center()
	frame:SetTitle("Prone Mod Config")
	frame:MakePopup()

	local bindkey_enabled_checkbox = vgui.Create("DCheckBoxLabel", frame)
	bindkey_enabled_checkbox:SetText("Enable bind key")
	bindkey_enabled_checkbox:SetPos(10, 30)
	bindkey_enabled_checkbox:SetValue(bindkey_enabled:GetInt())
	function bindkey_enabled_checkbox:OnChange(bool)
		RunConsoleCommand("prone_bindkey_enabled", bool and "1" or "0")
	end

	local bindkey_double_checkbox = vgui.Create("DCheckBoxLabel", frame)
	bindkey_double_checkbox:SetText("Double tap bind key")
	bindkey_double_checkbox:SetPos(10, 50)
	bindkey_double_checkbox:SetValue(bindkey_doubletap:GetInt())
	function bindkey_double_checkbox:OnChange(bool)
		RunConsoleCommand("prone_bindkey_doubletap", bool and "1" or "0")
	end

	local jump_getup = vgui.Create("DCheckBoxLabel", frame)
	jump_getup:SetText("Press jump to get up")
	jump_getup:SetPos(10, 70)
	jump_getup:SetValue(jumptogetup:GetInt())
	function jump_getup:OnChange(bool)
		RunConsoleCommand("prone_jumptogetup", bool and "1" or "0")
	end

	local jump_getup_double = vgui.Create("DCheckBoxLabel", frame)
	jump_getup_double:SetText("Double tap jump to get up")
	jump_getup_double:SetPos(10, 90)
	jump_getup_double:SetValue(jumptogetup_doubletap:GetInt())
	function jump_getup_double:OnChange(bool)
		RunConsoleCommand("prone_jumptogetup_doubletap", bool and "1" or "0")
	end

	local bindkey_desc = vgui.Create("DLabel", frame)
	bindkey_desc:SetText("Prone bind key:")
	bindkey_desc:SizeToContents()
	bindkey_desc:SetPos(10, 110)

	local binder = vgui.Create("DBinder", frame)
	binder:SetSize(150, 50)
	binder:SetPos(25, 130)
	binder:CenterHorizontal()
	binder:SetValue(bindkey_key:GetInt())
	function binder:SetSelected(num)
		RunConsoleCommand("prone_bindkey_key", num)
		self:SetText(input.GetKeyName(num))
	end

	local resetbutton = vgui.Create("DButton", frame)
	resetbutton:SetText("Reset settings")
	resetbutton:SetPos(0, 190)
	resetbutton:SetSize(200, 20)
	function resetbutton:DoClick()
		RunConsoleCommand("prone_bindkey_enabled", "1")
		RunConsoleCommand("prone_bindkey_key", tostring(KEY_LCONTROL))
		RunConsoleCommand("prone_bindkey_doubletap", "1")
		RunConsoleCommand("prone_jumptogetup", "1")
		RunConsoleCommand("prone_jumptogetup_double", "1")
		self:Remove()
	end
end)

if prone.IsCompatibility() then
	function prone.CreateFakeModel(ply, model, clr, bodygrp, plyskin, playercolor)
		ply.prone.cl_model = ClientsideModel(model, clr == color_white and RENDERGROUP_OPAQUE or RENDERGROUP_TRANSLUCENT)
		ply.prone.cl_model.pronemodel = true
		ply.prone.cl_model:SetOwner(ply)
		ply.prone.cl_model:SetParent(ply)
		ply.prone.cl_model:AddEffects(EF_BONEMERGE)

		ply.prone.cl_model:Spawn()
		ply.prone.cl_model:Activate()

		ply.prone.cl_model:SetColor(clr)
		ply.prone.cl_model:SetBodyGroups(bodygrp)

		ply.prone.cl_model:SetSkin(plyskin)
		ply.prone.cl_model.GetPlayerColor = function()
			return playercolor
		end
	end

	timer.Create("Prone.ManageFakeModels", 1, 0, function()
		for i, v in ipairs(player.GetAll()) do
			if IsValid(v.prone.cl_model) then
				if v.prone.cl_model:GetParent() ~= v then
					v.prone.cl_model:SetParent(v)
				end

				if not v:Alive() then
					v.prone.cl_model:Remove()
					v.prone.cl_model = nil
				end
			end
		end
	end)

	net.Receive("Prone.UpdateModel", function()
		local ply, model = net.ReadPlayer(), net.ReadString()
		if IsValid(ply) and IsValid(ply.prone.cl_model) then
			ply.prone.cl_model:SetModel(model)
		end
	end)
end