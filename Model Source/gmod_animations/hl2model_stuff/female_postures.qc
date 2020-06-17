
$modelname "humans\female_postures.mdl"
$includemodel "player/wiltos/anim_extension_prone.mdl"

$surfaceprop "default"

$contents "solid"

$illumposition 0.05 -0.515 31.962

$cdmaterials "models\humans\female_animations\"

$attachment "forward" "ValveBiped.forward" 0 0 0 rotate 0 0 0
$attachment "anim_attachment_RH" "ValveBiped.Anim_Attachment_RH" 0 0 0 rotate -90 -90 0
$attachment "anim_attachment_LH" "ValveBiped.Anim_Attachment_LH" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -3.656 -9.484 1.371 4.686 9.585 62.553

$definebone "ValveBiped.Bip01_Pelvis" "" -0.000005 -0.78846 37.913784 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 0.000005 4.212784 -1.689857 -1.602964 89.999982 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 3.837408 0 0 0 -6.452307 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 3.617872 0 0 0 -0.723932 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine4" "ValveBiped.Bip01_Spine2" 7.539783 0 0 0 8.927427 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine4" 3.178296 0 0 0 12.841533 179.999855 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Head1" "ValveBiped.Bip01_Neck1" 2.970273 -0.000001 0 0 6.29566 0 0 0 0 0 0 0
$definebone "ValveBiped.forward" "ValveBiped.Bip01_Head1" 0.000001 0 0 0 -76 -90.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.023707 0.90746 0.852579 -76.440397 166.164378 93.870917 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 4.983666 -0.000002 0 13.809084 -43.179363 -87.04598 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.123052 0 0.000003 0.000001 -11.662213 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.208296 0 -0.000001 -2.211904 2.080007 86.253992 0 0 0 0 0 0
$definebone "ValveBiped.Anim_Attachment_LH" "ValveBiped.Bip01_L_Hand" 2.676089 -1.712444 0 -0.000019 90.000023 90.000023 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.023711 0.907462 -0.852528 76.440513 166.163749 -97.982465 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 4.983665 -0.000003 0 -10.977414 -43.834945 90.098528 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.123046 0 -0.000001 -0.000005 -11.660149 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.208295 0 0.000003 2.211437 2.080009 -85.770066 0 0 0 0 0 0
$definebone "ValveBiped.Anim_Attachment_RH" "ValveBiped.Bip01_R_Hand" 2.676088 -1.712442 0 0 -89.999968 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Thigh" "ValveBiped.Bip01_Pelvis" 3.984014 -0.000004 -0.000003 2.966031 -92.308197 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Calf" "ValveBiped.Bip01_L_Thigh" 15.94001 0 0 0 2.959556 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Foot" "ValveBiped.Bip01_L_Calf" 17.709562 0 0 -13.371105 -66.979021 -4.207673 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Toe0" "ValveBiped.Bip01_L_Foot" 6.203998 0 0 0.053509 -28.677396 -0.638619 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Thigh" "ValveBiped.Bip01_Pelvis" -3.984013 0.000007 0.000007 2.966031 -87.691938 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Calf" "ValveBiped.Bip01_R_Thigh" 15.940014 0 0 0 2.959557 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Foot" "ValveBiped.Bip01_R_Calf" 17.709558 0 0 12.672166 -67.209444 4.392066 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Toe0" "ValveBiped.Bip01_R_Foot" 6.204 0 0 -0.354374 -28.587326 -4.506371 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.549245 0.198823 -1.489468 21.265157 0.597196 -12.141549 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.219 0 0 5.585306 -21.005729 -0.264249 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.679999 0.000001 0 4.983473 -9.905297 0.651111 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.698009 0.267556 -0.728978 14.909618 -7.176065 -4.669951 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.749002 -0.000001 0 1.552368 -10.895539 0.012205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.959998 0 0 2.257565 -13.628782 0.133214 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.768502 0.152548 0.071384 1.624104 -0.196867 5.042315 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 2.038001 0.000004 0 -0.250156 -32.972581 0.086746 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.067 0 0 -0.324984 -5.671939 -0.071333 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.783925 -0.017258 0.794554 -12.383854 3.590788 16.23642 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.629001 0 0 -3.819797 -26.858718 1.078934 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.955999 0.000002 0 -3.994666 -9.741888 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 1.258963 -0.297984 1.25259 -30.375128 -37.494586 -73.854719 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.392998 -0.000001 -0.000001 0.115968 -2.497471 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.1 0 -0.000001 0.752238 -16.433288 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.549268 0.21141 1.487669 -21.265155 0.597184 12.141546 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.219002 -0.000002 0 -5.585306 -21.005728 0.264253 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.679999 0 0 -4.983469 -9.905296 -0.651104 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.698019 0.273716 0.726623 -14.90962 -7.176076 4.669951 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.749 0 0 -1.552371 -10.895543 -0.012202 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.959998 0 0 -2.257566 -13.628778 -0.133211 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.768503 0.151949 -0.07274 -1.624107 -0.196877 -5.042315 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 2.037998 -0.000002 0 0.250153 -32.972571 -0.086746 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.066998 0 0 0.324981 -5.671934 0.071333 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.783906 -0.023953 -0.794451 12.383853 3.590774 -16.236422 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.629 -0.000002 0 3.819795 -26.858722 -1.078943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.956001 -0.000001 0 3.994662 -9.741887 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 1.25894 -0.308546 -1.250052 30.375125 -37.494583 73.854719 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.393001 0 -0.000001 -0.115966 -2.497463 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.099999 -0.000002 -0.000001 -0.752234 -16.43328 0.000001 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_Pelvis"
$bonemerge "ValveBiped.Bip01_Spine"
$bonemerge "ValveBiped.Bip01_Spine1"
$bonemerge "ValveBiped.Bip01_Spine2"
$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Anim_Attachment_RH"


