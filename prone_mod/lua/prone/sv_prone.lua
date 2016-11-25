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