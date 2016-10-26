-- Copyright 2016 George "Stalker" Petrou, enjoy!
util.AddNetworkString("Prone.RequestProne")
util.AddNetworkString("Prone.GetUpWarning")
util.AddNetworkString("Prone.Entered")
util.AddNetworkString("Prone.Exit")
util.AddNetworkString("Prone.PlayerFullyLoaded")
util.AddNetworkString("Prone.ResetMainAnimation")

local compatibility_mode = prone.IsCompatibility()

net.Receive("Prone.RequestProne", function(_, ply)
	if ply.prone.lastrequest <= CurTime() then
		prone.Handle(ply)
		ply.prone.lastrequest = CurTime() + 1.25
	end
end)

local PLAYER = FindMetaTable("Player")
function PLAYER:CanExitProne()
	local tr = util.TraceHull{
		start = self:GetPos(),
		endpos = self:GetPos(),
		filter = self,
		mins = Vector(-16, -16, 0), -- make this use obbs as reference
		maxs = Vector(16, 16, 78)
	}

	if tr.Hit then
		net.Start("Prone.GetUpWarning")
		net.Send(self)
	end

	return not tr.Hit
end

function prone.Handle(ply)
	if not IsValid(ply) or not ply:Alive() then
		return
	end

	if GAMEMODE_NAME == "darkrp" or GAMEMODE.DerivedFrom == "darkrp" then
		local should_check_job = true
		local rank = ply:GetUserGroup()
		for i, v in ipairs(prone.config.Darkrp_BypassRanks) do
			if v == rank then
				should_check_job = false
				break
			end
		end

		if should_check_job then
			local jobfound = false
			local ply_darkrpjob = ply:Team()
			for i, v in ipairs(prone.config.Darkrp_Joblist) do
				if ply_darkrpjob == v then
					if prone.config.Darkrp_IsWhitelist then
						jobfound = true
					else
						return
					end
					break
				end
			end

			if not jobfound then
				return
			end
		end
	elseif GAMEMODE_NAME == "prop_hunt" or GAMEMODE.DerivedFrom == "prop_hunt" then
		local preptime = GetGlobalFloat("RoundStartTime", 0) + HUNTER_BLINDLOCK_TIME

		if not GetGlobalBool("InRound", false) or preptime > CurTime() or ply:Team() ~= TEAM_HUNTERS then
			return
		end
	elseif GAMEMODE.DerivedFrom == "clockwork" then
		if ply:IsRagdolled() then
			return
		end
	end

	if ply:IsProne() then
		if ply:CanExitProne() then
			local hookresult = hook.Call("Prone.CanExit", nil, ply) == nil and false or true
			if hookresult then
				prone.End(ply)
			end
		end
	else
		if ply:GetMoveType() ~= MOVETYPE_NOCLIP and ply:IsFlagSet(FL_ONGROUND) and ply:WaterLevel() <= 1 then
			local hookresult = hook.Call("Prone.CanEnter", nil, ply) == nil and false or true
			if hookresult then
				prone.Enter(ply)
			end
		end
	end
end

function prone.Enter(ply)
	if not IsValid(ply) then
		return
	end

	if compatibility_mode then
		-- We store their old info here
		local numbodygroups = ply:GetNumBodyGroups()
		local body_groups = ""
		for i = 0, numbodygroups do
			body_groups = body_groups..tostring(ply:GetBodygroup(i))
		end

		ply.prone.cl_modeldata = {
			model = ply:GetModel(),
			color = ply:GetColor(),
			rendermode = ply:GetRenderMode(),
			viewoffset = ply:GetViewOffset(),
			viewoffset_ducked = ply:GetViewOffsetDucked(),
			proxycolor = ply:GetPlayerColor(),
			skin = ply:GetSkin(),
			bodygroups = body_groups
		}

		-- Now override it with our stuff here
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, 0))
		ply:SetModel("models/player/kleiner.mdl")
	end

	ply.prone.starttime = CurTime()
	local seq
	if not ply:Crouching() then
		seq = prone.animations.gettingdown
	else
		seq = prone.animations.gettingdown_crouch
	end

	local length = ply:SequenceDuration(ply:LookupSequence(seq))
	ply.prone.getdowntime = length + ply.prone.starttime
	ply:SetProneAnimationLength(ply.prone.getdowntime)

	net.Start("Prone.Entered")
		net.WritePlayer(ply)
		if compatibility_mode then
			net.WriteString(ply.prone.cl_modeldata.model)
			local c = ply.prone.cl_modeldata.color
			net.WriteColor(Color(c.r, c.g, c.b, c.a))
			net.WriteString(ply.prone.cl_modeldata.bodygroups)
			net.WriteVector(ply.prone.cl_modeldata.proxycolor)
			net.WriteUInt(ply.prone.cl_modeldata.skin, 5)
		end
	net.Broadcast()

	ply.prone.oldviewoffset = ply:GetViewOffset()
	ply.prone.oldviewoffset_ducked = ply:GetViewOffsetDucked()

	local weapon = ply:GetActiveWeapon()
	if IsValid(weapon) then
		weapon:SetNextPrimaryFire(ply.prone.getdowntime)
		weapon:SetNextSecondaryFire(ply.prone.getdowntime)
	end

	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

	ply:AnimRestartMainSequence()
	ply:SetProneAnimationState(PRONE_GETTINGDOWN)

	hook.Call("Prone.OnPlayerEntered", nil, ply, length)
end

