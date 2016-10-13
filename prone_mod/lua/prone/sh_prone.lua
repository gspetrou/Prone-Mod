local PLAYER = FindMetaTable("Player")

if SERVER then
	PLAYER.prone = {}
	PLAYER.prone.starttime = 0
	PLAYER.prone.endtime = 0
	PLAYER.prone.getuptime = 0
	PLAYER.prone.getdowntime = 0
	PLAYER.prone.lastrequest = 0
	PLAYER.prone.oldviewoffset = Vector(0, 0, 0)
	PLAYER.prone.oldviewoffset_ducked = Vector(0, 0, 0)
end

--[[	States
1	-	Getting down
2	-	In Prone
3	-	Getting up
4	-	Exitting prone. Not the same as 3.
5	-	Out of prone
]]

function PLAYER:GetProneAnimationState()
	return self:GetNW2Int("prone.AnimationState", 5)
end
function PLAYER:SetProneAnimationState(state)
	return self:SetNW2Int("prone.AnimationState", state)
end

function PLAYER:GetProneAnimationLength()
	return self:GetNW2Float("prone.AnimationLength", 0)
end
function PLAYER:SetProneAnimationLength(length)
	return self:SetNW2Float("prone.AnimationLength", length)
end

function PLAYER:IsProne()
	return self:GetProneAnimationState() ~= 5
end

-- This is stupid but more optimized.
local GetUpdateAnimationRate = {
	[1] = 1,
	[3] = 1
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
			if not ply:IsOnGround() and length >= 1000 then
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
	return ismoving and prone.config.WeaponAnims.moving[holdtype] or prone.config.WeaponAnims.idle[holdtype]
end

-- Like above. Stupid but optimized.
local GetMainActivityAnimation = {
	-- Getting down
	[1] = function(ply)
		if ply:GetProneAnimationLength() >= CurTime() then
			return ACT_GET_DOWN_STAND	--"pronedown_stand"
		else
			ply:SetProneAnimationState(2)
			return ACT_SHIELD_ATTACK	--"prone_passive"
		end
	end,

	-- In prone
	[2] = function(ply, velocity)
		local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
		local WepHoldType
		if weapon then
			WepHoldType = weapon:GetHoldType() ~= "" and weapon:GetHoldType() or weapon.HoldType
		end

		return GetSequenceForWeapon(WepHoldType or "normal", velocity:LengthSqr() >= 225)
	end,

	-- Getting up
	[3] = function(ply)
		if ply:GetProneAnimationLength() >= CurTime() then

			--[[
			local DownVect = LerpVector(FrameTime()*4, ply:GetViewOffset(), Vector(0, 0, 64))
			ply:SetViewOffset(DownVect)
			ply:SetViewOffsetDucked(DownVect)
			]]

			return ACT_GET_UP_STAND	--"proneup_stand"
		else
			ply:SetProneAnimationState(4)
		end
	end,

	-- Setting back out of prone after the get up animation is over
	[4] = function(ply)
		if SERVER and ply.InProne then
			print("this got called")
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
	if ply:IsProne() then
		local ACT = GetMainActivityAnimation[ply:GetProneAnimationState()](ply, velocity)

		return ACT, -1
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
		else
			cmd:SetMaxClientSpeed(prone.config.MoveSpeed)
		end
	end
end)
