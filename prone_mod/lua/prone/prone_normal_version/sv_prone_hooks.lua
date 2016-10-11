-- Copyright 2016 George "Stalker" Petrou, enjoy!

local PLAYER = FindMetaTable("Player")
PLAYER.Prone_LastProneRequestDelay = 0
PLAYER.Prone_LastBindKeyPress =  0

-- Without this server only variable we would have to call ply:IsProne() a lot
-- which is a bit more expensive
PLAYER.InProne = false

hook.Add("DoPlayerDeath", "Prone_ExitOnDeath", function(ply)
	if ply.InProne then
		prone.EndProne(ply, true)
	end
end)

timer.Create("Prone_ManagePlayerActions", 2, 0, function()
	for i, v in ipairs(player.GetAll()) do
		if v.InProne then
			if v:GetMoveType() == MOVETYPE_NOCLIP then 
				prone.EndProne(v, true)
			elseif v:WaterLevel() > 1 then
				prone.EndProne(v)
			end
		end
	end
end)

hook.Add("VehicleMove", "Prone_ExitOnEnterVehicle", function(ply)
	if ply.InProne then
		prone.EndProne(ply, true)
	end
end)

if prone.ChatCommand then
	hook.Add("PlayerSay", "Prone_EnterOnChatCommand", function(ply, text)
		local prefix = text[1]

		if prefix == "!" or prefix == "/" then
			if string.lower(string.sub(text, 2)) == prone.ChatCommand then
				ply:HandleProne()

				if prefix == "/" then
					return ""
				end
			end
		end
	end)
end

if prone.BindKey then
	if prone.BindKeyDoubleTap then
		hook.Add("KeyPress", "Prone_BindKeyDoubleTap", function(ply, key)
			if ply:GetInfoNum("prone_bindkey_enabled", 1) == 1 then
				if key == prone.BindKey then
					if (ply.Prone_LastBindKeyPress or 0) < CurTime() then
						ply.Prone_LastBindKeyPress = CurTime() + .8
					else
						ply:HandleProne()
						ply.Prone_LastBindKeyPress = 0
					end
				elseif prone.JumpToGetUp and key == IN_JUMP and ply.InProne then
					if prone.JumpToGetUpDoubleTap then
						if (ply.Prone_LastBindKeyPress or 0) < CurTime() then
							ply.Prone_LastBindKeyPress = CurTime() + .8
						else
							ply:HandleProne()
							ply.Prone_LastBindKeyPress = 0
						end
					else
						ply:HandleProne()
						ply.Prone_LastBindKeyPress = 0
					end
				end
			end
		end)
	else
		hook.Add("KeyPress", "Prone_BindKeySingleTap", function(ply, key)
			if (ply:GetInfoNum("prone_bindkey_enabled", 1) == 1 and key == prone.BindKey) or prone.JumpToGetUp then
				ply:HandleProne()
			end
		end)
	end
end

net.Receive("Prone_PlayerFullyLoaded", function(len, ply)
	local PlayersInProne = {}
	for i, v in ipairs(player.GetAll()) do
		if v.InProne then
			table.insert(PlayersInProne, v:EntIndex())
		end
	end

	if #PlayersInProne > 0 then
		net.Start("Prone_LoadPronePlayersOnConnect")
			net.WriteTable(PlayersInProne)
		net.Send(ply)
	end
end)

net.Receive("Prone_HandleProne", function(len, ply)
	ply:HandleProne()
end)
