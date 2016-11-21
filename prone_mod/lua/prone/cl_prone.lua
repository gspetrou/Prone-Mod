local LocalPlayer, CurTime, system_IsLinux, system_HasFocus, vgui_GetKeyboardFocus, gui_IsGameUIVisible, gui_IsConsoleVisible, math_min, Vector = LocalPlayer, CurTime, system.IsLinux, system.HasFocus, vgui.GetKeyboardFocus, gui.IsGameUIVisible, gui.IsConsoleVisible, math.min, Vector

-- Initialize other prone players when we finish connecting
hook.Add("InitPostEntity", "prone.PlayerInitialized", function()
	for i, v in ipairs(player.GetAll()) do
		v.prone = v.prone or {}
		v.prone.oldviewoffset = v.prone.oldviewoffset or Vector(0, 0, 64)
		v.prone.oldviewoffset_ducked = v.prone.oldviewoffset_ducked or Vector(0, 0, 64)

		if v:IsProne() then
			v:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
			v:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
		end
	end
end)

local CantGetUpWarning
if GAMEMODE_NAME == "combinecontrol" or GAMEMODE.DerivedFrom == "combinecontrol" then
	CantGetUpWarning = function()
		GAMEMODE:AddChat(Color(210, 10, 10, 255), "CombineControl.ChatNormal", "There isn't enough room to stand up!", {CB_ALL, CB_IC})
	end
else
	CantGetUpWarning = function()
		chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
	end
end

net.Receive("prone.GetUpWarning", function()
	CantGetUpWarning()
end)

-------------------------
-- Requesting to go prone
-------------------------
function prone.SetImpulse(cmd)
	cmd:SetImpulse(PRONE_IMPULSE)
end

function prone.Request()
	LocalPlayer().prone.WantsToToggle = true
	net.Start("prone.Request")
	net.SendToServer()
end

concommand.Add("prone", function()
	prone.Request()
end)

-------------------
-- Bind key handler
-------------------
local function boolToNumString(bool)
	return bool and "1" or "0"
end
local bindkey_enabled = CreateClientConVar("prone_bindkey_enabled", boolToNumString(prone.DefaultBindKey_Enabled), true, false, "Disable this to disable the prone bind key from working.")
local bindkey_key = CreateClientConVar("prone_bindkey_key", tostring(prone.DefaultBindKey), true, false, "Don't directly change this convar. Use the command prone_config.")
local bindkey_doubletap = CreateClientConVar("prone_bindkey_doubletap", boolToNumString(prone.DefaultBindKey_DoubleTap), true, false, "Enable to make them double tap the bind key to go prone.")
local jumptogetup = CreateClientConVar("prone_jumptogetup", "1", boolToNumString(prone.DefaultJumpToGetUp), false, "If enabled you can press the jump key to get up.")
local jumptogetup_doubletap = CreateClientConVar("prone_jumptogetup_doubletap", boolToNumString(prone.DefaultJumpToGetUp_DoubleTap), true, false, "If enabled you must double press jump to get up.")

local key_waspressed = false
local last_prone_request = 0
local doubletap_shouldsend = true
local doubletap_keypress_resettime = false

hook.Add("CreateMove", "prone.ReadBindKeys", function(cmd)
	local ply = LocalPlayer()
	if not IsValid(ply) then
		return
	end

	if ply.prone.WantsToToggle then
		prone.SetImpulse(cmd)
	end

	if (system_IsLinux() or system_HasFocus()) and bindkey_enabled:GetBool() and ply:OnGround() and not vgui_GetKeyboardFocus() and not gui_IsGameUIVisible() and not gui_IsConsoleVisible() then
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


-------------------
-- View Transitions
-------------------
local transitionSpeed = 40
local transitionVector = vector_origin
local transitionVectorZ = 0
local lastTime = 0
local reset = false
hook.Add("CalcView", "prone.ViewTransitions", function(ply, pos)
	if ply ~= LocalPlayer() then
		return
	end
	ply.prone = ply.prone or {
		oldviewoffset = Vector(0, 0, 64)
	}

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
	transitionVectorZ = math_min(transitionVectorZ, (ply.prone.oldviewoffset.z or 64) - prone.config.View.z)

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
end)
hook.Add("CalcViewModelView", "prone.ViewTransitions", function()
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