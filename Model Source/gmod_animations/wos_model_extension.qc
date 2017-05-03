$modelname player/wiltos/anim_extension_prone.mdl
 
$definevariable g "base_m" // this defines the gender for some animations
 
$pushd  "player"
 
$include "Humans_sdk\male\commonbones.qci"
$include "Humans_sdk\standardhierarchy.qci"
$include "Humans_sdk\standardikchains.qci"
$include "Humans_sdk\male\hitbox.qci"
 
$lockbonelengths
 
// $lockdefinebones
 
$attachment "eyes" "ValveBiped.Bip01_Head1" 0 -4 67.5 absolute
 
$sequence reference "..\humans_sdk\male\ragdoll_pose"
 
$include gm_weightlists.qci
 
// ------------------------------------
//  MAKE AIMLAYER PRONE BLEND, WITH LEFT HAND IK
// ------------------------------------
 
$definemacro MakeAimLayerProne layername filename \\
$animation a_$layername$_neutral $filename$ frame 5 5 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_left $filename$ frame 1 1 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_center $filename$ frame 2 2 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_right $filename$ frame 3 3 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_left $filename$ frame 4 4 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_center $filename$ frame 5 5 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_right $filename$ frame 6 6 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_left $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_center $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_right $filename$ frame 9 9 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
// $animation a_$layername$_straight_up $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$sequence $layername$ { \\
    // a_$layername$_straight_up a_$layername$_straight_up a_$layername$_straight_up \\
    a_$layername$_up_right a_$layername$_up_center a_$layername$_up_left \\
    a_$layername$_mid_right a_$layername$_mid_center a_$layername$_mid_left \\
    a_$layername$_down_right a_$layername$_down_center a_$layername$_down_left \\
    blendref a_$layername$_neutral \\
    blendcenter a_$layername$_mid_center \\
    blendwidth 3 blend aim_yaw 45 -45 blend aim_pitch -25 25 \\
    delta \\
    iklock rfoot 1 0 iklock lfoot 1 0 \\
    hidden \\
    } \\
 
// ------------------------------------
//  MAKE AIMLAYER PRONE NOCALCBLEND, NO LEFT HAND IK
// ------------------------------------
 
$definemacro MakeAimLayerProneNoLeftHandIK layername filename \\
$animation a_$layername$_neutral $filename$ frame 5 5 weightlist AimLayerWL \\
$animation a_$layername$_down_left $filename$ frame 1 1 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_down_center $filename$ frame 2 2 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_down_right $filename$ frame 3 3 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_left $filename$ frame 4 4 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_center $filename$ frame 5 5 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_right $filename$ frame 6 6 subtract a_$layername$_neutral 0 weightlist AimLayerWL  \\
$animation a_$layername$_up_left $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_up_center $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_up_right $filename$ frame 9 9 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
// $animation a_$layername$_straight_up $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$sequence $layername$ { \\
    // a_$layername$_straight_up a_$layername$_straight_up a_$layername$_straight_up \\
    a_$layername$_up_right a_$layername$_up_center a_$layername$_up_left \\
    a_$layername$_mid_right a_$layername$_mid_center a_$layername$_mid_left \\
    a_$layername$_down_right a_$layername$_down_center a_$layername$_down_left \\
    blendref a_$layername$_neutral \\
    blendcenter a_$layername$_mid_center \\
//  blendwidth 3 blend aim_yaw 45 -45 ZR blend aim_pitch 0 -25 YR \\
    blendwidth 3 blend aim_yaw 45 -45 blend aim_pitch 25 -25 \\
    delta \\
    iklock rfoot 1 0 iklock lfoot 1 0 \\
    hidden \\
    } \\
 
// ------------------------------------
//  MAKE AIMLAYER, WITH LEFT HAND IK
// ------------------------------------
 
$definemacro MakeAimLayer layername filename \\
$animation a_$layername$_neutral $filename$ frame 4 4 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_left $filename$ frame 0 0 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_center $filename$ frame 1 1 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_down_right $filename$ frame 2 2 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_left $filename$ frame 3 3 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_center $filename$ frame 4 4 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_mid_right $filename$ frame 5 5 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_left $filename$ frame 6 6 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_center $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$animation a_$layername$_up_right $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
// $animation a_$layername$_straight_up $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule lhand touch "ValveBiped.Bip01_R_Hand" usesource \\
$sequence $layername$ { \\
    // a_$layername$_straight_up a_$layername$_straight_up a_$layername$_straight_up \\
    a_$layername$_up_right a_$layername$_up_center a_$layername$_up_left \\
    a_$layername$_mid_right a_$layername$_mid_center a_$layername$_mid_left \\
    a_$layername$_down_right a_$layername$_down_center a_$layername$_down_left \\
    blendref a_$layername$_neutral \\
    blendcenter a_$layername$_mid_center \\
    blendwidth 3 calcblend aim_yaw "anim_attachment_RH" ZR calcblend aim_pitch "anim_attachment_RH" YR \\
    delta \\
    iklock rfoot 1 0 iklock lfoot 1 0 \\
    hidden \\
    } \\
   