// The 32 below is a guess until further is known about the format.
$animblocksize 32

$bonesaveframe "ValveBiped.Bip01_Pelvis" position rotation
$bonesaveframe "ValveBiped.Bip01_Spine" rotation
$bonesaveframe "ValveBiped.Bip01_Spine1" rotation
$bonesaveframe "ValveBiped.Bip01_Spine2" rotation
$bonesaveframe "ValveBiped.Bip01_Spine4" rotation
$bonesaveframe "ValveBiped.Bip01_Neck1" rotation
$bonesaveframe "ValveBiped.Bip01_Head1" rotation
$bonesaveframe "ValveBiped.Bip01_L_Clavicle" rotation
$bonesaveframe "ValveBiped.Bip01_L_UpperArm" rotation
$bonesaveframe "ValveBiped.Bip01_L_Forearm" rotation
$bonesaveframe "ValveBiped.Bip01_L_Hand" rotation
$bonesaveframe "ValveBiped.Bip01_R_Clavicle" rotation
$bonesaveframe "ValveBiped.Bip01_R_UpperArm" rotation
$bonesaveframe "ValveBiped.Bip01_R_Forearm" rotation
$bonesaveframe "ValveBiped.Bip01_R_Hand" rotation
$bonesaveframe "ValveBiped.Bip01_L_Thigh" rotation
$bonesaveframe "ValveBiped.Bip01_L_Calf" rotation
$bonesaveframe "ValveBiped.Bip01_L_Foot" rotation
$bonesaveframe "ValveBiped.Bip01_R_Thigh" rotation
$bonesaveframe "ValveBiped.Bip01_R_Calf" rotation
$bonesaveframe "ValveBiped.Bip01_R_Foot" rotation

$ikchain "rhand" "ValveBiped.Bip01_R_Hand" knee 0.707 0.707 0
$ikchain "lhand" "ValveBiped.Bip01_L_Hand" knee 0.707 0.707 0
$ikchain "rfoot" "ValveBiped.Bip01_R_Foot" knee 0.707 -0.707 0
$ikchain "lfoot" "ValveBiped.Bip01_L_Foot" knee 0.707 -0.707 0

$ikautoplaylock "rfoot" 1 0.1
$ikautoplaylock "lfoot" 1 0.1

