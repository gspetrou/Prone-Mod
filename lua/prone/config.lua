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

-- Pressing this key will make the player go prone. Set to false to only make the "prone" command work.
-- Check this list to see the available keys (http://wiki.garrysmod.com/page/Enums/IN)
-- DEFAULT: IN_DUCK (the crouch key)
prone.BindKey = IN_DUCK

-- Should they have to double tap the prone key to go into or exit prone.
-- DEFAULT: true
prone.BindKeyDoubleTap = true

-- How fast can they move while prone.
-- DEFAULT: 75 (units per second)
prone.ProneSpeed = 50

-- Set if the player can move and shoot while prone.
-- There are no moving and shooting animations so it will be hard to tell who is shooting.
-- IT IS NOT RECOMMENDED TO TURN THIS ON!
prone.CanMoveAndShoot = false

-- Any of the weapons in this list can be fired while moving.
-- Only works if prone.CanMoveAndShoot is false, otherwise every weapon can be shot while moving.
prone.WhitelistedWeapons = {
	"weapon_physgun",
	"weapon_physcannon",		-- GravGun
	"gmod_tool",				-- Toolgun
	"gmod_camera",
	"weapon_medkit",
	"weaponchecker",			-- (DarkRP)
	"keys",						-- (DarkRP)
	"pocket",					-- (DarkRP)
	"weapon_keypadchecker",		-- (DarkRP)
	"unarrest_stick",			-- (DarkRP)
	"arrest_stick",				-- (DarkRP)
	"weapon_zm_carry",			-- (TTT) Magneto Stick
	"weapon_ttt_binoculars",	-- (TTT)
	"weapon_ttt_unarmed"		-- (TTT)
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

//////////////////////
////  Sequences  /////
//////////////////////
-- Sets the prone animation for each holdtype.
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
