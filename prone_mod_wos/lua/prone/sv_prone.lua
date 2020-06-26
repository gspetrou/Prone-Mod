hook.Add("DoPlayerDeath", "prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)

hook.Add("PlayerSpawn", "prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)

if prone.Config.FallDamageMultiplier ~= 1 then
	hook.Add("GetFallDamage", "prone.FallDamage", function(ply, speed)
		if ply:IsProne() then
			local oldFallDamage = 10

			-- Copied from the base gamemode.
			if GetConVar("mp_falldamage"):GetInt() > 0 then
				oldFallDamage = (speed - 526.5) * (100 / 396)
			end

			return oldFallDamage * prone.Config.FallDamageMultiplier
		end
	end)
end