// ------------------------------------
//  MAKE AIMLAYER, CAMERA
// ------------------------------------
 
// same as regular one, just with an added rule so the hands get locked to the head..
   
$definemacro MakeAimLayerCamera layername filename \\
$animation a_$layername$_neutral $filename$ frame 4 4 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_down_left $filename$ frame 0 0 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_down_center $filename$ frame 1 1 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_down_right $filename$ frame 2 2 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_mid_left $filename$ frame 3 3 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_mid_center $filename$ frame 4 4 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_mid_right $filename$ frame 5 5 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_up_left $filename$ frame 6 6 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_up_center $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$animation a_$layername$_up_right $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL ikrule rhand touch "ValveBiped.Bip01_Head1" usesource ikrule lhand touch "ValveBiped.Bip01_Head1" usesource \\
$sequence $layername$ { \\
    // a_$layername$_straight_up a_$layername$_straight_up a_$layername$_straight_up \\
    a_$layername$_up_right a_$layername$_up_center a_$layername$_up_left \\
    a_$layername$_mid_right a_$layername$_mid_center a_$layername$_mid_left \\
    a_$layername$_down_right a_$layername$_down_center a_$layername$_down_left \\
    blendref a_$layername$_neutral \\
    blendcenter a_$layername$_mid_center \\
    blendwidth 3 calcblend aim_yaw "anim_attachment_RH" ZR calcblend aim_pitch "anim_attachment_RH" YR \\
    delta \\
    iklock rfoot 1 0 iklock lfoot 1 0 \\
    hidden \\
    } \\
 
// ------------------------------------
//  MAKE AIMLAYER, NO LEFT HAND IK
// ------------------------------------
 
$definemacro MakeAimLayerNoLeftHandIK layername filename \\
$animation a_$layername$_neutral $filename$ frame 4 4 weightlist AimLayerWL \\
$animation a_$layername$_down_left $filename$ frame 0 0 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_down_center $filename$ frame 1 1 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_down_right $filename$ frame 2 2 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_left $filename$ frame 3 3 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_center $filename$ frame 4 4 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_mid_right $filename$ frame 5 5 subtract a_$layername$_neutral 0 weightlist AimLayerWL  \\
$animation a_$layername$_up_left $filename$ frame 6 6 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_up_center $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$animation a_$layername$_up_right $filename$ frame 8 8 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
// $animation a_$layername$_straight_up $filename$ frame 7 7 subtract a_$layername$_neutral 0 weightlist AimLayerWL \\
$sequence $layername$ { \\
    // a_$layername$_straight_up a_$layername$_straight_up a_$layername$_straight_up \\
    a_$layername$_up_right a_$layername$_up_center a_$layername$_up_left \\
    a_$layername$_mid_right a_$layername$_mid_center a_$layername$_mid_left \\
    a_$layername$_down_right a_$layername$_down_center a_$layername$_down_left \\
    blendref a_$layername$_neutral \\
    blendcenter a_$layername$_mid_center \\
    blendwidth 3 calcblend aim_yaw "anim_attachment_RH" ZR calcblend aim_pitch "anim_attachment_RH" YR \\
    delta \\
    iklock rfoot 1 0 iklock lfoot 1 0 \\
    hidden \\
    } \\
   
 
$popd $pushd "player"
   
$animation a_gmod_breath "../gmod/breath" subtract reference 0 fixuploop 0 60
$animation a_gmod_breath_sit "../gmod/breath" subtract reference 0 fixuploop 0 60
 
$sequence gmod_breath_layer a_gmod_breath delta loop realtime fps 25 iklock rfoot 1 0 iklock lfoot 1 0 weightlist 75percent
$sequence gmod_breath_layer_lock_right a_gmod_breath delta loop realtime fps 25 iklock rfoot 1 0 iklock lfoot 1 0 iklock rhand 1 0
$sequence gmod_breath_layer_lock_hands a_gmod_breath delta loop realtime fps 25 iklock rfoot 1 0 iklock lfoot 1 0 iklock rhand 1 0 iklock lhand 1 0
$sequence gmod_breath_layer_sitting a_gmod_breath_sit delta loop realtime fps 25 iklock rfoot 1 0 iklock lfoot 1 0 iklock rhand 0.8 0.3 iklock lhand 0.8 0.3 weightlist SlowerUpperBodyBlend
 
   
// ------------------------------------
//  MAKE PRONE IDLE
// ------------------------------------
 
