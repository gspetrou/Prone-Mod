---------------------
-- Setup net messages
---------------------
util.AddNetworkString("Prone.RequestProne")
util.AddNetworkString("Prone.GetUpWarning")
util.AddNetworkString("Prone.Entered")
util.AddNetworkString("Prone.Exit")
util.AddNetworkString("Prone.ResetMainAnimation")

------------------------------------------------------------
-- Define the main functions for entering and exitting prone
------------------------------------------------------------

-- Where general stuff and gamemode specific checks are done.
local function ProneGamemodeChecks(ply)
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
						return false
					end
					break
				end
			end

			if not jobfound then
				return false
			end
		end
	elseif GAMEMODE_NAME == "prop_hunt" or GAMEMODE.DerivedFrom == "prop_hunt" then
		local preptime = GetGlobalFloat("RoundStartTime", 0) + HUNTER_BLINDLOCK_TIME

		if not GetGlobalBool("InRound", false) or preptime > CurTime() or ply:Team() ~= TEAM_HUNTERS then
			return false
		end
	elseif GAMEMODE.DerivedFrom == "clockwork" then
		if ply:IsRagdolled() then
			return false
		end
	end

	return true
end

function prone.CanExit(ply)
	-- Check if there is enough space to get up
	local tr = util.TraceHull{
		start = ply:GetPos(),
		endpos = ply:GetPos(),
		filter = ply,
		mins = Vector(-16, -16, 0),
		maxs = Vector(16, 16, 78)
	}
	if tr.Hit then
		net.Start("Prone.GetUpWarning")
		net.Send(ply)

		return not tr.Hit
	end

	-- See if other addons want to restrict this.
	local hookresult = hook.Call("Prone.CanExit", nil, ply)
	if hookresult ~= nil then
		return hookresult
	end

	-- If not then check for the active gamemode.
	return ProneGamemodeChecks(ply)
end

function prone.CanEnter(ply)
	local hookresult = hook.Call("Prone.CanEnter", nil, ply)
	if hookresult ~= nil then
		return hookresult
	elseif ply:GetMoveType() == MOVETYPE_NOCLIP or not ply:OnGround() or ply:WaterLevel() > 1 then
		return false
	end

	return ProneGamemodeChecks(ply)
end

-- Pretty much toggles between the player being in prone and not in prone.
function prone.Handle(ply)
	if not IsValid(ply) or not ply:Alive() then
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

net.Receive("Prone.RequestProne", function(_, ply)
	if IsValid(ply) and ply.prone.lastrequest <= CurTime() then
		prone.Handle(ply)
		ply.prone.lastrequest = CurTime() + 1.25
	end
end)

-- This will enter a player into prone
function prone.Enter(ply)
	-- Store some data for when they leave prone.
	ply.prone.oldviewoffset = ply:GetViewOffset()
	ply.prone.oldviewoffset_ducked = ply:GetViewOffsetDucked()

	net.Start("Prone.Entered")
	net.WritePlayer(ply)

	if prone.IsCompatibility() then
		local numbodygroups = ply:GetNumBodyGroups()
		local body_groups = ""
		for i = 0, numbodygroups do
			body_groups = body_groups..tostring(ply:GetBodygroup(i))
		end

		ply.prone.cl_modeldata = {
			model = ply:GetModel(),
			color = ply:GetColor(),
			rendermode = ply:GetRenderMode(),
			viewoffset = ply.prone.oldviewoffset,
			viewoffset_ducked = ply.prone.oldviewoffset_ducked,
			proxycolor = ply:GetPlayerColor(),
			skin = ply:GetSkin(),
			bodygroups = body_groups
		}

		-- Make some necessary changes for compatibility mode.
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, 0))
		ply:SetModel("models/player/kleiner.mdl")

		-- Network some extra stuff.
		net.WriteString(ply.prone.cl_modeldata.model)
		local c = ply.prone.cl_modeldata.color
		net.WriteColor(Color(c.r, c.g, c.b, c.a))
		net.WriteString(ply.prone.cl_modeldata.bodygroups)
		net.WriteVector(ply.prone.cl_modeldata.proxycolor)
		net.WriteUInt(ply.prone.cl_modeldata.skin, 5)
	end

	net.Broadcast()	-- Send out the netmessage started above the previous if statement.

	-- Now make our changes
	ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))
	ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, prone.config.HullHeight))

	-- Pick which animation to use.
	ply.prone.starttime = CurTime()
	local seq = prone.animations.gettingdown
	--if ply:Crouching() then
	--	seq = prone.animations.gettingdown_crouch
	--end

	-- Take note of how long that animation takes to play.
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
	hook.Call("Prone.OnPlayerEntered", nil, ply, length)
end

-- Makes the player get up and exit prone. Later calls prone.Exit.
function prone.End(ply)
	ply.prone.endtime = CurTime()
	
	-- We do this so then next animation doesn't start mid-way through.
	ply:AnimRestartMainSequence()
	net.Start("Prone.ResetMainAnimation")
		net.WritePlayer(ply)
	net.Broadcast()

	-- Choose either the standing or crouching get up animation.
	ply.prone.starttime = CurTime()
	local seq = prone.animations.gettingup
	--if ply:Crouching() then
	--	seq = prone.animations.gettingup_crouch
	--end

	-- Record the time.
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

