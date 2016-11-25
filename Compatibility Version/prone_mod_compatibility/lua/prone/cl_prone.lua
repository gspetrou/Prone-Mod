-- Micro-optimize!
local CurTime, LocalPlayer, IsValid, math_min, Vector = CurTime, LocalPlayer, IsValid, math.min, Vector

-- Support for CombineControl's stupid chat system.
if GAMEMODE_NAME == "combinecontrol" or GAMEMODE.DerivedFrom == "combinecontrol" then
	net.Receive("Prone.GetUpWarning", function()
		GAMEMODE:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
	end)
else
	net.Receive("Prone.GetUpWarning", function()
		chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
	end)
end

-- When a player enters prone update their hull, reset the animation cycle, and if necessary make a fake model.
local OriginalViewOffset = vector_origin
net.Receive("Prone.Entered", function()
	local ply = net.ReadPlayer()

	if IsValid(ply) then
		ply.prone = ply.prone or {}

		ply:AnimRestartMainSequence()

		if ply == LocalPlayer() then
			ply.prone.oldviewoffset = ply:GetViewOffset()
			ply.prone.oldviewoffset_ducked = ply:GetViewOffsetDucked()
			OriginalViewOffsetZ = ply.prone.oldviewoffset.z
		end

		ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

		if prone.IsCompatibility() then
			local model, clr, bodygroups, playercolor, playerskin = net.ReadString(), net.ReadColor(), net.ReadString(), net.ReadVector(), net.ReadUInt(5)
			prone.CreateFakeModel(ply, model, clr, bodygroups, playerskin, playercolor)
		end
	end
end)

-- If the player is valid simply restart their animation cycle, reset their hull, and if necessary remove their fake model.
-- If they are not valid it means that they disconnected. If that is the case then (if applicable) find and remove their fake model.
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

-- Other player entities are now valid, lets set up the ones which are prone.
hook.Add("InitPostEntity", "Prone.PlayerInitialized", function()
	for i, v in ipairs(player.GetAll()) do
		v.prone = v.prone or {}
	end

	if prone.IsCompatibility() then
		net.Start("Prone.PlayerInitialized")
		net.SendToServer()
	else
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				v:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
				v:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
			end
		end
	end
end)
net.Receive("Prone.PlayerInitialized", function()
	local numplayers = net.ReadUInt(7)
	local is_compatibility = prone.IsCompatibility()

	for i = 1, numplayers do
		local ply = net.ReadPlayer()
		if IsValid(ply) then
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

			if is_compatibility then
				local model, clr, bodygroups, playercolor, playerskin = net.ReadString(), net.ReadColor(), net.ReadString(), net.ReadVector(), net.ReadUInt(5)
				prone.CreateFakeModel(ply, model, clr, bodygroups, playerskin, playercolor)
			end
		end
	end
end)

-- Simply resets the animation cycle for a player.
-- This is important so that when you change animation it doesn't start the next one mid-way.
net.Receive("Prone.ResetMainAnimation", function()
	local ply = net.ReadPlayer()
	if IsValid(ply) then
		ply:AnimRestartMainSequence()
	end
end)

-- Simple functions for requesting to go prone.
function prone.Request()
	net.Start("Prone.RequestProne")
	net.SendToServer()
end
concommand.Add("prone", function()
	prone.Request()
end)

--------------------------
-- Configurable prone keys
--------------------------
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
	-- Oh boy... This really long line pretty much checks if their game has focus, if they want the prone bind key enabled,
	-- if they are on the ground, and if it is a good time to read their key presses.
	if (system.IsLinux() or system.HasFocus()) and bindkey_enabled:GetBool() and LocalPlayer():IsFlagSet(FL_ONGROUND) and not vgui.GetKeyboardFocus() and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
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

-- See if they pressed the IN_JUMP key to get up.
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


-------------------
-- View Transitions
-------------------
local transitionSpeed = 40
local transitionVector = vector_origin
local transitionVectorZ = 0
local lastTime = 0
local reset = false

hook.Add("CalcView", "Prone.ViewTransitions", function(ply, pos)
	if ply:IsProne() then
		-- Wait till the second time this is called to translate downwards.
		local time = CurTime()
		if lastTime == 0 then
			lastTime = time
			reset = false
			return
		end

		-- Calculate a new Z value slightly lower than before.
		-- transitionVectorZ is the amount we are going down by.
		transitionVectorZ = transitionVectorZ + (transitionSpeed * (time - lastTime))
		lastTime = time
		transitionVectorZ = math_min(transitionVectorZ, OriginalViewOffsetZ - prone.config.View.z)

		local animstate = ply:GetProneAnimationState()
		if animstate == PRONE_GETTINGDOWN then
			transitionVector = Vector(pos.x, pos.y, pos.z - transitionVectorZ)
		elseif animstate == PRONE_GETTINGUP then
			transitionVector = Vector(pos.x, pos.y, pos.z + transitionVectorZ)
		elseif not reset then
			transitionVector = vector_origin
			transitionVectorZ = 0
			lastTime = 0
			reset = true
			return
		end
		
		return {origin = transitionVector}
	elseif not reset then
		transitionVector = vector_origin
		transitionVectorZ = 0
		lastTime = 0
		reset = true
	end
end)
hook.Add("CalcViewModelView", "Prone.ViewTransitions", function()
	local animstate = LocalPlayer():GetProneAnimationState()
	if animstate == PRONE_GETTINGDOWN then
		return transitionVector
	elseif animstate == PRONE_GETTINGUP then
		return transitionVector
	end
end)


-------------------------------------------------
-- A derma panel for configuring your prone keys.
-------------------------------------------------
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
	-- Creates a fake model and bonemerges it to the player to make it seem alive.
	function prone.CreateFakeModel(ply, model, clr, bodygrp, plyskin, playercolor)
		ply.prone = ply.prone or {}

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

	-- Receiver for when we want to update this fake model.
	net.Receive("Prone.UpdateModel", function()
		local ply, model = net.ReadPlayer(), net.ReadString()
		if IsValid(ply) and IsValid(ply.prone.cl_model) then
			ply.prone.cl_model:SetModel(model)
		end
	end)
end