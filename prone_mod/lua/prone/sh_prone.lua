local PLAYER = FindMetaTable("Player")

---------------------------------
-- PLAYER.GetProneAnimationState
---------------------------------
-- Desc:		Gets the prone animation state of the given player.
-- Returns:		PRONE enum.
function PLAYER:GetProneAnimationState()
	return self:GetNW2Int("prone.AnimationState", PRONE_NOTINPRONE)
end

---------------------------------
-- PLAYER.SetProneAnimationState
---------------------------------
-- Desc:		Sets the prone animation state of the given player.
-- Arg One:		PRONE enum.
function PLAYER:SetProneAnimationState(state)
	return self:SetNW2Int("prone.AnimationState", state)
end

----------------------------------
-- PLAYER.GetProneAnimationLength
----------------------------------
-- Desc:		Returns the time when the current prone animation will end.
-- 				This value is: CurTime at start of anim + length of anim
-- Returns:		Number
function PLAYER:GetProneAnimationLength()
	return self:GetNW2Float("prone.AnimationLength", 0)
end

----------------------------------
-- PLAYER.SetProneAnimationLength
----------------------------------
-- Desc:		Sets at what time, relative to CurTime, the given prone animation will end.
-- Arg One:		Number, time.
function PLAYER:SetProneAnimationLength(length)
	self:SetNW2Float("prone.AnimationLength", length)
end

------------------
-- PLAYER.IsProne
------------------
-- Desc:		Is the player in prone.
-- Returns:		Boolean.
function PLAYER:IsProne()
	return self:GetProneAnimationState() ~= PRONE_NOTINPRONE
end

---------------------------
-- PLAYER.ProneIsGettingUp
---------------------------
-- Desc:		Is the player getting up out of prone.
-- Returns:		Boolean.
function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGUP
end

-----------------------------
-- PLAYER.ProneIsGettingDown
-----------------------------
-- Desc:		Is the player getting down into prone.
-- Returns:		Boolean.
function PLAYER:ProneIsGettingDown()
	return self:GetProneAnimationState() == PRONE_GETTINGDOWN
end

------------------------
-- prone.HasRoomToGetUp
------------------------
-- Desc:		Does the player have enough room to get up, out of prone.
-- Arg One:		Player.
-- Returns:		Boolean.
function prone.HasRoomToGetUp(ply)
	if not ply:IsProne() then
		return true
	end

	local tr = util.TraceEntity({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 65 - prone.Config.HullHeight),
		filter = ply
	}, ply)
	
	if tr.Hit then
		if CLIENT and IsFirstTimePredicted() then
			prone.CantGetUpWarning()
		end
		return false
	else
		return true
	end
end

------------------
-- prone.CanEnter
------------------
-- Desc:		Can the given player enter prone.
-- Arg One:		Player
-- Returns:		Boolean
function prone.CanEnter(ply)
	-- prone.CanEnter hook takes precedence.
	local hookresult = hook.Run("prone.CanEnter", ply)
	if hookresult ~= nil then
		return hookresult

	-- Then check the player's state.
	elseif not ply:IsPlayer() or not ply:Alive() or ply:GetMoveType() == MOVETYPE_NOCLIP or not ply:OnGround() or ply:WaterLevel() > 1 then
		return false
	end

	return true
end

-----------------
-- prone.CanExit
-----------------
-- Desc:		Can the given player exit prone.
-- Arg One:		Player
-- Returns:		Boolean
function prone.CanExit(ply)
	if not (ply:IsPlayer() and ply:Alive()) then
		return false
	end

	local hookresult = hook.Run("prone.CanExit", ply)
	if hookresult ~= nil then
		return hookresult
	elseif not prone.HasRoomToGetUp(ply) then
		return false
	end

	return true
end

