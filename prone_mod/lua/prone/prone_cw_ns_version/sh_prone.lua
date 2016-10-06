-- Copyright 2016 George "Stalker" Petrou, enjoy!

util.PrecacheModel("models/player/p_kleiner.mdl")
util.PrecacheModel("models/player/p_alyx.mdl")

local PLY = FindMetaTable("Player")

function PLY:IsProne()
	return self:GetNWBool("prone_isprone")
end

function PLY:GetProneAnimState()
	return self:GetNWInt("prone_animstate")
end

function PLY:SetProneAnimState(state)
	self:SetNWInt("prone_animstate", state)
end

function PLY:GetProneAnimLength()
	return self:GetNWFloat("prone_animlength")
end

function PLY:SetProneAnimLength(len)	-- Used for get up/get down animations
	self:SetNWFloat("prone_animlength", len)
end

if prone.GetUpDownSound then
	sound.Add({
		name = "prone.GetUpDownSound",
		channel = CHAN_AUTO,
		volume = 0.5,
		level = 55,
		pitch = {95, 110},
		sound = prone.GetUpDownSound
	})
end

if prone.GetUpDownSound then
	sound.Add({
		name = "prone.MoveSound",
		channel = CHAN_AUTO,
		volume = 0.5,
		level = 55,
		pitch = {95, 110},
		sound = prone.MoveSound
	})
end