-- Micro-optimizations!
local math_min, type, IsValid, ipairs, player_GetAll, IsFirstTimePredicted = math.min, type, IsValid, ipairs, player.GetAll, IsFirstTimePredicted

------------------------------------------------------------
-- Define a bunch of important meta functions we'll be using
------------------------------------------------------------
local PLAYER = FindMetaTable("Player")

function PLAYER:GetProneAnimationState()
	return self:GetNW2Int("prone.AnimationState", PRONE_NOTINPRONE)
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
	return self:GetProneAnimationState() <= PRONE_EXITTING
end

function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGUP
end

function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGDOWN
end

------------------------------
-- Can enter/exit prone checks
------------------------------
-- Check whats going on in the gamemode to see if its a good time to toggle prone.
-- We use a table so other gamemodes can easily add their own compatibility stuff.
prone.GamemodeChecks = prone.GamemodeChecks or {
	darkrp = function(ply)
		local rank = ply:GetUserGroup()
		for i, v in ipairs(prone.config.Darkrp_BypassRanks) do
			if v == rank then
				return true
			end
		end

		local ply_darkrpjob = ply:Team()
		for i, v in ipairs(prone.config.Darkrp_Joblist) do
			if ply_darkrpjob == v then
				if prone.config.Darkrp_IsWhitelist then
					return true
				else
					return false
				end
			end
		end

		-- If their job was not on the list and that list was not a whitelist then they can go prone.
		return not prone.config.Darkrp_IsWhitelist
	end,

	prop_hunt = function(ply)
		if not GetGlobalBool("InRound", false) or (GetGlobalFloat("RoundStartTime", 0) + HUNTER_BLINDLOCK_TIME) > CurTime() or ply:Team() ~= TEAM_HUNTERS then
			return false
		else
			return true
		end
	end,

	clockwork = function(ply)
		return not ply:IsRagdolled()
	end
}
function prone.CheckWithGamemode(ply)
	if type(prone.GamemodeChecks[GAMEMODE_NAME]) == "function" then
		return prone.GamemodeChecks[GAMEMODE_NAME](ply)
	elseif type(prone.GamemodeChecks[GAMEMODE.DerivedFrom]) == "function" then
		return prone.GamemodeChecks[GAMEMODE.DerivedFrom](ply)
	end

	return true
end

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

function prone.HasRoomToGetUp(ply)
	local tr = util.TraceEntity({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 65 - prone.config.HullHeight),
		filter = ply
	}, ply)
	
	if tr.Hit then
		if CLIENT and IsFirstTimePredicted() then
			CantGetUpWarning()
		end
		return false
	else
		return true
	end
end

function prone.CanEnter(ply)
	local hookresult = hook.Call("prone.CanEnter", nil, ply)
	if hookresult ~= nil then
		return hookresult
	elseif ply:GetMoveType() == MOVETYPE_NOCLIP or not ply:OnGround() or ply:WaterLevel() > 1 then
		return false
	end

	return prone.CheckWithGamemode(ply)
end

function prone.CanExit(ply)
	local hookresult = hook.Call("prone.CanExit", nil, ply)
	if hookresult ~= nil then
		return hookresult
	elseif not prone.HasRoomToGetUp(ply) then
		return false
	end

	return true
end


---------------------------------
-- Prone enter and exit functions
---------------------------------
function prone.Enter(ply)
	ply.prone = ply.prone or {}

	ply.prone.oldviewoffset = ply:GetViewOffset()
	ply.prone.oldviewoffset_ducked = ply:GetViewOffsetDucked()


	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

	-- Pick which animation to use.
	ply.prone.starttime = CurTime()
	local seq = prone.animations.gettingdown
	--[[if ply:Crouching() then
		seq = prone.animations.gettingdown_crouch
	end]]

	local length = ply:SequenceDuration(ply:LookupSequence(seq))
	ply.prone.getdowntime = length + ply.prone.starttime
	ply:SetProneAnimationLength(ply.prone.getdowntime)

	-- Make sure they can't shoot while prone.
	local weapon = ply:GetActiveWeapon()
	if IsValid(weapon) then
		weapon:SetNextPrimaryFire(ply.prone.getdowntime)
		weapon:SetNextSecondaryFire(ply.prone.getdowntime)
	end

	ply:AnimRestartMainSequence()
	ply:SetProneAnimationState(PRONE_GETTINGDOWN)
	hook.Call("prone.OnPlayerEntered", nil, ply, length)
end

function prone.End(ply)
	ply:AnimRestartMainSequence()

	-- Choose either the standing or crouching get up animation.
	ply.prone.endtime = CurTime()
	local seq = prone.animations.gettingup
	--[[if ply:Crouching() then
		seq = prone.animations.gettingup_crouch
	end]]
	ply.prone.getuptime = ply:SequenceDuration(ply:LookupSequence(seq)) + ply.prone.endtime
	ply:SetProneAnimationLength(ply.prone.getuptime)


	-- Make sure they can't shoot while getting up.
	local weapon = ply:GetActiveWeapon()
	if IsValid(weapon) then
		weapon:SetNextPrimaryFire(ply.prone.getuptime)
		weapon:SetNextSecondaryFire(ply.prone.getuptime)
	end

	-- Play the animation.
	ply:SetProneAnimationState(PRONE_GETTINGUP)
end