-- Gets up and exits prone, unless forced is true. Then it wont play the get up animation.
function prone.End(ply, forced)
	if not IsValid(ply) then
		return
	end

	ply.prone.endtime = CurTime()
	local length = 0

	if forced ~= true then
		net.Start("Prone.ResetMainAnimation")
			net.WritePlayer(ply)
		net.Broadcast()
		
		local seq
		if not ply:Crouching() then
			seq = prone.animations.gettingup
		else
			seq = prone.animations.gettingup_crouch
		end

		length = ply:SequenceDuration(ply:LookupSequence(seq))
		ply.prone.getuptime = length + ply.prone.endtime - .1
		ply:SetProneAnimationLength(ply.prone.getuptime)

		local weapon = ply:GetActiveWeapon()
		if IsValid(weapon) then
			weapon:SetNextPrimaryFire(ply.prone.getuptime)
			weapon:SetNextSecondaryFire(ply.prone.getuptime)
		end

		ply:AnimRestartMainSequence()
		ply:SetProneAnimationState(PRONE_GETTINGUP)
	else
		prone.Exit(ply)
	end
end

-- Actually leaving prone, call Prone.End with the second arguement as true rather than calling this directly.
function prone.Exit(ply)
	if not IsValid(ply) then
		return
	end

	ply:SetViewOffset(ply.prone.oldviewoffset)
	ply:SetViewOffsetDucked(ply.prone.oldviewoffset_ducked)
	ply:ResetHull()

	if compatibility_mode then
		ply:SetViewOffset(ply.prone.cl_modeldata.viewoffset)
		ply:SetViewOffsetDucked(ply.prone.cl_modeldata.viewoffset_ducked)
		ply:SetModel(ply.prone.cl_modeldata.model)
		ply:SetRenderMode(ply.prone.cl_modeldata.rendermode)
		ply:SetColor(ply.prone.cl_modeldata.color)
		ply:SetSkin(ply.prone.cl_modeldata.skin)
		ply:SetPlayerColor(ply.prone.cl_modeldata.proxycolor)
		ply:SetBodyGroups(ply.prone.cl_modeldata.body_groups)
	end

	net.Start("Prone.Exit")
		net.WritePlayer(ply)
		if compatibility_mode then
			net.WriteString(ply.prone.cl_modeldata.model)
			local c = ply.prone.cl_modeldata.color
			net.WriteColor(Color(c.r, c.g, c.b, c.a))
			net.WriteString(ply.prone.cl_modeldata.bodygroups)
			net.WriteVector(ply.prone.cl_modeldata.proxycolor)
			net.WriteUInt(ply.prone.cl_modeldata.skin, 5)
			ply.prone.cl_modeldata = {}
		end
	net.Broadcast()

	ply:SetProneAnimationState(PRONE_NOTINPRONE)
	hook.Call("Prone.OnPlayerExitted", nil, ply)
end

net.Receive("Prone.PlayerFullyLoaded", function(_, ply)
	local proneplayers = {}
	for i, v in ipairs(player.GetAll()) do
		if v:IsProne() then
			table.insert(proneplayers, v)
		end
	end

	if #proneplayers > 0 then
		net.Start("Prone.PlayerFullyLoaded")
			net.WriteUInt(#proneplayers, 7)
			if compatibility_mode then
				for i, v in ipairs(proneplayers) do
					net.WritePlayer(v)
					net.WriteString(ply.prone.cl_modeldata.model)
					local c = ply.prone.cl_modeldata.color
					net.WriteColor(Color(c.r, c.g, c.b, c.a))
					net.WriteString(ply.prone.cl_modeldata.bodygroups)
					net.WriteVector(ply.prone.cl_modeldata.proxycolor)
					net.WriteUInt(ply.prone.cl_modeldata.skin, 5)
				end
			else
				for i, v in ipairs(proneplayers) do
					net.WritePlayer(v)
				end
			end

		net.Send(ply)
	end
end)

hook.Add("DoPlayerDeath", "Prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.End(ply, true)
	end
end)

hook.Add("PlayerNoClip", "Prone.ExitOnNoclip", function(ply)
	if IsFirstTimePredicted() and ply.InProne then
		prone.EndProne(ply, true)
	end
end)

hook.Add("VehicleMove", "Prone.ExitOnVehicleEnter", function(ply)
	if ply:IsProne() then
		prone.Prone(ply, true)
	end
end)

timer.Create("Prone.Manage", 1, 0, function()
	for i, v in ipairs(player.GetAll()) do
		if v:IsProne() then
			if v:GetMoveType() == MOVETYPE_NOCLIP then
				prone.End(v, true)
			elseif v:WaterLevel() > 1 and not v:ProneIsGettingUp() then
				prone.End(v)
			end
		end
	end
end)

if compatibility_mode then
	util.AddNetworkString("Prone.UpdateModel")

	function prone.UpdateFakeModel(ply, model)
		net.Start("Prone.UpdateModel")
			net.WritePlayer(ply)
			net.WriteString(model)
		net.Broadcast()
	end

	local hookname
	if DerivGAMEMODE == "nutscript" then
		hookname = "PostPlayerLoadout"
	else
		hookname = "PlayerLoadout"
	end
	
	hook.Add(hookname, "Prone.LoadoutFix", function(ply)
		if ply:IsProne() then
			ply.prone.cl_modeldata.model = ply:GetModel()
			prone.UpdateProneModel(ply, ply.prone.cl_modeldata.model)

			ply:SetModel("models/player/kleiner.mdl")
			ply.prone.cl_modeldata.color = ply:GetColor()
		end
	end)

	hook.Add("TTTPrepareRound", "Prone_FixRemove", function()
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				prone.End(v)
			end
		end
	end)

	hook.Add("TTTBeginRound", "Prone_FixRemove", function()
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				prone.End(v)
			end
		end
	end)

	hook.Add("PlayerDisconnected", "Prone.CleanFakeModel", function(ply)
		if ply:IsProne() then
			net.Start("Prone.Exit")
				net.WriteEntity(ply)
			net.Broadcast()
		end
	end)
end
