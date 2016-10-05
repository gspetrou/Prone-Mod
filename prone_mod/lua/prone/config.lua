/////////////////////
/////  General  /////
/////////////////////
-- Set to true so that anybody can go prone no matter what rank or job they are.
-- DEFAULT: true
prone.AllowAllProne = true

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
-- No I will not switch to KEY_ enums, stop asking.
-- DEFAULT: IN_DUCK (the crouch key)
prone.BindKey = IN_DUCK

-- Should they have to double tap the prone key to go into or exit prone.
-- DEFAULT: true
prone.BindKeyDoubleTap = true

-- Can the player simply press the jump key to get up if they are prone.
-- DEFAULT: true
prone.JumpToGetUp = true

-- Should they double tap jump to get up
-- DEFAULT: false
prone.JumpToGetUpDoubleTap = true

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

-- This sound will be played the the prone player gets up or gets down.
-- Set to false to disable. Example: prone.GetUpDownSound = "npc/metropolice/gear1.wav"
-- Make sure the clients download this file!
-- DEFAULT: false
prone.GetUpDownSound = false

-- This sound will be played each "step" while the player is prone.
-- Set to false to disable. Example: prone.MoveSound = "npc/metropolice/die1.wav"
-- Make sure the clients download this file!
-- DEFAULT: false
prone.MoveSound = false

-- How often the prone.MoveSound should be played. You should mess with this yourself.
-- DEFAULT: 0.5 (seconds)
prone.StepSoundTime = .5


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

-- Instead of prone.RestrictByJob being a whitelist
-- set this to true to make it a blacklist.
-- DEFAULT: false
prone.JobsIsBlacklist = false


-- NOTICE: You should only really look past here if you know what you're doing.

//////////////////////
/////  Advanced  /////
//////////////////////
-- Set the hull height of the player while they are prone.
-- DEFAULT: 24
prone.HullHeight = 24

-- How fast can the player move when they are going into or exitting prone.
-- DEFAULT: 0
prone.GetUpOrDownSpeed = 0

///////////////////////
////  Animations  /////
///////////////////////
-- Sets the prone animation for each holdtype.
if not prone.CW_NS_Mode then
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
else
	prone.WeaponAnims = {
		moving = {
			pistol = "ProneWalkIdle_PISTOL",
			smg = "ProneWalkIdle_PSCHRECK",
			grenade = "ProneWalkAim_GREN_FRAG",
			ar2 = "ProneWalkIdle_PSCHRECK",
			shotgun = "ProneWalkAim_GREN_FRAG",
			rpg = "ProneWalkIdle_BAZOOKA",
			physgun = "ProneWalkIdle_TOMMY",
			crossbow = "ProneWalkIdle_TOMMY",
			melee = "ProneWalkIdle_TOMMY",
			slam = "ProneWalkIdle_TNT",
			normal = "ProneWalkAim_GREN_FRAG",
			fist = "ProneWalkAim_GREN_FRAG",
			melee2 = "ProneWalkAim_GREN_FRAG",
			passive = "ProneWalkIdle_PSCHRECK",
			knife = "ProneWalkAim_KNIFE",
			duel = "ProneWalkIdle_PSCHRECK",
			camera = "ProneWalkIdle_TNT",
			magic = "ProneWalkAim_GREN_FRAG",
			revolver = "ProneWalkIdle_PISTOL"
		},

		idle = {
			pistol = "ProneAim_SPADE",
			smg = "ProneAim_MP40",
			grenade = "ProneAim_KNIFE",
			ar2 = "ProneAim_30CAL",
			shotgun = "ProneAim_MG",
			rpg = "ProneAim_BAZOOKA",
			physgun = "ProneAim_MP44",
			crossbow = "ProneAim_RIFLE",
			melee = "ProneAim_KNIFE",
			slam = "ProneAim_KNIFE",
			normal = "ProneAim_KNIFE",
			fist = "ProneAim_KNIFE",
			melee2 = "ProneAim_KNIFE",
			passive = "ProneAim_KNIFE",
			knife = "ProneAim_KNIFE",
			duel = "ProneAim_RIFLE",
			camera = "ProneAim_KNIFE",
			magic = "ProneAim_KNIFE",
			revolver = "ProneAim_SPADE"
		}	
	}
end