$weightlist "weights_P_Chainlink_Respondin" {
	 "ValveBiped.Bip01_Pelvis" 1
	 "ValveBiped.Bip01_Spine" 1
	 "ValveBiped.Bip01_Spine1" 1
	 "ValveBiped.Bip01_Spine2" 1
	 "ValveBiped.Bip01_Spine4" 1
	 "ValveBiped.Bip01_Neck1" 1
	 "ValveBiped.Bip01_Head1" 1
	 "ValveBiped.forward" 1
	 "ValveBiped.Bip01_L_Clavicle" 1
	 "ValveBiped.Bip01_L_UpperArm" 1
	 "ValveBiped.Bip01_L_Forearm" 1
	 "ValveBiped.Bip01_L_Hand" 0
	 "ValveBiped.Anim_Attachment_LH" 0
	 "ValveBiped.Bip01_R_Clavicle" 1
	 "ValveBiped.Bip01_R_UpperArm" 1
	 "ValveBiped.Bip01_R_Forearm" 1
	 "ValveBiped.Bip01_R_Hand" 0
	 "ValveBiped.Anim_Attachment_RH" 0
	 "ValveBiped.Bip01_L_Thigh" 1
	 "ValveBiped.Bip01_L_Calf" 1
	 "ValveBiped.Bip01_L_Foot" 1
	 "ValveBiped.Bip01_L_Toe0" 1
	 "ValveBiped.Bip01_R_Thigh" 1
	 "ValveBiped.Bip01_R_Calf" 1
	 "ValveBiped.Bip01_R_Foot" 1
	 "ValveBiped.Bip01_R_Toe0" 1
	 "ValveBiped.Bip01_L_Finger4" 0
	 "ValveBiped.Bip01_L_Finger41" 0
	 "ValveBiped.Bip01_L_Finger42" 0
	 "ValveBiped.Bip01_L_Finger3" 0
	 "ValveBiped.Bip01_L_Finger31" 0
	 "ValveBiped.Bip01_L_Finger32" 0
	 "ValveBiped.Bip01_L_Finger2" 0
	 "ValveBiped.Bip01_L_Finger21" 0
	 "ValveBiped.Bip01_L_Finger22" 0
	 "ValveBiped.Bip01_L_Finger1" 0
	 "ValveBiped.Bip01_L_Finger11" 0
	 "ValveBiped.Bip01_L_Finger12" 0
	 "ValveBiped.Bip01_L_Finger0" 0
	 "ValveBiped.Bip01_L_Finger01" 0
	 "ValveBiped.Bip01_L_Finger02" 0
	 "ValveBiped.Bip01_R_Finger4" 0
	 "ValveBiped.Bip01_R_Finger41" 0
	 "ValveBiped.Bip01_R_Finger42" 0
	 "ValveBiped.Bip01_R_Finger3" 0
	 "ValveBiped.Bip01_R_Finger31" 0
	 "ValveBiped.Bip01_R_Finger32" 0
	 "ValveBiped.Bip01_R_Finger2" 0
	 "ValveBiped.Bip01_R_Finger21" 0
	 "ValveBiped.Bip01_R_Finger22" 0
	 "ValveBiped.Bip01_R_Finger1" 0
	 "ValveBiped.Bip01_R_Finger11" 0
	 "ValveBiped.Bip01_R_Finger12" 0
	 "ValveBiped.Bip01_R_Finger0" 0
	 "ValveBiped.Bip01_R_Finger01" 0
	 "ValveBiped.Bip01_R_Finger02" 0
}