---------------
-- prone.Enter
---------------
-- Desc:		Begins the animation putting the given player into prone.
-- Arg One:		Player.
function prone.Enter(ply)
	local plyProneStateData = prone.PlayerStateData:New(ply)
	prone.PlayerStateDatas[ply:SteamID()] = plyProneStateData
	plyProneStateData:UpdateDataOnProneEnter()

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.Config.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.Config.HullHeight))

	local getDownTime = plyProneStateData:GetGetDownTime()
	ply:SetProneAnimationLength(getDownTime)

	-- Make sure they can't shoot while prone.
	local weapon = ply:GetActiveWeapon()
	if IsValid(weapon) then
		weapon:SetNextPrimaryFire(getDownTime)
		weapon:SetNextSecondaryFire(getDownTime)
	end

	ply:SetProneAnimationState(PRONE_GETTINGDOWN)
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, PRONE_CUSTOM_ANIM_EVENT_NUM)
	hook.Run("prone.OnPlayerEntered", ply, plyProneStateData:GetEnterProneAnimLength())
end

-------------
-- prone.End
-------------
-- Desc:		Begins the animation taking the given player out of prone.
-- Arg One:		Player.
function prone.End(ply)
	local plyProneStateData = prone.PlayerStateDatas[ply:SteamID()]
	if not plyProneStateData then
		plyProneStateData = prone.PlayerStateData:New(ply)
	end
	plyProneStateData:UpdateOnProneEnd()

	local getUpTime = plyProneStateData:GetGetUpTime()
	ply:SetProneAnimationLength(getUpTime)

	-- Make sure they can't shoot while getting up.
	local weapon = ply:GetActiveWeapon()
	if IsValid(weapon) then
		weapon:SetNextPrimaryFire(getUpTime)
		weapon:SetNextSecondaryFire(getUpTime)
	end

	-- Play the animation.
	ply:DoCustomAnimEvent(PLAYERANIMEVENT_CUSTOM, PRONE_CUSTOM_ANIM_EVENT_NUM)
	ply:SetProneAnimationState(PRONE_GETTINGUP)
end

--------------
-- prone.Exit
--------------
-- Desc:		Forces the player immediately out of prone with no animation.
-- Arg One:		Player.
function prone.Exit(ply)
	local plyProneStateData = prone.PlayerStateDatas[ply:SteamID()]

	if plyProneStateData then
		ply:SetViewOffset(plyProneStateData:GetOriginalViewOffset())
		ply:SetViewOffsetDucked(plyProneStateData:GetOriginalViewOffsetDucked())
	else
		-- Best guess in-case we somehow lose state data.
		ply:SetViewOffset(Vector(0, 0, 64))
		ply:SetViewOffsetDucked(Vector(0, 0, 28))
	end
	ply:ResetHull()

	prone.PlayerStateDatas[ply:SteamID()] = nil

	ply:SetProneAnimationState(PRONE_NOTINPRONE)
	hook.Run("prone.OnPlayerExitted", ply)
end

----------------
-- prone.Handle
----------------
-- Desc:		Toggles between the player entering and ending prone.
function prone.Handle(ply)
	if not IsValid(ply) then
		return
	end

	if ply:IsProne() then
		if prone.CanExit(ply) then
			prone.End(ply)
		end
	else
		if prone.CanEnter(ply) then
			prone.Enter(ply)
		end
	end
end

