util.AddNetworkString("prone.OnDeath")
util.AddNetworkString("prone.ResetAnimation")

hook.Add("DoPlayerDeath", "prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)

		net.Start("prone.OnDeath")
			prone.WritePlayer(ply)
		net.Broadcast()
	end
end)

hook.Add("PlayerInitialSpawn", "prone.Initialize", function(ply)
	ply.prone = ply.prone or {}
end)

if prone.config.FallDamageMultiplier ~= 1 then
	hook.Add("GetFallDamage", "prone.FallDamage", function(ply, speed)
		if ply:IsProne() then
			local oldFallDamage = 10

			-- Copied from the base gamemode.
			if GetConVar("mp_falldamage"):GetInt() > 0 then
				oldFallDamage = (speed - 526.5) * (100 / 396)
			end

			return oldFallDamage * prone.config.FallDamageMultiplier
		end
	end)
end