$weightlist "weights_P_Chainlink_Respond" {
	 "ValveBiped.Bip01_Pelvis" 0
	 "ValveBiped.Bip01_Spine" 0
	 "ValveBiped.Bip01_Spine1" 0
	 "ValveBiped.Bip01_Spine2" 0
	 "ValveBiped.Bip01_Spine4" 0
	 "ValveBiped.Bip01_Neck1" 0
	 "ValveBiped.Bip01_Head1" 0
	 "ValveBiped.forward" 0
	 "ValveBiped.Bip01_L_Clavicle" 0
	 "ValveBiped.Bip01_L_UpperArm" 0
	 "ValveBiped.Bip01_L_Forearm" 0
	 "ValveBiped.Bip01_L_Hand" 0
	 "ValveBiped.Anim_Attachment_LH" 0
	 "ValveBiped.Bip01_R_Clavicle" 0
	 "ValveBiped.Bip01_R_UpperArm" 0
	 "ValveBiped.Bip01_R_Forearm" 0
	 "ValveBiped.Bip01_R_Hand" 0
	 "ValveBiped.Anim_Attachment_RH" 0
	 "ValveBiped.Bip01_L_Thigh" 0
	 "ValveBiped.Bip01_L_Calf" 0
	 "ValveBiped.Bip01_L_Foot" 0
	 "ValveBiped.Bip01_L_Toe0" 0
	 "ValveBiped.Bip01_R_Thigh" 0
	 "ValveBiped.Bip01_R_Calf" 0
	 "ValveBiped.Bip01_R_Foot" 0
	 "ValveBiped.Bip01_R_Toe0" 0
	 "ValveBiped.Bip01_L_Finger4" 0
	 "ValveBiped.Bip01_L_Finger41" 0
	 "ValveBiped.Bip01_L_Finger42" 0
	 "ValveBiped.Bip01_L_Finger3" 0
	 "ValveBiped.Bip01_L_Finger31" 0
	 "ValveBiped.Bip01_L_Finger32" 0
	 "ValveBiped.Bip01_L_Finger2" 0
	 "ValveBiped.Bip01_L_Finger21" 0
	 "ValveBiped.Bip01_L_Finger22" 0
	 "ValveBiped.Bip01_L_Finger1" 0
	 "ValveBiped.Bip01_L_Finger11" 0
	 "ValveBiped.Bip01_L_Finger12" 0
	 "ValveBiped.Bip01_L_Finger0" 0
	 "ValveBiped.Bip01_L_Finger01" 0
	 "ValveBiped.Bip01_L_Finger02" 0
	 "ValveBiped.Bip01_R_Finger4" 0
	 "ValveBiped.Bip01_R_Finger41" 0
	 "ValveBiped.Bip01_R_Finger42" 0
	 "ValveBiped.Bip01_R_Finger3" 0
	 "ValveBiped.Bip01_R_Finger31" 0
	 "ValveBiped.Bip01_R_Finger32" 0
	 "ValveBiped.Bip01_R_Finger2" 0
	 "ValveBiped.Bip01_R_Finger21" 0
	 "ValveBiped.Bip01_R_Finger22" 0
	 "ValveBiped.Bip01_R_Finger1" 0
	 "ValveBiped.Bip01_R_Finger11" 0
	 "ValveBiped.Bip01_R_Finger12" 0
	 "ValveBiped.Bip01_R_Finger0" 0
	 "ValveBiped.Bip01_R_Finger01" 0
	 "ValveBiped.Bip01_R_Finger02" 0
}

$animation "@P_Chainlink_Respondin_corrective_animation" "female_postures_anims\@P_Chainlink_Respondin_corrective_animation.smd" {
}

$animation "@P_Chainlink_Respondout_corrective_animation" "female_postures_anims\@P_Chainlink_Respondout_corrective_animation.smd" {
}

$animation "@P_shiftrightin_corrective_animation" "female_postures_anims\@P_shiftrightin_corrective_animation.smd" {
}

$animation "@P_shiftrightout_corrective_animation" "female_postures_anims\@P_shiftrightout_corrective_animation.smd" {
}

$animation "@p_shiftleftin_corrective_animation" "female_postures_anims\@p_shiftleftin_corrective_animation.smd" {
}

$animation "@p_shiftleftout_corrective_animation" "female_postures_anims\@p_shiftleftout_corrective_animation.smd" {
}

$animation "@Scan_Skies_Respondin_corrective_animation" "female_postures_anims\@Scan_Skies_Respondin_corrective_animation.smd" {
}

$animation "@Scan_Skies_Respondout_corrective_animation" "female_postures_anims\@Scan_Skies_Respondout_corrective_animation.smd" {
}

$animation "@p_arlene_postidlein_corrective_animation" "female_postures_anims\@p_arlene_postidlein_corrective_animation.smd" {
}

$animation "@p_arlene_postidleout_corrective_animation" "female_postures_anims\@p_arlene_postidleout_corrective_animation.smd" {
}

$animation "@p_arrest_Uprightin_corrective_animation" "female_postures_anims\@p_arrest_Uprightin_corrective_animation.smd" {
}

$animation "@p_arrest_Uprightout_corrective_animation" "female_postures_anims\@p_arrest_Uprightout_corrective_animation.smd" {
}

$animation "@p_bouncingin_corrective_animation" "female_postures_anims\@p_bouncingin_corrective_animation.smd" {
}

$animation "@p_bouncingout_corrective_animation" "female_postures_anims\@p_bouncingout_corrective_animation.smd" {
}

$animation "@p_stepleftin_corrective_animation" "female_postures_anims\@p_stepleftin_corrective_animation.smd" {
}

$animation "@p_stepleftout_corrective_animation" "female_postures_anims\@p_stepleftout_corrective_animation.smd" {
}

$animation "@p_jumpupin_corrective_animation" "female_postures_anims\@p_jumpupin_corrective_animation.smd" {
}

