prone.config.BindKey = KEY_K

prone.config.HullHeight = 24

prone.config.TransitionSpeed = 0

prone.config.MoveSpeed = 50

prone.config.CanMoveAndShoot = false

prone.config.BindKey = KEY_LCONTROL
prone.config.BindKey_DoubleClick = true

prone.config.WeaponAnims = {
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

/*
prone.config.WeaponAnims = {
	moving = {
		ar2			= "ProneWalkAim_PSCHRECK_a",
		camera		= "ProneWalkAim_BAZOOKA_a",
		crossbow	= "ProneWalkAim_GREN_FRAG_a",
		duel		= "ProneWalkAim_GREN_FRAG_a",
		fist		= "pronewalk_a",
		knife		= "pronewalk_a",
		grenade		= "ProneWalkAim_BAZOOKA_a",
		magic		= "pronewalk_a",
		melee		= "ProneWalkAim_BAZOOKA_a",
		melee2		= "ProneWalkAim_BAZOOKA_a",
		normal		= "pronewalk_a",
		passive		= "pronewalk_a",
		pistol		= "ProneWalkAim_BAZOOKA_a",
		physgun		= "ProneWalkAim_BOLT_a",
		revolver	= "ProneWalkAim_BAZOOKA_a",
		rpg			= "ProneWalkAim_KNIFE_a",
		shotgun		= "ProneWalkAim_PSCHRECK_a",
		slam		= "ProneWalkAim_BAZOOKA_a",
		smg			= "ProneWalkAim_PSCHRECK_a"
	},

	idle = {
		ar2			= "prone_ar2",
		camera		= "prone_camera",
		crossbow	= "prone_crossbow",
		duel		= "prone_crossbow",
		fist		= "prone_knife",
		knife		= "prone_knife",
		grenade		= "prone_grenade",
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
}*/