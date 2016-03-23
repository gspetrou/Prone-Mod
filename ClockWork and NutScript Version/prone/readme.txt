Copyright 2016 George "Stalker" Petrou

The Prone Mod - https://scriptfodder.com/scripts/view/1975
Created by Stalker - http://steamcommunity.com/profiles/76561197996451757/

This is the ClockWork/NutScript version of the Prone Mod. This version is missing a few
features because of the way CW/NS handle player animations. While having one unified version
of the Prone Mod would be great the benefits for other gamemodes greatly outweighs the negatives
that CW and NS must suffer. Sorry but nothing can be done about this.

Message to reader:
	If you intend on leaking this addon I can not stop you. Although it is a compliment to see people trying
	to get their hands on my code it is also shitty because well, you're stealing it from me. All I ask is that before
	leaking my addon you place yourself in my shoes and think about how much it sucks to have something
	you spent hours making being given out by someone else for free. Either way, enjoy!

########################################################################
########################################################################

Place the prone folder into your addons folder

MAKE SURE YOU INSTALL THE WORKSHOP MODELS ON THE CLIENTS AND THE SERVER:
http://steamcommunity.com/sharedfiles/filedetails/?id=609281761

ClockWork Support:
	There is a folder in the same place as this readme named "Clockwork Support".
	Open the "Clockwork Support" folder and move the "pronesupport" folder inside of it
	to /garrysmod/gamemodes/clockwork/plugins/. That should ensure compatibility with Clockwork.

########################################################################
########################################################################

/////////////////////////////////
//// Developer Documentation ////
/////////////////////////////////

Lua Documentation:

	Functions:
	function Player:IsProne()				-- Shared (Networked). Returns if the player is currently prone.
	function Player:HandleProne()			-- Server. Decides if the player can, then either puts them into or exits them from prone.
	function prone.ProneToggle()			-- Client. Calls Player:HandleProne().
	
	function prone.StartProne(player)		-- Server. Puts them in prone. May fuck up if they are already in prone.
	function prone.EndProne(player, forced)	-- Server. If the second arguement is true they will force exit, instantly, without a leaving animation. May fuck up if they are not in prone already.

########################################################################
########################################################################

Changelog:

	1.3.3
		- Fixes bug with PlayerColor and Skins on connect
		- Fixes kicking while prone bug for sure
		- Switch to NW vars instead of NW2 vars
		- Fixed the FallOver feature with ClockWork (included in seperate link, check FAQ)
	1.3.2
		- Player skin support
		- PlayerColor support
		Big thanks to Bull for this update!
	1.3.1
		- Fixes oversight with changing models
		- Added bodygroup support for real
	1.3.0
		- Added body group support when entering prone
		- Fixed speed bug
		- Added warnings if you try to use the addon without the prone models on the server
		- Fixed bug with restricting moving and shooting
		- Fixed NutScript bug with changing jobs
		- ClockWork support
		- More optimizations
	1.2.1
		- Fixes issues with changing job in DarkRP
		- Fixes issues with kicking proned players
	1.2.0
		- Fixes model twitching when clicking the jump button
		- Fixes invisibility bug
		- Fixes DarkRP and TTT incompatability issues
		- Fixes weapon/player color issues
		- Major optimizations
		- No more twitching when exitting and entering prone
	1.1.4
		- Fixes oversight with shooting and moving
	1.1.3
		- Fixes issue with custom weapons
		- Fixes issue with fists (no weapon)
	1.1.2
		- Fixes major PVS bug
	1.1.1
		- Fixed many bugs involving Trouble in Terrorist Town
		- Fixed invisible weapons
		- Your body now tilts with the way you look
		- Made the addon a bit more robust
	1.1.0
		- Support for any model!
		- Fixes bugs involving having no weapons
		- Plenty of optimization fixes
		- Cleaned up config a bit, removed useless options
		- Improved CanExitProne
		- Switched to sequencing animations rather than ACT events
		- Fixed multiple edge cases which would cause errors
	1.0.4
		- Fixed going prone without a weapon
	1.0.3
		- Better Deathrun support
	1.0.2
		-	Models moved to workshop
	1.0.1
		-	Better NutScript Support
	1.0.0
		-	Initial Release	