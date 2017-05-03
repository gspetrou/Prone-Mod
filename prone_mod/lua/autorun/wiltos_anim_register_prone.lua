--[[-------------------------------------------------------------------
	wiltOS Animation Register:
		A simple register to keep track of all wiltOS extensions installed
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
-------------------------------------------------------------------]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
----------------------------------------]]--
wOS = wOS or {}
wOS.AnimExtension = wOS.AnimExtension or {}
wOS.AnimExtension.Mounted = wOS.AnimExtension.Mounted or {}

wOS.AnimExtension.Mounted["Prone Mod"] = true
print("[wOS] wiltOS Animation Extension for Prone Mod has been mounted successfully!")

timer.Simple(10, function()
	if not wOS.AnimExtension.Mounted["Base"] then 
		print("[wOS] ERROR: You do not have the wiltOS Animation Base installed. Extension can not be integrated with player models.")
	end
end)