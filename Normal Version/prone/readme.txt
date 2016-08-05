Copyright 2016 George "Stalker" Petrou

The Prone Mod - https://scriptfodder.com/scripts/view/1975

Created by Stalker - http://steamcommunity.com/profiles/76561197996451757/
Models by Stiffy360 - http://steamcommunity.com/profiles/76561198025319188/

Message to reader:
	If you intend on leaking this addon I can not stop you. Although it is a compliment to see people trying
	to get their hands on my code it is also shitty because well, you're stealing it from me. All I ask is that before
	leaking my addon you place yourself in my shoes and think about how much it sucks to have something
	you spent hours making being given out by someone else for free. Either way, enjoy!

########################################################################
########################################################################

Place the Prone folder into your addons folder

MAKE SURE YOU INSTALL THE WORKSHOP MODELS ON THE CLIENTS AND THE SERVER:
http://steamcommunity.com/sharedfiles/filedetails/?id=609281761

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
	
	Hooks:
	CanPlayerEnterProne(Player)		-- Server. Called in Player:HandleProne(). Return false to prevent them from going prone.
	CanPlayerLeaveProne(Player)		-- Server. Called in Player:HandleProne(). Return false to prevent them from exitting prone. Player:CanExitProne() is already called on them before this.
	PlayerEnteredProne(Player, length)		-- Server. Called just as soon as the player starts getting down. Second arg is the time to get down.
	PlayerExittedProne(Player, length)		-- Server. Called just as the player finished getting up. Second arg is the time to get up.

########################################################################
########################################################################

Changelog:
	2.2.7
		- Clockwork/Nutscript Update
	2.2.6
		- Fixed falling while prone and shooting causing you to freeze in the air
	2.2.5
		- Fixed bug with view transitions caused by update 2.2.4
	2.2.4
		- Added option to exit prone by pressing space
		- More optimizations
	2.2.3
		- [Clockwork] Minor playermodel string bug fixes
		- Fixed rare pronebutton error
	2.2.2
		- Added prone_bindkey_enabled for clients. If set to 0 clicking the bindkey wont set the player prone
	2.2.1
		- Removed !proneconfig and reverted back to IN enums, they were unreliable
	2.2.0
		- Added "length" arguement to the PlayerEnteredProne and PlayerExittedProne hooks
		- Fixed major issue with restricting by rank
		- Added config options for playing sounds when entering, exitting, or moving while prone
	2.1.1
		- Fixed bug with the !proneconfig command
		- Added a Prone Config category to the sandbox Utilities tab
	2.1.0
		- Switched back to KEY_ enums, for real this time
		- Added prop hunt support
		- Added config menu (!proneconfig in chat or prone_config in console)
		- Included a NutScript/Clockwork version in the bundle, right now it is just version 1.3.3
		- Switched back to NW2 vars
	2.0.1 - NOT COMPATIBLE WITH NUTSCRIPT/CLOCKWORK
		- Fixed chat bug with DarkRP
		- Reverted back to IN_ enums for stability
	2.0.0 - NOT COMPATIBLE WITH NUTSCRIPT/CLOCKWORK
		- Switched over to custom base animation files
		- Added hooks
		- Fixed get up/get down speed
		- Overall stability improvements
		- PAC3 support
		- Better CombineControl support
		- Added an option to enter prone via a chat command
		- Switched to KEY_ enums for the bind key
		- Player doesn't snap to new direction when turning
		- Switched back to ACT enums instead of sequences
		- So many optimizations!
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
