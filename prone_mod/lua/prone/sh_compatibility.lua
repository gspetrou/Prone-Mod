-- This file contains extra compatibility for certain addons.
local hooktable = hook.GetTable()

if SERVER then
	-- Support for the Shrink Ray Mod.
	-- What I do to make this addon compatible is gross, any real coders reading this please shield your eyes.
	if type(hooktable.Think) == "table" and type(hooktable.Think["Shit goes down with my pro code - alex5511"]) == "function" then
		hook.Remove("Think", "Shit goes down with my pro code - alex5511")

		-- It's probably not smart to be overriding stuff like this, but he hasn't touched it in two years...
		-- Also, I'm not here to optimize his code. I'm just going to make it work with mine.
		local ENTITY = FindMetaTable("Entity")
		local OldSetModelScale = ENTITY.SetModelScale
		function ENTITY:SetModelScale(scale, delta)
			if self:IsProne() then
				self:PrintMessage(HUD_PRINTTALK, "You can't change your scale while prone!")
			else
				OldSetModelScale(self, scale, delta)
			end
		end

		hook.Add("Think", "Shit goes down with my pro code - alex5511", function()
			-- I feel bad for any server using this addon.
			for i, v in ipairs(player.GetAll()) do
				local scale = v:GetModelScale()
				v:SetWalkSpeed(250*scale)
				v:SetRunSpeed(500*scale)
				v:SetJumpPower(200*scale)
			end
		end)
	end
end