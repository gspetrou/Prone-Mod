-- Copyright 2016 George "Stalker" Petrou, enjoy!
local PLAYER = FindMetaTable("Player")
PLAYER.prone = {}

if SERVER then
	if prone.IsCompatibility() then
		PLAYER.prone.cl_modeldata = {}
	end

	PLAYER.prone.starttime = 0
	PLAYER.prone.endtime = 0
	PLAYER.prone.getuptime = 0
	PLAYER.prone.getdowntime = 0
	PLAYER.prone.lastrequest = 0
	PLAYER.prone.oldviewoffset = Vector(0, 0, 0)
	PLAYER.prone.oldviewoffset_ducked = Vector(0, 0, 0)
end

function PLAYER:GetProneAnimationState()
	return self:GetNWInt("prone.AnimationState", PRONE_NOTINPRONE)
end
function PLAYER:SetProneAnimationState(state)
	return self:SetNWInt("prone.AnimationState", state)
end

function PLAYER:GetProneAnimationLength()
	return self:GetNWFloat("prone.AnimationLength", 0)
end
function PLAYER:SetProneAnimationLength(length)
	return self:SetNWFloat("prone.AnimationLength", length)
end

function PLAYER:IsProne()
	return self:GetProneAnimationState() <= PRONE_EXITTINGPRONE
end

function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGUP
end

function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGDOWN
end

-- This is stupid but more optimized.
local GetUpdateAnimationRate = {
	[PRONE_GETTINGDOWN] = 1,
	[PRONE_GETTINGUP] = 1
}
hook.Add("UpdateAnimation", "Prone.Animations", function(ply, velocity, maxSeqGroundSpeed)
	if ply:IsProne() then
		local length = velocity:Length()
		local movement = 1

		if length > 0.2 then
			movement = length/maxSeqGroundSpeed
		end

		local rate = GetUpdateAnimationRate[ply:GetProneAnimationState()]
		if not rate then
			if not ply:IsOnGround() and length >= 750 then
				rate = 0.1
			else
				rate = math.min(movement, 2)
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

		ply:SetPlaybackRate(rate)
	end
end)

local function GetSequenceForWeapon(holdtype, ismoving)
	return ismoving and prone.animations.WeaponAnims.moving[holdtype] or prone.animations.WeaponAnims.idle[holdtype]
end

local GetMainActivityAnimation = {
	[PRONE_GETTINGDOWN] = function(ply)
		if ply:GetProneAnimationLength() >= CurTime() then

			local DownView = LerpVector(FrameTime()*4, ply:GetViewOffset(), Vector(0, 0, 24))
			ply:SetViewOffset(DownView)
			ply:SetViewOffsetDucked(DownView)

			return ply:Crouching() and prone.animations.gettingdown_crouch or prone.animations.gettingdown
		else
			ply:SetProneAnimationState(PRONE_INPRONE)

			return prone.animations.passive
		end
	end,

	[PRONE_GETTINGUP] = function(ply)
		if ply:GetProneAnimationLength() >= CurTime() then

			local UpView = LerpVector(FrameTime()*4, ply:GetViewOffset(), Vector(0, 0, 64))
			ply:SetViewOffset(UpView)
			ply:SetViewOffsetDucked(UpView)

			return ply:Crouching() and prone.animations.gettingup_crouch or prone.animations.gettingup
		else
			ply:SetProneAnimationState(PRONE_EXITTINGPRONE)
		end
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

	[PRONE_EXITTINGPRONE] = function(ply)
		if SERVER then
			prone.Exit(ply)

			if not ply:CanExitProne() then
				prone.StartProne(ply)
				ply:SetViewOffset(Vector(0, 0, 18))
				ply:SetViewOffsetDucked(Vector(0, 0, 18))
			end
		end
	end
}
hook.Add("CalcMainActivity", "Prone.Animations", function(ply, velocity)
	if ply:IsPlayer() and ply:IsProne() then
		local seq = GetMainActivityAnimation[ply:GetProneAnimationState()](ply, velocity)

		return -1, ply:LookupSequence(seq or "")
	end
end)

hook.Add("SetupMove", "Prone.RestrictMovement", function(ply, cmd)
	if ply:IsProne() then
		if cmd:KeyDown(IN_JUMP) then
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_JUMP)))	-- Disables jumping, thanks meep
		end

		if ply:GetProneAnimationLength() >= CurTime() then
			cmd:SetForwardSpeed(prone.config.TransitionSpeed)
			cmd:SetSideSpeed(prone.config.TransitionSpeed)
			return
		else
			cmd:SetMaxClientSpeed(prone.config.MoveSpeed)
			cmd:SetMaxSpeed(prone.config.MoveSpeed)
		end

		local attack1 = cmd:KeyDown(IN_ATTACK)
		if attack1 or cmd:KeyDown(IN_ATTACK2) and prone.config.MoveShoot_Restrict then
			local weapon = ply:GetActiveWeapon()
			if not IsValid(weapon) then
				return
			end

			local weaponclass = weapon:GetClass()
			if not prone.config.MoveShoot_Whitelist[weaponclass] then
				local ShouldStopMovement = true
				if attack1 then
					ShouldStopMovement = weapon:Clip1() > 0
				else
					ShouldStopMovement = weapon:Clip2() > 0
				end

				if (ShouldStopMovement or weaponclass == "weapon_crowbar") and ply:IsOnGround() then
					cmd:SetForwardSpeed(0)
					cmd:SetSideSpeed(0)
					cmd:SetVelocity(Vector(0, 0, 0))
				end
			end
		end
	end
end)

hook.Add("TTTPlayerSpeed", "Prone.RestrictMovement", function(ply)
	if ply:IsProne() then
		return prone.ProneSpeed/220	-- 220 is the default run speed in TTT
	end
end)