$animation "@p_jumpupout_corrective_animation" "female_postures_anims\@p_jumpupout_corrective_animation.smd" {
}

$animation "@p_balance_toesin_corrective_animation" "female_postures_anims\@p_balance_toesin_corrective_animation.smd" {
}

$animation "@p_balance_toesout_corrective_animation" "female_postures_anims\@p_balance_toesout_corrective_animation.smd" {
}

$animation "@p_bendoverin_corrective_animation" "female_postures_anims\@p_bendoverin_corrective_animation.smd" {
}

$animation "@p_bendoverout_corrective_animation" "female_postures_anims\@p_bendoverout_corrective_animation.smd" {
}

$animation "@p_stepinin_corrective_animation" "female_postures_anims\@p_stepinin_corrective_animation.smd" {
}

$animation "@p_stepinout_corrective_animation" "female_postures_anims\@p_stepinout_corrective_animation.smd" {
}

$sequence "reference" {
	"female_postures_anims\reference.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "initialize" {
	"female_postures_anims\initialize.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "P_Chainlink_Respondloop" {
	"female_postures_anims\P_Chainlink_Respondloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "P_Chainlink_Respondin" {
	"female_postures_anims\P_Chainlink_Respondin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Chainlink_Respondin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "P_Chainlink_Respondout" {
	"female_postures_anims\P_Chainlink_Respondout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Chainlink_Respondout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "P_Chainlink_Respond" {
	"female_postures_anims\P_Chainlink_Respond.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"10"
			"loop"			"40"
			"end"			"50"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "P_Chainlink_Respondloop" 0 40 50 75 spline
	blendlayer "P_Chainlink_Respondin" 0 0 40 40
	blendlayer "P_Chainlink_Respondout" 50 50 75 75
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "P_shiftrightloop" {
	"female_postures_anims\P_shiftrightloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 20
	loop
}

$sequence "P_shiftrightin" {
	"female_postures_anims\P_shiftrightin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_shiftrightin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "P_shiftrightout" {
	"female_postures_anims\P_shiftrightout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_shiftrightout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "P_shiftright" {
	"female_postures_anims\P_shiftright.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"16"
			"loop"			"22"
			"end"			"38"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"22"
	}
}
	blendlayer "P_shiftrightloop" 0 22 38 55 spline
	blendlayer "P_shiftrightin" 0 0 22 22
	blendlayer "P_shiftrightout" 38 38 55 55
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_shiftleftloop" {
	"female_postures_anims\p_shiftleftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 20
	loop
}