$definemacro makepidle idlename filename frame aimlayer \\
$sequence $idlename$ $filename$ alignto reference frame $frame$ $frame$ numframes 30 loop fadein 0.30 fadeout 0.30 addlayer $aimlayer$ addlayer gmod_breath_layer node "standing" \\
 
$popd $pushd "aimlayers"
 
$MakeAimLayerProne              aimlayer_ar2_prone              "aimlayer_prone_smg.smd"
$MakeAimLayerProne              aimlayer_camera_prone           "aimlayer_prone_camera.smd"
$MakeAimLayerProne              aimlayer_crossbow_prone         "aimlayer_prone_crossbow.smd"
$MakeAimLayerProneNoLeftHandIK  aimlayer_knife_prone            "aimlayer_prone_knife.smd"
$MakeAimLayerProneNoLeftHandIK  aimlayer_melee_prone            "aimlayer_prone_melee.smd" 
$MakeAimLayerProne              aimlayer_physgun_prone          "aimlayer_prone_gravitygun.smd"
$MakeAimLayerProne              aimlayer_pistol_prone           "aimlayer_prone_pistol.smd"
$MakeAimLayerProne              aimlayer_rpg_prone              "aimlayer_prone_rpg.smd"
$MakeAimLayerProne              aimlayer_revolver_prone         "aimlayer_prone_pistol.smd"
$MakeAimLayerNoLeftHandIK       aimlayer_slam_prone             "aimlayer_prone_slam.smd"
$MakeAimLayerProne              aimlayer_shotgun_prone          "aimlayer_prone_shotgun.smd"
$MakeAimLayerProne              aimlayer_smg_prone              "aimlayer_prone_smg.smd"
$MakeAimLayerProne              aimlayer_passive_prone          "aimlayer_prone_passive.smd"
 
$popd $pushd "player"      
 
$MakepIdle prone_ar2 "../9way_central/smg1_prone" 0 aimlayer_smg_prone
$MakepIdle prone_camera "../9way_central/camera_prone" 0 aimlayer_camera_prone
$MakepIdle prone_crossbow "../9way_central/crossbow_prone" 0 aimlayer_crossbow_prone
$MakepIdle prone_knife "../9way_central/knife_prone" 0 aimlayer_knife_prone
$MakepIdle prone_grenade "../9way_central/melee_prone" 0 aimlayer_melee_prone
$MakepIdle prone_melee "../9way_central/melee_prone" 0 aimlayer_melee_prone
$MakepIdle prone_melee2 "../9way_central/melee_prone" 0 aimlayer_melee_prone
$MakepIdle prone_passive "../9way_central/passive_prone" 0 aimlayer_passive_prone
$MakepIdle prone_pistol "../9way_central/pistol_prone" 0 aimlayer_pistol_prone
$MakepIdle prone_physgun "../9way_central/gravitygun_prone" 0 aimlayer_physgun_prone
$MakepIdle prone_revolver "../9way_central/pistol_prone" 0 aimlayer_revolver_prone
$MakepIdle prone_rpg "../9way_central/rpg_prone" 0 aimlayer_rpg_prone
$MakepIdle prone_shotgun "../9way_central/shotgun_prone" 0 aimlayer_shotgun_prone
$MakepIdle prone_slam "../9way_central/slam_prone" 0 aimlayer_slam_prone
$MakepIdle prone_smg1 "../9way_central/smg1_prone" 0 aimlayer_smg_prone
 
// ------------------------------------
//  SEQUENCES
// ------------------------------------
$popd $pushd    "player"
 
// ------------------------------------
//  PRONE STUFF
// ------------------------------------
 
$animation pronewalk_a "../prone/ProneWalkIdle_30CAL" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$animation ProneWalkAim_BAZOOKA_a "../prone/ProneWalkAim_BAZOOKA" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$animation ProneWalkAim_BOLT_a "../prone/ProneWalkAim_BOLT" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$animation ProneWalkAim_GREN_FRAG_a "../prone/ProneWalkAim_GREN_FRAG" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$animation ProneWalkAim_KNIFE_a "../prone/ProneWalkAim_KNIFE" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$animation ProneWalkAim_PSCHRECK_a "../prone/ProneWalkAim_PSCHRECK" {
    walkframe 28 LX LY
    fps 30
    loop
}
 
$sequence prone_walkpassive "pronewalk_a" {
    //ACT_RUN_PROTECTED -1
    loop
}
 
$sequence prone_walkonehand "ProneWalkAim_BAZOOKA_a" {
    //ACT_RUN_AIM_PISTOL -1
    loop
}
 
$sequence prone_walkphysgun "ProneWalkAim_BOLT_a" {
    //ACT_RUN_AIM_AGITATED -1
    loop
}
 
$sequence prone_walkcrossbow "ProneWalkAim_GREN_FRAG_a" {
    //ACT_RUN_AIM_RIFLE -1
    loop
}
 
