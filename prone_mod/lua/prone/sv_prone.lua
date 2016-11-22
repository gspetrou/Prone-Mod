util.AddNetworkString("prone.EndOnDeath")
hook.Add("DoPlayerDeath", "prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
		
		net.Start("prone.EndOnDeath")
			prone.WritePlayer(ply)
		net.Broadcast()
	end
end)

hook.Add("PlayerInitialSpawn", "prone.Initialize", function(ply)
	ply.prone = ply.prone or {}
	ply.prone = ply.prone.ShouldModify or {}
end)