-- Made by George "Stalker" Petrou, enjoy!

util.AddNetworkString("Prone_HandleProne")
util.AddNetworkString("Prone_StartProne")
util.AddNetworkString("Prone_EndProne")

local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()
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

	if not self.AllowAllProne then
		if #prone.AlwaysAllowedRanks > 0 then
			local PlyRank = string.lower(self:GetUserGroup())
			for i, v in ipairs(prone.AlwaysAllowedRanks) do
				if PlyRank == string.lower(v) then
					allowed = true
					break
				end
			end
		end
	else
		allowed = true
	end

	if allowed then
		if not self:IsProne() then
			if self:GetMoveType() ~= MOVETYPE_NOCLIP and self:IsFlagSet(FL_ONGROUND) and self:WaterLevel() <= 1 then
				prone.StartProne(self)
			end
		else
			if self:CanExitProne() then
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
		self:PrintMessage(HUD_PRINTTALK, "There isn't enough room to stand up!")
	end
	
	return not tr.Hit
end

function prone.StartProne(ply)
	if not IsValid(ply) then return end

	ply:SetNW2Bool("prone_isprone", true)
	ply.Prone_StartTime = CurTime()
	------------------
	------------------

	ply.Prone_OldModel = ply:GetModel()
	ply.Prone_OldColor = ply:GetColor()
	ply.Prone_OldRenderMode = ply:GetRenderMode()
	ply.Prone_OldViewOffset = ply:GetViewOffset()
	ply.Prone_OldViewOffsetDucked = ply:GetViewOffsetDucked()
	ply.Prone_OldWalkSpeed = ply:GetWalkSpeed()
	ply.Prone_OldRunSpeed = ply:GetRunSpeed()
	ply.Prone_CanAltWalk = ply:GetCanWalk()
	ply:SetRenderMode(RENDERMODE_TRANSALPHA)
	ply:SetColor(Color(255, 255, 255, 0))
	------------------
	------------------

	local function FindName(word)
		return tobool(string.find(string.lower(ply.Prone_OldModel), word))
	end

	local ProneMdl = "models/player/p_kleiner.mdl"
	if FindName("female") or FindName("alyx") or FindName("mossman") then
		ProneMdl = "models/player/p_alyx.mdl"	-- Doesn't make too much of a difference but why not
	end

	ply:SetModel(ProneMdl)

	local _, length = ply:LookupSequence("ProneDown_Stand")
	ply:SetProneAnimLength(length + ply.Prone_StartTime)
	------------------
	------------------
	local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
	if weapon then
		local delay = length + ply.Prone_StartTime
		weapon:SetNextPrimaryFire(delay)
		weapon:SetNextSecondaryFire(delay)
	end

	ply:SetWalkSpeed(prone.ProneSpeed)
	ply:SetRunSpeed(prone.ProneSpeed)
	ply:SetCanWalk(false)

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 24))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 24))
	------------------
	------------------

	net.Start("Prone_StartProne")
		net.WriteEntity(ply)
		net.WriteString(ply.Prone_OldModel)
		net.WriteColor(Color(ply.Prone_OldColor.r, ply.Prone_OldColor.g, ply.Prone_OldColor.b, ply.Prone_OldColor.a))
	net.Broadcast()

	ply:SetProneAnimState(0)
end

-- Handles the animations, unless you set forced to true, then it jumps to prone.ExitProne
function prone.EndProne(ply, forced)
	if not IsValid(ply) then return end
	ply.Prone_EndTime = CurTime()

	if not forced then	
		local _, length = ply:LookupSequence("ProneDown_Stand")
		ply:SetProneAnimLength(length + ply.Prone_EndTime)
		ply:SetProneAnimState(2)
	else
		prone.ExitProne(ply)
	end
end

-- Actually exits prone, prone.EndProne just sets up the animation to exit
function prone.ExitProne(ply)
	if not IsValid(ply) then return end

	ply:SetNW2Bool("prone_isprone", false)

	ply:SetModel(ply.Prone_OldModel)
	ply:SetRenderMode(ply.Prone_OldRenderMode)
	ply:SetViewOffset(ply.Prone_OldViewOffset)
	ply:SetViewOffsetDucked(ply.Prone_OldViewOffsetDucked)
	ply:SetWalkSpeed(ply.Prone_OldWalkSpeed)
	ply:SetRunSpeed(ply.Prone_OldRunSpeed)
	ply:SetCanWalk(ply.Prone_CanAltWalk)
	ply:ResetHull()

	net.Start("Prone_EndProne")
		net.WriteEntity(ply)
	net.Broadcast()

	ply:SetColor(ply.Prone_OldColor)
end