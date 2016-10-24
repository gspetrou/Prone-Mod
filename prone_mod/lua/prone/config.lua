////	General Settings
//
-- Can they move and shoot? You probably don't want this feature on.
prone.config.CanMoveAndShoot = false


////	Move Speeds
//
-- How fast they move while prone.
prone.config.MoveSpeed = 50
-- How fast they move while getting up or going down.
prone.config.TransitionSpeed = 0


////	Shooting Settings
//
-- There are no moving and shooting animations while prone so it
-- would look like players aren't shooting when they are.
-- You probably want this to stay set to true.
prone.config.MoveShoot_Restrict = true

-- Weapons in this list can be shot while moving if the ab
prone.config.MoveShoot_Whitelist = {
	weapon_physgun			= true,
	weapon_physcannon		= true,		-- Gravity Gun
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


/////	DarkRP Settings
//
-- Should we restrict prone by job.
prone.config.Darkrp_RestrictJobs = true
-- Is the job list a whitelist? False for blacklist.
prone.config.Darkrp_IsWhitelist = true
-- If the above setting is true this is the job whitelist. Blacklist otherwise.
prone.config.Darkrp_Joblist = {
	TEAM_POLICE,
	TEAM_GANG
}
-- Any players of these ranks can go prone, no matter of their job.
prone.config.Darkrp_BypassRanks = {
	"superadmin",
	"admin"
}


////	Advanced Settings - Don't fuck with these unless you know what youre doing
//
-- Sets the hull height while prone. What you can fit under.
prone.config.HullHeight = 24

prone.animations.gettingdown = "pronedown_stand"
prone.animations.gettingdown_crouch = "pronedown_crouch"
prone.animations.gettingup = "proneup_stand"
prone.animations.gettingup_crouch = "proneup_crouch"
prone.animations.passive = "prone_walkpassive"

prone.animations.WeaponAnims = {
	moving = {
		ar2			= "prone_walktwohand",
		camera		= "prone_walkonehand",
		crossbow	= "prone_walkcrossbow",
		duel		= "prone_walkcrossbow",
		fist		= "prone_walkpassive",
		grenade		= "prone_walkonehand",
		knife		= "prone_walkpassive",
		magic		= "prone_walkpassive",
		melee		= "prone_walkonehand",
		melee2		= "prone_walkonehand",
		normal		= "prone_walkpassive",
		passive		= "prone_walkpassive",
		pistol		= "prone_walkonehand",
		physgun		= "prone_walkphysgun",
		revolver	= "prone_walkonehand",
		rpg			= "prone_walkrpg",
		shotgun		= "prone_walktwohand",
		slam		= "prone_walkonehand",
		smg			= "prone_walktwohand"
	},

	idle = {
		ar2			= "prone_ar2",
		camera		= "prone_camera",
		crossbow	= "prone_crossbow",
		duel		= "prone_crossbow",
		fist		= "prone_knife",
		grenade		= "prone_grenade",
		knife		= "prone_knife",
		magic		= "prone_knife",
		melee		= "prone_melee",
		melee2		= "prone_melee2",
		normal		= "prone_passive",
		passive		= "prone_passive",
		pistol		= "prone_pistol",
		physgun		= "prone_physgun",
		revolver	= "prone_revolver",
		rpg			= "prone_rpg",
		shotgun		= "prone_shotgun",
		slam		= "prone_slam",
		smg			= "prone_smg1"
	}
}
