-- Made by George "Stalker" Petrou, enjoy!

util.AddNetworkString("Prone_HandleProne")
util.AddNetworkString("Prone_StartProne")
util.AddNetworkString("Prone_EndProne")
util.AddNetworkString("Prone_LoadPronedPlayers") -- On Connect
util.AddNetworkString("Prone_UpdateProneModel")
util.AddNetworkString("Prone_SendWarningText")

local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()
local PLY = FindMetaTable("Player")

if not (util.IsValidModel("models/player/dod_player_shared.mdl") and util.IsValidModel("models/player/p_kleiner.mdl") and util.IsValidModel("models/player/p_alyx.mdl")) then
	hook.Add("InitPostEntity", "Prone_NotifyMissingModels", function()
		timer.Create("Prone_NoProneModelWarning", 10, 0, function()
			local allplys = player.GetAll()
		
			for i, v in ipairs(allplys) do
				if v:GetUserGroup() ~= "user" then
					net.Start("Prone_SendWarningText")
						net.WriteString("The prone models are missing from the server, expect issues!")
					net.Broadcast()
				end
			end
		end)
	end)
end

-- This should be the main way players enter/exit prone. Not the other functions bellow.
function PLY:HandleProne()
	if self.Prone_LastProneRequestDelay > CurTime() or not self:Alive() then
		return
	end

	self.Prone_LastProneRequestDelay = CurTime() + 2

	local allowed = true

	if GameMode == "darkrp" then
		if prone.RestrictByJob then
			local PlyJob = string.lower(self:getJobTable().name)
			self.allowedprone = false

			for i, v in ipairs(prone.AllowedJobs) do
				if PlyJob == string.lower(v) then
					self.allowedprone = not prone.JobsIsBlacklist
					break
				end
			end
		end

		if self.Babygod then
			allowed = false
			net.Start("Prone_SendWarningText")
				net.WriteString("You can't go prone while in spawn protection.")
			net.Send(self)

			return
		end
	elseif GameMode == "terrortown" and GetRoundState() == ROUND_PREP then
		allowed = false

		return
	end

	if isfunction(self.GetSharedVar) and self:GetSharedVar("FallenOver") then
		return
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
		if not self.InProne then
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
		net.Start("Prone_SendWarningText")
			net.WriteString("There isn't enough room to stand up!")
		net.Send(self)
	end

	return not tr.Hit
end

function prone.UpdateProneModel(ply, model)
	net.Start("Prone_UpdateProneModel")
		net.WriteEntity(ply)
		net.WriteString(model)
	net.Broadcast()
end

function prone.StartProne(ply)
	if not IsValid(ply) then return end

	ply:SetNWBool("prone_isprone", true)

	ply.InProne = true
	ply.Prone_StartTime = CurTime()
	------------------
	------------------

	local BodyGroupsCount = ply:GetNumBodyGroups()
	local BodyGroups = ""
	for i = 0, BodyGroupsCount do
		BodyGroups = BodyGroups..tostring(ply:GetBodygroup(i))
	end

	ply.Prone_OldModel = ply:GetModel()
	ply.Prone_OldColor = ply:GetColor()
	ply.Prone_OldRenderMode = ply:GetRenderMode()
	ply.Prone_OldViewOffset = ply:GetViewOffset()
	ply.Prone_OldViewOffsetDucked = ply:GetViewOffsetDucked()
	ply.Prone_OldPlayerColor = ply:GetPlayerColor()
	ply.Prone_OldPlayerColor = ply:GetPlayerColor()
	ply.Prone_OldSkin = ply:GetSkin()
	ply.Prone_OldBodyGroups = BodyGroups
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
	if prone.GetUpDownSound then
		ply:EmitSound("prone.GetUpDownSound")
	end

	local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
	if weapon then
		local delay = length + ply.Prone_StartTime
		weapon:SetNextPrimaryFire(delay)
		weapon:SetNextSecondaryFire(delay)
	end

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.HullHeight))
	------------------
	------------------

	net.Start("Prone_StartProne")
		net.WriteEntity(ply)
		net.WriteString(ply.Prone_OldModel)
		net.WriteColor(Color(ply.Prone_OldColor.r, ply.Prone_OldColor.g, ply.Prone_OldColor.b, ply.Prone_OldColor.a))
		net.WriteString(ply.Prone_OldBodyGroups)
		net.WriteInt(ply.Prone_OldSkin, 8)
		net.WriteColor(ply.Prone_OldPlayerColor:ToColor())
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

		if prone.MoveSound and timer.Exists("prone_walksound_"..ply:SteamID()) then
			timer.Remove("prone_walksound_"..ply:SteamID())
		end
		if prone.GetUpDownSound then
			ply:EmitSound("prone.GetUpDownSound")
		end

		local weapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or false
		if weapon then
			local delay = length + ply.Prone_EndTime
			weapon:SetNextPrimaryFire(delay)
			weapon:SetNextSecondaryFire(delay)
		end
	else
		prone.ExitProne(ply)
	end
end

-- Actually exits prone, prone.EndProne just sets up the animation to exit
function prone.ExitProne(ply)
	if not IsValid(ply) then return end

	ply:SetNWBool("prone_isprone", false)
	ply.InProne = false

	ply:SetModel(ply.Prone_OldModel)
	ply:SetRenderMode(ply.Prone_OldRenderMode)
	ply:SetViewOffset(ply.Prone_OldViewOffset)
	ply:SetViewOffsetDucked(ply.Prone_OldViewOffsetDucked)
	ply:ResetHull()

	ply.Prone_AnimWaterFix = false

	net.Start("Prone_EndProne")
		net.WriteEntity(ply)
	net.Broadcast()

	ply:SetColor(ply.Prone_OldColor)
	ply:SetSkin(ply.Prone_OldSkin)
end