-- The prone.PlayerStateData class simply stores some data about the given player's current prone state.
prone.PlayerStateDatas = prone.PlayerStateDatas or {}	-- Stores state data objects for players.

-- The class itself.
prone.PlayerStateData = {
	Player = 0,
	PlayerSteamID = "",
	OriginalViewOffset = Vector(0, 0, 64),
	OriginalViewOffsetDucked = Vector(0, 0, 28),
	StartTime = 0,
	GetDownTime = 0,
	EndTime = 0,
	GetUpTime = 0,
	EnterProneAnimLength = 0,
	EndProneAnimLength = 0
}

-- Generate simple getters and setters:
local preSettersGettersAdded = table.Copy(prone.PlayerStateData)
for k, v in pairs(preSettersGettersAdded) do
	prone.PlayerStateData["Get"..k] = function(self)
		return self[k]
	end
	prone.PlayerStateData["Set"..k] = function(self, newVal)
		self[k] = newVal
	end
end

function prone.PlayerStateData:__tostring()
	return "Prone state data for player '".. (IsValid(self.Player) and self.Player:Nick() or "INVALID PLAYER'")
end

------------------------------------------------
-- prone.PlayerStateData:UpdateDataOnProneEnter
------------------------------------------------
-- Desc:		Updates prone state data of a given player when they go to enter prone.
function prone.PlayerStateData:UpdateDataOnProneEnter()
	self.PlayerSteamID = self.Player:SteamID()
	self.OriginalViewOffset = self.Player:GetViewOffset()
	self.OriginalViewOffsetDucked = self.Player:GetViewOffsetDucked()
	self.StartTime = CurTime()

	local seq = prone.Animations.gettingdown

	self.EnterProneAnimLength = self.Player:SequenceDuration(self.Player:LookupSequence(seq))
	self.GetDownTime = self.EnterProneAnimLength + self.StartTime
end


------------------------------------------
-- prone.PlayerStateData:UpdateOnProneEnd
------------------------------------------
-- Desc:		Updates prone state data of a given player when they go to end prone.
-- Arg One:		Player.
function prone.PlayerStateData:UpdateOnProneEnd(ply)
	self.EndTime = CurTime()

	local seq = prone.Animations.gettingup

	self.EndProneAnimLength = self.Player:SequenceDuration(self.Player:LookupSequence(seq))
	self.GetUpTime = self.EndProneAnimLength + self.EndTime
end

-----------------------------
-- prone.PlayerStateData:New
-----------------------------
-- Desc:		Creates and returns a new prone.PlayerStateData object.
-- Arg One:		Player entity, whose state data this is.
-- Returns:		prone.PlayerStateData object.
function prone.PlayerStateData:New(ply)
	data = {Player = ply}
	setmetatable(data, self)
	self.__index = self
	return data
end