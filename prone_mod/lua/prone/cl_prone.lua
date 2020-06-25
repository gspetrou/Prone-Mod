prone.ClientsideModelCache = prone.ClientsideModelCache or {}

hook.Add("EntityNetworkedVarChanged", "prone.DetectProneStateChanges", function(ply, nwVarName, oldVal, newVal)
	if nwVarName == "prone.AnimationState" then
		if newVal == PRONE_GETTINGDOWN or newVal == PRONE_GETTINGUP then
			ply:AnimRestartMainSequence()
			ply:SetCycle(0)
			ply:SetPlaybackRate(1)
		elseif newVal == PRONE_NOTINPRONE then
			ply:ResetHull()
		end
	end
end)

-- Called to inform the player that they can't get up.
local lastGetUpPrintTime = 0		-- Last time a print was made.
local getUpWarningPrintDelay = 2	-- Time it takes before allowing another print.
function prone.CantGetUpWarning()
	local ct = CurTime()

	if lastGetUpPrintTime < ct then
		chat.AddText(Color(210, 10, 10), "There is not enough room to get up here.")
		lastGetUpPrintTime = ct + getUpWarningPrintDelay
	end
end

--------------------
-- prone.SetImpulse
--------------------
-- Desc:		This is the proper, predicted, way to toggle prone.
-- Arg One:		CUserCmd object, to set the impulse on.
function prone.SetImpulse(cmd)
	cmd:SetImpulse(PRONE_IMPULSE)
end

-----------------
-- prone.Request
-----------------
-- Desc:		Begins sending a prone impulse to the server.
local SendImpulse = false
function prone.Request()
	SendImpulse = true
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
local bindkey_enabled = CreateClientConVar("prone_bindkey_enabled", boolToNumString(prone.Config.DefaultBindKey_Enabled), true, false, "Disable this to disable the prone bind key from working.")
local bindkey_key = CreateClientConVar("prone_bindkey_key", tostring(prone.Config.DefaultBindKey), true, false, "Don't directly change this convar. Use the command prone_config.")
local bindkey_doubletap = CreateClientConVar("prone_bindkey_doubletap", boolToNumString(prone.Config.DefaultBindKey_DoubleTap), true, false, "Enable to make them double tap the bind key to go prone.")
local jumptogetup = CreateClientConVar("prone_jumptogetup", "1", boolToNumString(prone.Config.DefaultJumpToGetUp), false, "If enabled you can press the jump key to get up.")
local jumptogetup_doubletap = CreateClientConVar("prone_jumptogetup_doubletap", boolToNumString(prone.Config.DefaultJumpToGetUp_DoubleTap), true, false, "If enabled you must double press jump to get up.")

local key_waspressed = false
local last_prone_request = 0
local doubletap_shouldsend = true
local doubletap_keypress_resettime = false
hook.Add("CreateMove", "prone.ReadBindKeys", function(cmd)
	local ply = LocalPlayer()
	if not IsValid(ply) then
		return
	end

	if SendImpulse then
		prone.SetImpulse(cmd)

		if cmd:TickCount() ~= 0 then
			SendImpulse = false
		end
	end

	if (system.IsLinux() or system.HasFocus()) and bindkey_enabled:GetBool() and ply:OnGround() and not vgui.GetKeyboardFocus() and not gui.IsGameUIVisible() and not gui.IsConsoleVisible() then
		if input.IsKeyDown(bindkey_key:GetInt()) then
			key_waspressed = true

			-- If doubletap is enabled they have a second to double click the bind key.
			doubletap_keypress_resettime = CurTime() + .66
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

-- If they enable jump to get up then read that here.
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
local enabledViewTransitions = CreateClientConVar("prone_disabletransitions", "0", true, false, "Should only be used by other addons in order to enable/disable the prone mod handling view transitions.")

local transitionSpeed = 40
local transitionVector = vector_origin
local transitionVectorZ = 0
local lastTime = 0
local reset = false
hook.Add("CalcView", "prone.ViewTransitions", function(ply, pos)
	if ply ~= LocalPlayer() or enabledViewTransitions:GetBool() then
		return
	end
	
	local result = hook.Run("prone.ShouldChangeCalcView", localply)
	if result == false then
		return
	end

	local oldViewOffset = Vector(0, 0, 64)
	local plyProneStateData = prone.PlayerStateDatas[ply:SteamID()]
	if plyProneStateData then
		oldViewOffset = plyProneStateData:GetOriginalViewOffest()
		ply:SetViewOffsetDucked(plyProneStateData:GetOriginalViewOffsetDucked())
	end

	local time = RealTime()
	if lastTime == 0 then
		lastTime = time
		reset = false
		return
	end

	-- Calculate a new Z value slightly lower than before.
	-- transitionVectorZ is the amount we are going down by.
	local result = hook.Run("prone.CalcTransitionZ", localply, transitionVectorZ)
	if result == nil then
		transitionVectorZ = transitionVectorZ + (transitionSpeed * (time - lastTime))
		lastTime = time
		transitionVectorZ = math.min(transitionVectorZ, oldViewOffset.z - prone.Config.View.z)
	else
		transitionVectorZ = result
	end

	local animstate = ply:GetProneAnimationState()
	if animstate == PRONE_GETTINGDOWN then
		transitionVector = Vector(pos.x, pos.y, pos.z - transitionVectorZ) - (ply:GetViewOffset() - oldViewOffset)
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
	local localply = LocalPlayer()

	if enabledViewTransitions:GetBool() then
		return
	end

	local result = hook.Run("prone.ShouldChangeCalcViewModelView", localply)
	if result == false then
		return
	end

	local animstate = localply:GetProneAnimationState()
	if animstate == PRONE_GETTINGDOWN or animstate == PRONE_GETTINGU then
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
	function binder:OnChange(num)
		RunConsoleCommand("prone_bindkey_key", num)
		self:SetText(input.GetKeyName(num))
	end

	local resetbutton = vgui.Create("DButton", frame)
	resetbutton:SetText("Reset settings")
	resetbutton:SetPos(0, 190)
	resetbutton:SetSize(200, 20)
	function resetbutton:DoClick()
		RunConsoleCommand("prone_bindkey_enabled", "1")
		RunConsoleCommand("prone_bindkey_key", tostring(prone.Config.DefaultBindKey))
		RunConsoleCommand("prone_bindkey_doubletap", "1")
		RunConsoleCommand("prone_jumptogetup", "1")
		RunConsoleCommand("prone_jumptogetup_doubletap", "1")
		frame:Remove()
	end
end)