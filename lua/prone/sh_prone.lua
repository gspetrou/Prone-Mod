-- Made by George "Stalker" Petrou, enjoy!

util.PrecacheModel("models/player/p_kleiner.mdl")
util.PrecacheModel("models/player/p_alyx.mdl")

local GameMode = tobool(DarkRP) and "darkrp" or engine.ActiveGamemode()
local PLY = FindMetaTable("Player")

function PLY:IsProne()
	return self:GetNW2Bool("prone_isprone")
end

function PLY:GetProneAnimState()
	return self:GetNW2Int("prone_animstate")
end

function PLY:SetProneAnimState(state)
	self:SetNW2Int("prone_animstate", state)
end

function PLY:GetProneAnimLength()
	return self:GetNW2Float("prone_animlength")
end

function PLY:SetProneAnimLength(len)	-- Used for get up/get down animations
	self:SetNW2Float("prone_animlength", len)
end