local proneMoveSpeed = CreateConVar("prone_movespeed", tostring(prone.Config.MoveSpeed), {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Sets the move speed while prone.")


-- Disable jumping in prone, set prone movement speed, handle weapon fire.
hook.Add("SetupMove", "prone.Handle", function(ply, cmd, cuc)
	if ply:IsProne() then
		-- Disables jumping, thanks meep.
		if cmd:KeyDown(IN_JUMP) then
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_JUMP)))
		end
		-- Disabled crouching.
		if cmd:KeyDown(IN_DUCK) then
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_DUCK)))
		end

		-- If they are getting up or down then set their speed to TransitionSpeed
		if ply:GetProneAnimationLength() >= CurTime() then
			cmd:SetMaxClientSpeed(prone.Config.TransitionSpeed)
			cmd:SetMaxSpeed(prone.Config.TransitionSpeed)

			-- SetMaxClientSpeed doesn't work if you are setting it to 0 so also do this.
			if prone.Config.TransitionSpeed <= 0 and ply:IsOnGround() then
				cmd:SetForwardSpeed(0)
				cmd:SetSideSpeed(0)
				cmd:SetVelocity(Vector(0, 0, 0))
			end
			return
		else	-- If they are in prone set their speed to MoveSpeed
			local moveSpeed = proneMoveSpeed:GetInt()
			if not isnumber(moveSpeed) then
				moveSpeed = prone.Config.MoveSpeed
			end

			cmd:SetMaxClientSpeed(moveSpeed)
			cmd:SetMaxSpeed(moveSpeed)
		end

		-- Make sure they can't shoot while prone and moving if that setting is enabled.
		local attack1 = cmd:KeyDown(IN_ATTACK)
		if attack1 or cmd:KeyDown(IN_ATTACK2) and prone.Config.MoveShoot_Restrict then
			local weapon = ply:GetActiveWeapon()
			if not IsValid(weapon) then
				return
			end

			local weaponclass = weapon:GetClass()
			if not prone.Config.MoveShoot_Whitelist[weaponclass] then
				local shouldStopMovement = true
				if attack1 then
					shouldStopMovement = weapon:Clip1() > 0
				else
					shouldStopMovement = weapon:Clip2() > 0
				end

				if (shouldStopMovement or weaponclass == "weapon_crowbar") and ply:IsOnGround() then
					cmd:SetForwardSpeed(0)
					cmd:SetSideSpeed(0)
					cmd:SetVelocity(Vector(0, 0, 0))
				end
			end
		end
	end

	if cuc:GetImpulse() == PRONE_IMPULSE and (ply:GetProneAnimationLength() < CurTime() + 0.5) then
		prone.Handle(ply)
	end
end)

-- Handles pose parameters and playback rates of animations.
hook.Add("UpdateAnimation", "prone.Animations", function(ply, velocity, maxSeqGroundSpeed)
	if ply:IsProne() then
		local length = velocity:Length()

		local rate = 1
		local plyAnimState = ply:GetProneAnimationState()
		if plyAnimState ~= PRONE_GETTINGDOWN and plyAnimState ~= PRONE_GETTINGUP then
			if not ply:IsOnGround() and length >= 750 then
				rate = 0.1
			else
				if length > 0.2 then
					rate = math.min(length / maxSeqGroundSpeed, 2)
				else
					rate = 1
				end
			end
		end

		if CLIENT then
			local EyeAngP = ply:EyeAngles().p
			if EyeAngP < 89 then
				ply:SetPoseParameter("body_pitch", math.Clamp(-EyeAngP, -10, 50))
				ply:SetPoseParameter("body_yaw", 0)
				ply:InvalidateBoneCache()
			end
		end

		-- Interesting code I saw in NutScript, doesn't seem to do anything in my case though.
		--local eyeAngles = ply:EyeAngles()
		--local yaw = velocity:Angle()[2]
		--local normalized = math.NormalizeAngle(yaw - eyeAngles[2])
		--ply:SetPoseParameter("move_yaw", normalized)

		ply:SetPlaybackRate(rate)
	end
end)

-- The animation handler of the addon.
local function GetSequenceForWeapon(holdtype, ismoving)
	return ismoving and prone.Animations.WeaponAnims.moving[holdtype] or prone.Animations.WeaponAnims.idle[holdtype]