$sequence "p_shiftleftin" {
	"female_postures_anims\p_shiftleftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_shiftleftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_shiftleftout" {
	"female_postures_anims\p_shiftleftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_shiftleftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_shiftleft" {
	"female_postures_anims\p_shiftleft.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"14"
			"loop"			"20"
			"end"			"35"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"20"
	}
}
	blendlayer "p_shiftleftloop" 0 20 35 55 spline
	blendlayer "p_shiftleftin" 0 0 20 20
	blendlayer "p_shiftleftout" 35 35 55 55
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "Scan_Skies_Respondloop" {
	"female_postures_anims\Scan_Skies_Respondloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "Scan_Skies_Respondin" {
	"female_postures_anims\Scan_Skies_Respondin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@Scan_Skies_Respondin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "Scan_Skies_Respondout" {
	"female_postures_anims\Scan_Skies_Respondout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@Scan_Skies_Respondout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "Scan_Skies_Respond" {
	"female_postures_anims\Scan_Skies_Respond.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"10"
			"loop"			"30"
			"end"			"40"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"30"
	}
}
	blendlayer "Scan_Skies_Respondloop" 0 30 40 70 spline
	blendlayer "Scan_Skies_Respondin" 0 0 30 30
	blendlayer "Scan_Skies_Respondout" 40 40 70 70
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_arlene_postidleloop" {
	"female_postures_anims\p_arlene_postidleloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_arlene_postidlein" {
	"female_postures_anims\p_arlene_postidlein.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_arlene_postidlein_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_arlene_postidleout" {
	"female_postures_anims\p_arlene_postidleout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_arlene_postidleout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_arlene_postidle" {
	"female_postures_anims\p_arlene_postidle.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"20"
			"loop"			"40"
			"end"			"50"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "p_arlene_postidleloop" 0 40 50 70 spline
	blendlayer "p_arlene_postidlein" 0 0 40 40
	blendlayer "p_arlene_postidleout" 50 50 70 70
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_arrest_Uprightloop" {
	"female_postures_anims\p_arrest_Uprightloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_arrest_Uprightin" {
	"female_postures_anims\p_arrest_Uprightin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_arrest_Uprightin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_arrest_Uprightout" {
	"female_postures_anims\p_arrest_Uprightout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_arrest_Uprightout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_arrest_Upright" {
	"female_postures_anims\p_arrest_Upright.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"20"
			"loop"			"40"
			"end"			"50"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "p_arrest_Uprightloop" 0 40 50 100 spline
	blendlayer "p_arrest_Uprightin" 0 0 40 40
	blendlayer "p_arrest_Uprightout" 50 50 100 100
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_bouncingloop" {
	"female_postures_anims\p_bouncingloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_bouncingin" {
	"female_postures_anims\p_bouncingin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bouncingin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_bouncingout" {
	"female_postures_anims\p_bouncingout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bouncingout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_bouncing" {
	"female_postures_anims\p_bouncing.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"12"
			"loop"			"28"
			"end"			"39"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"28"
	}
}
	blendlayer "p_bouncingloop" 0 28 39 53 spline
	blendlayer "p_bouncingin" 0 0 28 28
	blendlayer "p_bouncingout" 39 39 53 53
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_stepleftloop" {
	"female_postures_anims\p_stepleftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_stepleftin" {
	"female_postures_anims\p_stepleftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepleftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_stepleftout" {
	"female_postures_anims\p_stepleftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepleftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_stepleft" {
	"female_postures_anims\p_stepleft.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"30"
			"loop"			"44"
			"end"			"68"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"44"
	}
}
	blendlayer "p_stepleftloop" 0 44 68 88 spline
	blendlayer "p_stepleftin" 0 0 44 44
	blendlayer "p_stepleftout" 68 68 88 88
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_jumpuploop" {
	"female_postures_anims\p_jumpuploop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_jumpupin" {
	"female_postures_anims\p_jumpupin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_jumpupin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_jumpupout" {
	"female_postures_anims\p_jumpupout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_jumpupout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_jumpup" {
	"female_postures_anims\p_jumpup.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"4"
			"loop"			"7"
			"end"			"32"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"7"
	}
}
	blendlayer "p_jumpuploop" 0 7 32 39 spline
	blendlayer "p_jumpupin" 0 0 7 7
	blendlayer "p_jumpupout" 32 32 39 39
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_balance_toesloop" {
	"female_postures_anims\p_balance_toesloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_balance_toesin" {
	"female_postures_anims\p_balance_toesin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_balance_toesin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_balance_toesout" {
	"female_postures_anims\p_balance_toesout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_balance_toesout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_balance_toes" {
	"female_postures_anims\p_balance_toes.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"18"
			"loop"			"30"
			"end"			"68"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"30"
	}
}
	blendlayer "p_balance_toesloop" 0 30 68 90 spline
	blendlayer "p_balance_toesin" 0 0 30 30
	blendlayer "p_balance_toesout" 68 68 90 90
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_bendoverloop" {
	"female_postures_anims\p_bendoverloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_bendoverin" {
	"female_postures_anims\p_bendoverin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bendoverin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_bendoverout" {
	"female_postures_anims\p_bendoverout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bendoverout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_bendover" {
	"female_postures_anims\p_bendover.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"15"
			"loop"			"20"
			"end"			"20"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"20"
	}
}
	blendlayer "p_bendoverloop" 0 20 20 65 spline
	blendlayer "p_bendoverin" 0 0 20 20
	blendlayer "p_bendoverout" 20 20 65 65
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}

$sequence "p_stepinloop" {
	"female_postures_anims\p_stepinloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_stepinin" {
	"female_postures_anims\p_stepinin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepinin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_stepinout" {
	"female_postures_anims\p_stepinout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepinout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_P_Chainlink_Respondin"
}

$sequence "p_stepin" {
	"female_postures_anims\p_stepin.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"19"
			"loop"			"30"
			"end"			"50"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"30"
	}
}
	blendlayer "p_stepinloop" 0 30 50 70 spline
	blendlayer "p_stepinin" 0 0 30 30
	blendlayer "p_stepinout" 50 50 70 70
	fps 30
	weightlist "weights_P_Chainlink_Respond"
}
