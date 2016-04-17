-- Made by George "Stalker" Petrou, enjoy!

local PLY = FindMetaTable("Player")
function PLY:IsProne()
	return self:GetNW2Bool("prone_isprone")
end

--[[ States:
		0 = Getting down
		1 = In Prone
		2 = Getting up
	Any other number (typically the number 3) means not prone
]]
function PLY:SetProneAnimationState(state)
	self:SetNW2Int("prone_animstate", state)
end

function PLY:GetProneAnimationState()
	return self:GetNW2Int("prone_animstate")
end

function PLY:SetProneAnimationLength(len)	-- Used for get up/get down animations
	self:SetNW2Float("prone_animlength", len)
end

function PLY:GetProneAnimationLength()
	return self:GetNW2Float("prone_animlength")
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