end
local GetMainActivityAnimation = {
	[PRONE_GETTINGDOWN] = function(ply)
		if ply:GetProneAnimationLength() <= CurTime() then
			ply:SetViewOffset(prone.Config.View)
			ply:SetViewOffsetDucked(prone.Config.View)
			ply:SetProneAnimationState(PRONE_INPRONE)
		end
		
		return prone.Animations.gettingdown
	end,

	[PRONE_GETTINGUP] = function(ply)
		if ply:GetProneAnimationLength() <= CurTime() then
			local plyProneStateData = prone.PlayerStateDatas[ply:SteamID()]
			if plyProneStateData then
				ply:SetViewOffset(plyProneStateData:GetOriginalViewOffset())
				ply:SetViewOffsetDucked(plyProneStateData:GetOriginalViewOffsetDucked())
			else
				-- Best guess in-case we somehow lose state data.
				ply:SetViewOffset(Vector(0, 0, 64))
				ply:SetViewOffsetDucked(Vector(0, 0, 28))
			end

			prone.Exit(ply)

			-- If they get stuck in anything while exitting put them back in prone.
			local scanPos = ply:GetPos()
			local tr = util.TraceEntity({
				start = scanPos,
				endpos = scanPos,
				filter = ply
			}, ply)

			if tr.Hit then
				if CLIENT and ply == LocalPlayer() then
					prone.CantGetUpWarning()
				end
				prone.Enter(ply)
			end
		end

		return prone.Animations.gettingup
	end,

	[PRONE_INPRONE] = function(ply, velocity)
		local weapon = ply:GetActiveWeapon()
		local WeaponHoldType

		if IsValid(weapon) then
			WeaponHoldType = weapon:GetHoldType()
			if WeaponHoldType == "" then
				WeaponHoldType = weapon.HoldType
			end
		end

		return GetSequenceForWeapon(WeaponHoldType or "normal", velocity:LengthSqr() >= 225)
	end,

	-- Just in case this gets called for some reason.
	[PRONE_NOTINPRONE] = function()
		return prone.Animations.passive
	end
}
hook.Add("CalcMainActivity", "prone.Animations", function(ply, velocity)
	if IsValid(ply) and ply:IsProne() then
		local seq = GetMainActivityAnimation[ply:GetProneAnimationState()](ply, velocity)

		-- NEVER let this hook's second return parameter be a number less than 0.
		-- That crashes Linux servers for some reason.
		local seqid = ply:LookupSequence(seq or "")
		if seqid < 0 then
			return
		end

		return -1, seqid or nil
	end
end)

-- Fixes a bug where other players (not the one proning) might see the proning player's get up/down
-- animations starting at a random point in the animation.
hook.Add("DoAnimationEvent", "prone.ResetAnimation", function(ply, event, data)
	if event == PLAYERANIMEVENT_CUSTOM then
		if data == PRONE_CUSTOM_ANIM_EVENT_NUM then
			ply:AnimRestartMainSequence()
		end
	end
end)

------------------------------------------------------------
-- Check if the player should still be prone at these events
------------------------------------------------------------
hook.Add("PlayerNoClip", "prone.ExitOnNoclip", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)
hook.Add("VehicleMove", "prone.ExitOnVehicleEnter", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)
timer.Create("prone.Manage", 0.5, 0, function()
	for i, v in ipairs(player.GetAll()) do
		if v:IsProne() and (
			(v:WaterLevel() > 1 and not v:ProneIsGettingUp())
			or v:GetMoveType() == MOVETYPE_NOCLIP
			or v:GetMoveType() == MOVETYPE_LADDER
		) then
			prone.Exit(v)
		end
	end
end)

----------------
-- API Functions
----------------
-- Notice: Any API functions should be called in or after the prone.Initialized hook has been called.
function prone.AddNewHoldTypeAnimation(holdtype, movingSequenceName, idleSequenceName)
	prone.Animations.WeaponAnims.moving[holdtype] = movingSequenceName
	prone.Animations.WeaponAnims.idle[holdtype] = idleSequenceName
end

function prone.GetIdleAnimation(holdtype)
	return prone.Animations.WeaponAnims.idle[holdtype]
end
function prone.GetMovingAnimation(holdtype)
	return prone.Animations.WeaponAnims.moving[holdtype]
end