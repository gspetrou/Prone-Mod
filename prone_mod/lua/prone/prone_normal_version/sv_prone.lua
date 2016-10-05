-- Made by George "Stalker" Petrou, enjoy!

util.AddNetworkString("Prone_StartProne")
util.AddNetworkString("Prone_EndProne")
util.AddNetworkString("Prone_EndProneAnimation")
util.AddNetworkString("Prone_PlayerFullyLoaded")
util.AddNetworkString("Prone_LoadPronePlayersOnConnect")
util.AddNetworkString("Prone_CantExitProne")
util.AddNetworkString("Prone_HandleProne")

local PLY = FindMetaTable("Player")
local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()

-- This should be the main way players enter/exit prone. Not the other functions bellow.
function PLY:HandleProne()
	if self.Prone_LastProneRequestDelay > CurTime() or not self:Alive() then
		return
	end

	self.Prone_LastProneRequestDelay = CurTime() + 2
	self.allowedprone = true

	if GameMode == "darkrp" and prone.RestrictByJob then
		local PlyJob = string.lower(self:getJobTable().name)
		self.allowedprone = false

		for i, v in ipairs(prone.AllowedJobs) do
			if PlyJob == string.lower(v) then
				self.allowedprone = not prone.JobsIsBlacklist
				break
			end
		end
	elseif GameMode == "prop_hunt" then
		local preptime = GetGlobalFloat("RoundStartTime", 0) + HUNTER_BLINDLOCK_TIME

		if not GetGlobalBool("InRound", false) or preptime > CurTime() or self:Team() ~= TEAM_HUNTERS then
			return
		end
	end

	if not prone.AllowAllProne then
		if #prone.AlwaysAllowedRanks > 0 then
			self.allowedprone = false

			local PlyRank = string.lower(self:GetUserGroup())
			for i, v in ipairs(prone.AlwaysAllowedRanks) do
				if PlyRank == string.lower(v) then
					self.allowedprone = true
				end
			end

			if not self.allowedprone then
				self:PrintMessage(HUD_PRINTTALK, "You do not have permission to go prone.")
			end
		end
	else
		self.allowedprone = true
	end

	if self.allowedprone then
		if not self.InProne then
			local HookResult = hook.Call("CanPlayerEnterProne", nil, self)
			HookResult = (HookResult == nil) and true or HookResult

			if HookResult and self:GetMoveType() ~= MOVETYPE_NOCLIP and self:IsFlagSet(FL_ONGROUND) and self:WaterLevel() < 1 then
				prone.StartProne(self)
			end
		else
			local HookResult = hook.Call("CanPlayerLeaveProne", nil, self)
			HookResult = (HookResult == nil) and true or HookResult

			if self:CanExitProne() and HookResult then
				prone.EndProne(self)
			end
		end
	end
end

function PLY:CanExitProne()
	local tr = util.TraceHull({
		start = self:GetPos(),
		endpos = self:GetPos(),
		filter = self,
		mins = Vector(-16, -16, 0),
		maxs = Vector(16, 16, 78)
	})

	if tr.Hit then
		net.Start("Prone_CantExitProne")
		net.Send(self)
	end

	return not tr.Hit
end

function prone.StartProne(ply)
	if not IsValid(ply) then return end

	net.Start("Prone_StartProne")
		net.WriteEntity(ply)
	net.Broadcast()

	ply:SetNW2Bool("prone_isprone", true)
	ply.InProne = true
	ply.Prone_StartTime = CurTime()
	------------------
	------------------

	local length = ply:SequenceDuration(ply:SelectWeightedSequence(ACT_GET_DOWN_STAND))
	ply.Prone_GetDownTime = length + ply.Prone_StartTime
	ply:SetProneAnimationLength(ply.Prone_GetDownTime)

	ply.Prone_OldViewOffset = ply:GetViewOffset()
	ply.Prone_OldViewOffsetDucked = ply:GetViewOffsetDucked()
	------------------
	------------------

	local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
	if weapon then
		weapon:SetNextPrimaryFire(ply.Prone_GetDownTime)
		weapon:SetNextSecondaryFire(ply.Prone_GetDownTime)
	end

	if prone.GetUpDownSound then
		ply:EmitSound("prone.GetUpDownSound")
	end

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
	------------------
	------------------

	ply:AnimRestartMainSequence()

	ply:SetProneAnimationState(0)
	hook.Call("PlayerEnteredProne", nil, ply, length)
end

-- Handles the getting up animation (unless it is forced), then goes over to ExitProne to actually exit prone
function prone.EndProne(ply, forced)
	if not IsValid(ply) then return end
	ply.Prone_EndTime = CurTime()

	local length = 0

	if not forced then
		net.Start("Prone_EndProneAnimation")
			net.WriteEntity(ply)
		net.Broadcast()

		length = ply:SequenceDuration(ply:SelectWeightedSequence(ACT_GET_UP_STAND))
		ply.Prone_GetUpTime = length + ply.Prone_EndTime
		ply:SetProneAnimationLength(ply.Prone_GetUpTime)

		local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
		if weapon then
			weapon:SetNextPrimaryFire(ply.Prone_GetUpTime)
			weapon:SetNextSecondaryFire(ply.Prone_GetUpTime)
		end

		if prone.MoveSound and timer.Exists("prone_walksound_"..ply:SteamID()) then
			timer.Remove("prone_walksound_"..ply:SteamID())
		end
		if prone.GetUpDownSound then
			ply:EmitSound("prone.GetUpDownSound")
		end

		ply:AnimRestartMainSequence()
		ply:SetProneAnimationState(2)
	else
		prone.ExitProne(ply)
	end

	hook.Call("PlayerExittedProne", nil, ply, length)
end

function prone.ExitProne(ply)
	if not IsValid(ply) then return end

	ply:SetNW2Bool("prone_isprone", false)
	ply.InProne = false
	ply:SetViewOffset(ply.Prone_OldViewOffset)
	ply:SetViewOffsetDucked(ply.Prone_OldViewOffsetDucked)
	ply:ResetHull()

	net.Start("Prone_EndProne")
		net.WriteEntity(ply)
	net.Broadcast()

	ply:SetProneAnimationState(3)
end