-- This makes the player actually leave prone.
function prone.Exit(ply)
	-- Reset stuff back to how it was before.
	ply:SetViewOffset(ply.prone.oldviewoffset)
	ply:SetViewOffsetDucked(ply.prone.oldviewoffset_ducked)
	ply:ResetHull()
	if prone.IsCompatibility() then
		ply:SetViewOffset(ply.prone.cl_modeldata.viewoffset)
		ply:SetViewOffsetDucked(ply.prone.cl_modeldata.viewoffset_ducked)
		ply:SetModel(ply.prone.cl_modeldata.model)
		ply:SetRenderMode(ply.prone.cl_modeldata.rendermode)
		ply:SetColor(ply.prone.cl_modeldata.color)
		ply:SetSkin(ply.prone.cl_modeldata.skin)
		ply:SetPlayerColor(ply.prone.cl_modeldata.proxycolor)
		ply:SetBodyGroups(ply.prone.cl_modeldata.body_groups)
	end

	-- Send data over to the client so that they can reset to how they were before.
	net.Start("Prone.Exit")
		net.WritePlayer(ply)
		if prone.IsCompatibility() then
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

-- Setup new players with a prone table.
hook.Add("PlayerInitialSpawn", "Prone.MakeTable", function(ply)
	ply.prone = {
		lastrequest = 0
	}
end)

-- Checks to properly exit prone.
hook.Add("DoPlayerDeath", "Prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)
hook.Add("PlayerNoClip", "Prone.ExitOnNoclip", function(ply)
	if IsFirstTimePredicted() and ply:IsProne() then
		prone.Exit(ply)
	end
end)
hook.Add("VehicleMove", "Prone.ExitOnVehicleEnter", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)

-- Use a timer to check if a player should exit prone.
-- This isn't a good solution but its the only one.
local ipairs, player_GetAll = ipairs, player.GetAll
timer.Create("Prone.Manage", 1, 0, function()
	for i, v in ipairs(player_GetAll()) do
		if v:IsProne() and (v:WaterLevel() > 1 and not v:ProneIsGettingUp()) or v:GetMoveType() == MOVETYPE_NOCLIP then
			prone.Exit(v)
		end
	end
end)

if prone.IsCompatibility() then
	util.AddNetworkString("Prone.PlayerInitialized")
	util.AddNetworkString("Prone.UpdateModel")

	-- Updates the fake clientside model that is bonemerged to the prone players.
	function prone.UpdateFakeModel(ply, model)
		net.Start("Prone.UpdateModel")
			net.WritePlayer(ply)
			net.WriteString(model)
		net.Broadcast()
	end

	-- Clean the fake models of disconnecting players.
	hook.Add("PlayerDisconnected", "Prone.CleanFakeModel", function(ply)
		if ply:IsProne() then
			net.Start("Prone.Exit")
				net.WriteEntity(ply)
			net.Broadcast()
		end
	end)

	-- When a player tells us that they are fully loaded then tell them who is prone.
	-- This isn't really exploitable. If they choose not to tell us they are fully loaded all that they
	-- are doing is messing up prediction for themselves till the prone player eventually leaves prone.
	net.Receive("Prone.PlayerInitialized", function(_, ply)
		-- Get all the prone players.
		local proneplayers = {}
		for i, v in ipairs(player.GetAll()) do
			if v:IsProne() then
				table.insert(proneplayers, v)
			end
		end

		if #proneplayers == 0 then
			return
		end

		net.Start("Prone.PlayerInitialized")
			net.WriteUInt(#proneplayers, 7)
			for i, v in ipairs(proneplayers) do
				net.WritePlayer(v)

				net.WriteString(ply.prone.cl_modeldata.model)
				local c = ply.prone.cl_modeldata.color
				net.WriteColor(Color(c.r, c.g, c.b, c.a))
				net.WriteString(ply.prone.cl_modeldata.bodygroups)
				net.WriteVector(ply.prone.cl_modeldata.proxycolor)
				net.WriteUInt(ply.prone.cl_modeldata.skin, 5)
			end
		net.Send(ply)
	end)

	-- TTT support.
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

	local hookname = false
	if GAMEMODE.DerivedFrom == "nutscript" then
		hookname = "PostPlayerLoadout"
	else
		hookname = "PlayerLoadout"
	end
	if hookname then
		hook.Add(hookname, "Prone.LoadoutFix", function(ply)
			if ply:IsProne() then
				ply.prone.cl_modeldata.model = ply:GetModel()
				prone.UpdateProneModel(ply, ply.prone.cl_modeldata.model)

				ply:SetModel("models/player/kleiner.mdl")
				ply.prone.cl_modeldata.color = ply:GetColor()
			end
		end)
	end
end