$sequence prone_walkrpg "ProneWalkAim_KNIFE_a" {
    //ACT_RUN_AIM_STIMULATED -1
    loop
}
 
$sequence prone_walktwohand "ProneWalkAim_PSCHRECK_a" {
    //ACT_RUN_AIM_SHOTGUN -1
    loop
}
 
$sequence pronedown_crouch "../prone/ProneDown_Crouch.smd" {
    //ACT_GET_DOWN_CROUCH -1
}
 
$sequence pronedown_stand "../prone/ProneDown_Stand.smd" {
    //ACT_GET_DOWN_STAND -1
}
 
$sequence proneup_crouch "../prone/ProneUp_Crouch.smd" {
    //ACT_GET_UP_CROUCH -1
}
$sequence proneup_stand "../prone/ProneUp_Stand.smd" {
    //ACT_GET_UP_STAND -1
}
 
$definemacro MakeSplineGestureLockFeet splinename filename pelvisweights baseweights peak tail end \\
$sequence $splinename$_original                 $filename$ hidden \\
$animation a_$splinename$_pelvis_layer          $filename$ subtract $splinename$_original 0 \\
$sequence $splinename$_pelvis_layer             a_$splinename$_pelvis_layer delta weightlist $pelvisweights$ fadeout 0.1 hidden \\
$sequence $splinename$_base_layer               $filename$ weightlist $baseweights$ fadeout 0.1 hidden \\
$sequence $splinename$ "..\humans_sdk\male\ragdoll_pose" noanimation blendlayer $splinename$_pelvis_layer 0 $peak$ $tail$ $end$ spline blendlayer $splinename$_base_layer 0 $peak$ $tail$ $end$ spline numframes $end$ iklock rfoot 1 0 iklock lfoot 1 0 fadeout 0.1 ikrule lhand release range 0 $peak$ $tail$ $end$ ikrule rhand release range 0 $peak$ $tail$ $end$ \\
$continue $splinename$
 
$MakeSplineGestureLockFeet reload_ar2_prone "..\combine_soldier_xsi\Reload_standing_prone" PelvisOnly FasterUpperBodyBlend 15 52 65 fps 32 ACT_HL2MP_GESTURE_RELOAD_AR2_PRONE 1 ikrule lhand release range 0 10 55 65
$MakeSplineGestureLockFeet reload_pistol_prone "..\police_xsi\Pistol_reload_prone" PelvisOnlyHalved FasterUpperBodyBlend 14 35 45 fps 32 ACT_HL2MP_GESTURE_RELOAD_PISTOL_PRONE 1 ikrule lhand release range 0 14 30 45
$MakeSplineGestureLockFeet reload_revolver_prone "..\police_xsi\Pistol_reload_prone" PelvisOnlyHalved FasterUpperBodyBlend 14 35 45 fps 32 ACT_HL2MP_GESTURE_RELOAD_REVOLVER_PRONE 1 ikrule lhand release range 0 14 30 45
$MakeSplineGestureLockFeet reload_smg1_prone "..\combine_soldier_xsi\Reload_standing_prone" PelvisOnly FasterUpperBodyBlend 15 52 65 fps 34 ACT_HL2MP_GESTURE_RELOAD_SMG1_PRONE 1 ikrule lhand release range 0 10 55 65
 
$MakeSplineGestureLockFeet reload_dual_prone "../gmod/reload_dual_prone" PelvisOnly FasterUpperBodyBlend 10 80 100 fps 30 {
    activity ACT_HL2MP_GESTURE_RELOAD_DUEL_PRONE 1
    event AE_CL_PLAYSOUND 19 "Weapon_Pistol.Special1"
    event AE_CL_PLAYSOUND 21 "Weapon.ImpactSoft"
    event AE_CL_PLAYSOUND 24 "Weapon_Pistol.Special2"
    event AE_CL_PLAYSOUND 56 "Weapon_357.ReplaceLoader"
    event AE_CL_PLAYSOUND 59 "Weapon.StepLeft"
    event AE_CL_PLAYSOUND 76 "Weapon_357.ReplaceLoader"
    event AE_CL_PLAYSOUND 79 "Weapon.StepRight"
    }
 
$MakeSplineGestureLockFeet reload_shotgun_prone "../gmod/reload_shotgun_prone" PelvisOnly FasterUpperBodyBlend 15 68 80 fps 30 {
    ikrule lhand release range 0 10 70 80
    activity ACT_HL2MP_GESTURE_RELOAD_SHOTGUN_PRONE 1
    event AE_CL_PLAYSOUND 23 "Weapon_Shotgun.NPC_Reload"
    event AE_CL_PLAYSOUND 29 "Weapon_Shotgun.NPC_Reload"
    event AE_CL_PLAYSOUND 54 "Weapon_Shotgun.Special1"
    }