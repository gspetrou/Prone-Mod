function PLUGIN:PlayerCharacterInitialized()
	timer.Create("Prone_ManageFakeModelsCW", .5, 0, function()
		for i, v in ipairs(player.GetAll()) do
			if IsValid(v.ProneModel) and IsValid(v:GetSharedVar("Ragdoll")) then
				v.ProneModel:Remove()
				v.ProneModel = nil
			end
		end
	end)
end
