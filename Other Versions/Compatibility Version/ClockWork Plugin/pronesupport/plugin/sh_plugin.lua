if SERVER then
	function PLUGIN:DoPlayerDeath(ply)
		if ply:IsProne() then
			prone.Exit(ply)
		end
	end
end

function PLUGIN:PlayerCanRagdoll(ply)
	if ply:IsProne() then
		return false
	end
end