function prone.Exit(ply)
	ply:SetViewOffset(ply.prone.oldviewoffset or Vector(0, 0, 64))
	ply:SetViewOffsetDucked(ply.prone.oldviewoffset_ducked or Vector(0, 0, 28))
	ply:ResetHull()

	ply:SetProneAnimationState(PRONE_NOTINPRONE)
	hook.Call("prone.OnPlayerExitted", nil, ply)
end

-- This will toggle between putting the player in or out of prone depending on their state.
function prone.Handle(ply)
	if not (IsValid(ply) and ply:IsPlayer() and ply:Alive()) then
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


---------------------------------------------------------------------------
-- Control some rates and toggle them between prone if they send an impulse
---------------------------------------------------------------------------
hook.Add("SetupMove", "prone.Handle", function(ply, cmd, cuc)
	if ply:IsProne() then
		if cmd:KeyDown(IN_JUMP) then
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_JUMP)))	-- Disables jumping, thanks meep
		end

		-- If they are getting up or down then set their speed to TransitionSpeed
		if ply:GetProneAnimationLength() >= CurTime() then
			cmd:SetMaxClientSpeed(prone.config.TransitionSpeed)
			cmd:SetMaxSpeed(prone.config.TransitionSpeed)

			-- SetMaxClientSpeed doesn't work if you are setting it to 0 so also do this.
			if prone.config.TransitionSpeed <= 0 and ply:IsOnGround() then
				cmd:SetForwardSpeed(0)
				cmd:SetSideSpeed(0)
				cmd:SetVelocity(Vector(0, 0, 0))
			end
			return
		else	-- If they are in prone set their speed to MoveSpeed
			cmd:SetMaxClientSpeed(prone.config.MoveSpeed)
			cmd:SetMaxSpeed(prone.config.MoveSpeed)
		end

		-- Make sure they can't shoot while prone and moving if that setting is enabled.
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

	if cuc:GetImpulse() == PRONE_IMPULSE and (ply:GetProneAnimationLength() < CurTime() + 0.5) then
		prone.Handle(ply)
	end
end)

-- TTT Movement support
hook.Add("TTTPlayerSpeed", "prone.RestrictMovement", function(ply)
	if ply:IsProne() then
		return prone.config.MoveSpeed / 220	-- 220 is the default run speed in TTT
	end
end)


------------------------------------------------------------------
-- Handles pose parameters and the playback rate of the animations
------------------------------------------------------------------
local GetUpdateAnimationRate = {
	[PRONE_GETTINGDOWN] = 1,
	[PRONE_GETTINGUP] = 1
}
hook.Add("UpdateAnimation", "prone.Animations", function(ply, velocity, maxSeqGroundSpeed)
	if ply:IsProne() then
		local length = velocity:Length()

		local rate = GetUpdateAnimationRate[ply:GetProneAnimationState()]
		if not rate then
			if not ply:IsOnGround() and length >= 750 then
				rate = 0.1
			else
				if length > 0.2 then
					rate = math_min(length / maxSeqGroundSpeed, 2)
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

		ply:SetPlaybackRate(rate)
	end
end)


----------------------------------------
-- The animation powerhouse of the addon
----------------------------------------
local function GetSequenceForWeapon(holdtype, ismoving)
	return ismoving and prone.animations.WeaponAnims.moving[holdtype] or prone.animations.WeaponAnims.idle[holdtype]
end
local GetMainActivityAnimation = {
	[PRONE_GETTINGDOWN] = function(ply)
		if ply:GetProneAnimationLength() <= CurTime() then
			ply:SetViewOffset(prone.config.View)
			ply:SetViewOffsetDucked(prone.config.View)
			ply:SetProneAnimationState(PRONE_INPRONE)
		end
		
		return prone.animations.gettingdown
	end,

	[PRONE_GETTINGUP] = function(ply)
		if ply:GetProneAnimationLength() <= CurTime() then
			ply:SetViewOffset(ply.prone.oldviewoffset or Vector(0, 0, 64))
			ply:SetViewOffsetDucked(ply.prone.oldviewoffset_ducked or Vector(0, 0, 28))
			ply:SetProneAnimationState(PRONE_EXITTING)
		end

		return prone.animations.gettingup
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

	[PRONE_EXITTING] = function(ply)
		prone.Exit(ply)

		-- If they get stuck in anything while exitting put them back in prone.
		local tr = util.TraceEntity({
			start = ply:GetPos(),
			endpos = ply:GetPos(),
			filter = ply
		}, ply)

		if tr.Hit then
			prone.Enter(ply)

			if CLIENT and IsFirstTimePredicted() then
				CantGetUpWarning()
			end
		end
		
		return prone.animations.passive
	end,

	-- Just in case this gets called for some reason.
	[PRONE_NOTINPRONE] = function()
		return prone.animations.passive
	end
}
hook.Add("CalcMainActivity", "prone.Animations", function(ply, velocity)
	if IsValid(ply) and ply:IsProne() then
		local seq = GetMainActivityAnimation[ply:GetProneAnimationState()](ply, velocity)

		-- NEVER let this hook's second return parameter be a number less than 0.
		-- That crashes Linux servers for some reason.
		local seqid = ply:LookupSequence(seq or "")
		if type(seqid) == "number" and seqid < 0 then
			return
		end

		return -1, seqid or nil
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
timer.Create("prone.Manage", 1, 0, function()
	for i, v in ipairs(player_GetAll()) do
		if v:IsProne() and ((v:WaterLevel() > 1 and not v:ProneIsGettingUp()) or v:GetMoveType() == MOVETYPE_NOCLIP) then
			prone.Exit(v)
		end
	end
end)