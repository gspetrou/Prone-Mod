/////////////////////
/////  General  /////
/////////////////////
-- Set to true so that anybody can go prone no matter what rank or job they are.
-- DEFAULT: false
prone.AllowAllProne = false

-- Any players with a usergroup in this table will be allowed to go prone no matter what.
prone.AlwaysAllowedRanks = {
	"superadmin",
	"admin"
}

-- Enables a key to be clicked to go prone.
-- Disabling this will force disable it for everyone
-- DEFAULT: true
prone.BindKeyEnabled = true

-- Pressing this key will make the player go prone.
-- Check this list to see the available keys (http://wiki.garrysmod.com/page/Enums/IN)
-- NOTE: Some keys like RCONTROL don't work. Be careful of this when setting a key.
-- DEFAULT: KEY_LCONTROL (the crouch key)
prone.BindKey = KEY_LCONTROL

-- Should they have to double tap the prone key to go into or exit prone.
-- DEFAULT: true
prone.BindKeyDoubleTap = true

-- The chat command that could toggle prone for a player. This is prefixed by a "/" or a "!".
-- That means if prone.ChatCommand = "prone" then !prone and /prone works. "/" will be hidden from chat, "!" wont be.
-- Set to false to disable
-- DEFAULT: "prone"
prone.ChatCommand = "prone"

-- How fast can they move while prone.
-- DEFAULT: 50 (units per second)
prone.ProneSpeed = 50

-- Set if the player can move and shoot while prone.
-- There are no moving and shooting animations so it will be hard to tell who is shooting.
-- IT IS NOT RECOMMENDED TO TURN THIS ON!
prone.CanMoveAndShoot = false

-- Any of the weapons in this list can be fired while moving.
-- Only works if prone.CanMoveAndShoot is false, otherwise every weapon can be shot while moving.
prone.WhitelistedWeapons = {
	weapon_physgun			= true,
	weapon_physcannon		= true,		-- GravGun
	gmod_tool				= true,		-- Toolgun
	gmod_camera				= true,
	weapon_medkit			= true,
	weaponchecker			= true,		-- (DarkRP)
	keys					= true,		-- (DarkRP)
	pocket					= true,		-- (DarkRP)
	weapon_keypadchecker	= true,		-- (DarkRP)
	unarrest_stick			= true,		-- (DarkRP)
	arrest_stick			= true,		-- (DarkRP)
	weapon_zm_carry			= true,		-- (TTT) Magneto Stick
	weapon_ttt_binoculars	= true,		-- (TTT)
	weapon_ttt_unarmed		= true		-- (TTT)
}


///////////////////////////
////  DarkRP Specific  ////
///////////////////////////
-- If enabled only the jobs listed in prone.AllowedJobs can enter prone.
-- DEFAULT: false
prone.RestrictByJob = false

-- If prone.RestrictByJob is enabled only these jobs will be allowed to go prone.
-- prone.RestrictByJob must be true for this to work.
-- Please use the EXACT name as it appears in the F4 menu.
prone.AllowedJobs = {
	"Thief",
	"Civil Protection",
	"Civil Protection Chief",
	"Gangster",
	"Mob Boss",
	"Hobo"
}

-- NOTICE: You should only really look past here if you know what you're doing.

///////////////////////
////  Animations  /////
///////////////////////
-- Sets the prone animation for each holdtype.
prone.WeaponAnims = {
	moving = {
		ar2			= ACT_RUN_AIM_SHOTGUN,
		camera		= ACT_RUN_AIM_PISTOL,
		crossbow	= ACT_RUN_AIM_RIFLE,
		duel		= ACT_RUN_AIM_RIFLE,
		fist		= ACT_RUN_PROTECTED,
		knife		= ACT_RUN_PROTECTED,
		grenade		= ACT_RUN_AIM_PISTOL,
		magic		= ACT_RUN_PROTECTED,
		melee		= ACT_RUN_AIM_PISTOL,
		melee2		= ACT_RUN_AIM_PISTOL,
		normal		= ACT_RUN_PROTECTED,
		passive		= ACT_RUN_PROTECTED,
		pistol		= ACT_RUN_AIM_PISTOL,
		physgun		= ACT_RUN_AIM_AGITATED,
		revolver	= ACT_RUN_AIM_PISTOL,
		rpg			= ACT_RUN_AIM_STIMULATED,
		shotgun		= ACT_RUN_AIM_SHOTGUN,
		slam		= ACT_RUN_AIM_PISTOL,
		smg			= ACT_RUN_AIM_SHOTGUN
	},

	idle = {
		ar2			= ACT_TURN,
		camera		= ACT_TURNLEFT45,
		crossbow	= ACT_TURNRIGHT45,
		duel		= ACT_TURNRIGHT45,
		fist		= ACT_UNDEPLOY,
		knife		= ACT_UNDEPLOY,
		grenade		= ACT_VICTORY_DANCE,
		magic		= ACT_UNDEPLOY,
		melee		= ACT_SHIPLADDER_DOWN,
		melee2		= ACT_SHIPLADDER_UP,
		normal		= ACT_SHIELD_ATTACK,
		passive		= ACT_SHIELD_ATTACK,
		pistol		= ACT_RUN_STEALTH_PISTOL,
		physgun		= ACT_SHIELD_KNOCKBACK,
		revolver	= ACT_RUN_SCARED,
		rpg			= ACT_RUN_RPG,
		shotgun		= ACT_SHIELD_UP_IDLE,
		slam		= ACT_RUN_STEALTH,
		smg			= ACT_RUN_RIFLE
	}
}
