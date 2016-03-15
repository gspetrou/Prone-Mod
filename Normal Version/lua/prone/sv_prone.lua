-- Made by George "Stalker" Petrou, enjoy!

util.AddNetworkString("Prone_StartProne")
util.AddNetworkString("Prone_EndProne")
util.AddNetworkString("Prone_EndProneAnimation")
util.AddNetworkString("Prone_PlayerFullyLoaded")
util.AddNetworkString("Prone_LoadPronePlayersOnConnect")
util.AddNetworkString("Prone_CantExitProne")
util.AddNetworkString("Prone_HandleProne")

local PLY = FindMetaTable("Player")

-- This should be the main way players enter/exit prone. Not the other functions bellow.
function PLY:HandleProne()
	if self.Prone_LastProneRequestDelay > CurTime() or not self:Alive() then
		return
	end

	self.Prone_LastProneRequestDelay = CurTime() + 2

	local allowed = true

	if GameMode == "darkrp" and prone.RestrictByJob then
		local PlyJob = string.lower(self:getJobTable().name)
		allowed = false

		for i, v in ipairs(prone.AllowedJobs) do
			if PlyJob == string.lower(v) then
				allowed = true
				break
			end
		end
	end

	if not self.AllowAllProne and #prone.AlwaysAllowedRanks > 0 then
		local PlyRank = string.lower(self:GetUserGroup())
		for i, v in ipairs(prone.AlwaysAllowedRanks) do
			if PlyRank == string.lower(v) then
				allowed = true
				break
			end
		end
	else
		allowed = true
	end

	if allowed then
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

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))

	ply:AnimRestartMainSequence()

	ply:SetProneAnimationState(0)
	hook.Call("PlayerEnteredProne", nil, ply)
end

-- Handles the getting up animation (unless it is forced), then goes over to ExitProne to actually exit prone
function prone.EndProne(ply, forced)
	if not IsValid(ply) then return end
	ply.Prone_EndTime = CurTime()

	if not forced then
		net.Start("Prone_EndProneAnimation")
			net.WriteEntity(ply)
		net.Broadcast()

		local length = ply:SequenceDuration(ply:SelectWeightedSequence(ACT_GET_UP_STAND))
		ply.Prone_GetUpTime = length + ply.Prone_EndTime
		ply:SetProneAnimationLength(ply.Prone_GetUpTime)

		local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
		if weapon then
			weapon:SetNextPrimaryFire(ply.Prone_GetUpTime)
			weapon:SetNextSecondaryFire(ply.Prone_GetUpTime)
		end

		ply:AnimRestartMainSequence()
		ply:SetProneAnimationState(2)
	else
		prone.ExitProne(ply)
	end
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
	hook.Call("PlayerExittedProne", nil, ply)
end
