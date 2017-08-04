-- Micro-optimizations!
local math_min, type, IsValid, ipairs, player_GetAll, IsFirstTimePredicted, LocalPlayer, CurTime, game_SinglePlayer = math.min, type, IsValid, ipairs, player.GetAll, IsFirstTimePredicted, LocalPlayer, CurTime, game.SinglePlayer

------------------------------------------------------------
-- Define a bunch of important meta functions we'll be using
------------------------------------------------------------
local PLAYER = FindMetaTable("Player")

-- Returns a PRONE_ enum of the player's current prone state.
function PLAYER:GetProneAnimationState()
	if not game_SinglePlayer() and (SERVER or (CLIENT and self == LocalPlayer())) then
		return self.prone_AnimationState or self:GetNW2Int("prone.AnimationState", PRONE_NOTINPRONE)
	else
		return self:GetNW2Int("prone.AnimationState", PRONE_NOTINPRONE)
	end
end
function PLAYER:SetProneAnimationState(state)
	self:SetNW2Int("prone.AnimationState", state)
	self.prone_AnimationState = state
end

-- Returns the length of the prone animation plus the time the animation was set.
function PLAYER:GetProneAnimationLength()
	if not game_SinglePlayer() and (SERVER or (CLIENT and self == LocalPlayer())) then
		return self.prone_AnimationLength or self:GetNW2Float("prone.AnimationLength", 0)
	else
		return self:GetNW2Float("prone.AnimationLength", 0)
	end
end
function PLAYER:SetProneAnimationLength(length)
	self:SetNW2Float("prone.AnimationLength", length)
	self.prone_AnimationLength = length
end

function PLAYER:IsProne()
	return self:GetProneAnimationState() <= PRONE_GETTINGUP
end

function PLAYER:ProneIsGettingUp()
	return self:GetProneAnimationState() == PRONE_GETTINGUP
end

function PLAYER:ProneIsGettingDown()
	return self:GetProneAnimationState() == PRONE_GETTINGDOWN
end

-- Might as well micro-optimize again.
local IsProne, GetProneAnimationState, GetProneAnimationLength = PLAYER.IsProne, PLAYER.GetProneAnimationState, PLAYER.GetProneAnimationLength

------------------------------
-- Can enter/exit prone checks
------------------------------
-- Check whats going on in the gamemode to see if its a good time to toggle prone.
-- We use a table so other gamemodes can easily add their own compatibility stuff.
prone.GamemodeChecks = prone.GamemodeChecks or {
	darkrp = function(ply)
		if prone.config.Darkrp_RestrictJobs then
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
		end

		return true
	end,

	prop_hunt = function(ply)
		if not GetGlobalBool("InRound", false) or (GetGlobalFloat("RoundStartTime", 0) + (HUNTER_BLINDLOCK_TIME or 0)) > CurTime() or ply:Team() ~= TEAM_HUNTERS then
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

-- Checks to see if there is enough head room to get up.
function prone.HasRoomToGetUp(ply)
	local tr = util.TraceEntity({
		start = ply:GetPos(),
		endpos = ply:GetPos() + Vector(0, 0, 65 - prone.config.HullHeight),
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

function prone.ResetAnimation(ply)
	ply:AnimRestartMainSequence()

	if SERVER then
		net.Start("prone.ResetAnimation")
			prone.WritePlayer(ply)
		net.Broadcast()
	end
end


---------------------------------
-- Prone enter and exit functions
---------------------------------
function prone.Enter(ply)
	ply.prone = ply.prone or {}

	prone.ResetAnimation(ply)

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

	ply:SetProneAnimationState(PRONE_GETTINGDOWN)
	hook.Call("prone.OnPlayerEntered", nil, ply, length)
end

-- Plays the get up animation then exits the player out of prone.
function prone.End(ply)
	ply.prone = ply.prone or {}

	prone.ResetAnimation(ply)

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

-- Makes the player immediately exit prone without a getting up animation.
function prone.Exit(ply)
	ply.prone = ply.prone or {}

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

	if IsProne(ply) then
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
	if IsProne(ply) then
		-- Disables jumping, thanks meep.
		if cmd:KeyDown(IN_JUMP) then
			cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_JUMP)))
		end

		-- If they are getting up or down then set their speed to TransitionSpeed
		if GetProneAnimationLength(ply) >= CurTime() then
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

	if cuc:GetImpulse() == PRONE_IMPULSE and (GetProneAnimationLength(ply) < CurTime() + 0.5) then
		prone.Handle(ply)
	end
