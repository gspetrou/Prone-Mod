hook.Add("DoPlayerDeath", "prone.ExitOnDeath", function(ply)
	if ply:IsProne() then
		prone.Exit(ply)
	end
end)

hook.Add("PlayerInitialSpawn", "prone.Initialize", function(ply)
	ply.prone = ply.prone or {}
end)