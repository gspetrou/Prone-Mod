if SERVER then
	function PLUGIN:DoPlayerDeath(ply)
		if ply:IsProne() then
			prone.End(ply, true)
		end
	end
end

function PLUGIN:PlayerCanRagdoll(ply)
	if ply:IsProne() then
		return false
	end
end