end)


-------------------------------------------------------------------
-- Handles pose parameters and the playback rates of the animations
-------------------------------------------------------------------
local GetUpdateAnimationRate = {
	[PRONE_GETTINGDOWN] = 1,
	[PRONE_GETTINGUP] = 1
}
hook.Add("UpdateAnimation", "prone.Animations", function(ply, velocity, maxSeqGroundSpeed)
	if IsProne(ply) then
		local length = velocity:Length()

		local rate = GetUpdateAnimationRate[GetProneAnimationState(ply)]
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
		if GetProneAnimationLength(ply) <= CurTime() then
			ply:SetViewOffset(prone.config.View)
			ply:SetViewOffsetDucked(prone.config.View)
			ply:SetProneAnimationState(PRONE_INPRONE)
		end
		
		return prone.animations.gettingdown
	end,

	[PRONE_GETTINGUP] = function(ply)
		if GetProneAnimationLength(ply) <= CurTime() then
			ply:SetViewOffset(ply.prone.oldviewoffset or Vector(0, 0, 64))
			ply:SetViewOffsetDucked(ply.prone.oldviewoffset_ducked or Vector(0, 0, 28))

			prone.Exit(ply)

			-- If they get stuck in anything while exitting put them back in prone.
			local tr = util.TraceEntity({
				start = ply:GetPos(),
				endpos = ply:GetPos(),
				filter = ply
			}, ply)

			if tr.Hit then
				prone.Enter(ply)

				if CLIENT and ply == LocalPlayer() then
					prone.CantGetUpWarning()
				end
			end
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

	-- Just in case this gets called for some reason.
	[PRONE_NOTINPRONE] = function()
		return prone.animations.passive
	end
}
hook.Add("CalcMainActivity", "prone.Animations", function(ply, velocity)
	if IsValid(ply) and IsProne(ply) then
		ply.prone = ply.prone or {}
		
		local seq = GetMainActivityAnimation[GetProneAnimationState(ply)](ply, velocity)

		-- NEVER let this hook's second return parameter be a number less than 0.
		-- That crashes Linux servers for some reason.
		local seqid = ply:LookupSequence(seq or "")
		if seqid < 0 then
			return
		end

		return -1, seqid or nil
	end
end)


------------------------------------------------------------
-- Check if the player should still be prone at these events
------------------------------------------------------------
hook.Add("PlayerNoClip", "prone.ExitOnNoclip", function(ply)
	if IsProne(ply) then
		prone.Exit(ply)
	end
end)
hook.Add("VehicleMove", "prone.ExitOnVehicleEnter", function(ply)
	if IsProne(ply) then
		prone.Exit(ply)
	end
end)
timer.Create("prone.Manage", 0.5, 0, function()
	for i, v in ipairs(player_GetAll()) do
		if IsProne(v) and ((v:WaterLevel() > 1 and not v:ProneIsGettingUp()) or v:GetMoveType() == MOVETYPE_NOCLIP or v:GetMoveType() == MOVETYPE_LADDER) then
			prone.Exit(v)
		end
	end
end)

----------------
-- API Functions
----------------
-- Notice: Any API functions should be called in or after the prone.Initialized hook has been called.
function prone.AddNewHoldTypeAnimation(holdtype, movingSequenceName, idleSequenceName)
	prone.animations.WeaponAnims.moving[holdtype] = movingSequenceName
	prone.animations.WeaponAnims.idle[holdtype] = idleSequenceName
end

function prone.GetIdleAnimation(holdtype)
	return prone.animations.WeaponAnims.idle[holdtype]
end
function prone.GetMovingAnimation(holdtype)
	return prone.animations.WeaponAnims.moving[holdtype]
end