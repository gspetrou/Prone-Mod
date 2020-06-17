
$modelname "humans\male_postures.mdl"
$includemodel "player/wiltos/anim_extension_prone.mdl"

$surfaceprop "default"

$contents "solid"

$illumposition 0.003 -0.716 33.208

$cdmaterials "models\humans\male_animations\"

$attachment "forward" "ValveBiped.forward" 0 0 0 rotate 0 0 0
$attachment "anim_attachment_RH" "ValveBiped.Anim_Attachment_RH" 0 0 0 rotate -90 -90 0
$attachment "anim_attachment_LH" "ValveBiped.Anim_Attachment_LH" 0 0 0 rotate -90 -90 0
$attachment "anim_attachment_head" "ValveBiped.Bip01_Head1" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -3.602 -11.671 0.419 5.034 11.678 65.998

$definebone "ValveBiped.Bip01_Pelvis" "" -0.000005 -0.533615 38.566917 0 0 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 0.000005 3.345128 -2.981901 4.944224 89.999982 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 4.018331 0 0 0 -1.675443 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 3.518565 0 0 0 5.74883 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine4" "ValveBiped.Bip01_Spine2" 8.942642 0 0 0 11.120881 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine4" 3.307271 0 0 0 22.945694 179.999855 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Head1" "ValveBiped.Bip01_Neck1" 3.593712 -0.000001 0 -0.000057 23.295723 0 0 0 0 0 0 0
$definebone "ValveBiped.forward" "ValveBiped.Bip01_Head1" 1.999997 -3.000001 0 0 -76 -90.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.03335 1.000771 -1.93761 73.71203 168.618779 -95.596496 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000002 0 -0.46209 -33.623802 93.935236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 0 0.000002 -0.000007 -3.459061 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481698 0 0 6.108069 2.532072 -89.664285 0 0 0 0 0 0
$definebone "ValveBiped.Anim_Attachment_RH" "ValveBiped.Bip01_R_Hand" 2.676087 -1.71244 0 0 -89.999975 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033342 1.000767 1.93766 -73.711859 168.619271 91.480542 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028142 0.000002 0 2.738795 -33.527944 -90.505156 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692555 0 0.000005 -0.000007 -3.459061 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481671 0 -0.00003 -6.108482 2.532072 90.136743 0 0 0 0 0 0
$definebone "ValveBiped.Anim_Attachment_LH" "ValveBiped.Bip01_L_Hand" 2.676088 -1.712441 0 -0.000019 90.000023 90.000023 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Thigh" "ValveBiped.Bip01_Pelvis" -3.890452 0.000004 0.000007 2.9705 -90.299349 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Calf" "ValveBiped.Bip01_R_Thigh" 17.848171 0 0 0 1.958771 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Foot" "ValveBiped.Bip01_R_Calf" 16.525253 0 0 2.336451 -61.399999 2.212226 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Toe0" "ValveBiped.Bip01_R_Foot" 6.879454 0 0 -0.16906 -33.48213 -4.660049 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Thigh" "ValveBiped.Bip01_Pelvis" 3.890452 -0.000004 -0.000003 2.970156 -89.700792 -89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Calf" "ValveBiped.Bip01_L_Thigh" 17.848175 0 0 0 1.959516 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Foot" "ValveBiped.Bip01_L_Calf" 16.525249 0 0 -2.336618 -61.400341 -1.599413 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Toe0" "ValveBiped.Bip01_L_Foot" 6.879452 0 0 -0.169039 -33.482137 -0.418217 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859704 -0.142404 -1.191975 8.719849 -50.413059 -27.452933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312563 0.000001 0.000001 0.553764 -25.194097 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729362 0.000002 0 0.284816 -13.997302 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942327 0.046774 -0.431443 4.201386 -46.446697 -8.881647 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539092 0.000002 0 0.255539 -14.197714 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196319 -0.000001 0 0.421753 -24.683137 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883689 -0.046767 0.431443 1.250767 -33.682282 4.921822 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719575 0.000002 0 0.316046 -20.997625 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209182 -0.000001 0 0.176703 -12.398794 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859859 -0.13795 1.332466 -2.449395 -30.465185 20.308434 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000003 0 0.233431 -20.79887 0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099668 0.000001 0 0.148748 -13.999125 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806048 -0.348923 1.321258 -38.931808 -45.224011 -69.147647 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789785 0 0.000002 0.423234 13.093399 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.206998 0 0 0.645542 20.790345 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859672 -0.132566 1.193108 -9.083957 -50.36534 27.452701 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.31256 0 -0.000001 -0.683651 -25.191353 -0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729361 0.000002 0 -0.351451 -13.995692 -0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942293 0.05033 0.431043 -4.543841 -46.421333 8.880789 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539095 0.000003 0 -0.335409 -14.196231 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196323 0 0 -0.553649 -24.680776 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883655 -0.050326 -0.431043 -1.512837 -33.672447 -4.921995 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719575 -0.000005 0 -0.456876 -20.99524 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209182 -0.000001 0 -0.255596 -12.397432 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859828 -0.148935 -1.331282 2.209727 -30.48142 -20.306719 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719425 0 0 -0.378896 -20.796657 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099665 0 0 -0.241272 -13.998055 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806014 -0.359835 -1.318334 38.595463 -45.49033 68.995573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789783 0.000001 0 -0.361024 13.095241 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.207003 0 0.000004 -0.551073 20.792923 -0.000002 0 0 0 0 0 0

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
$bonesaveframe "ValveBiped.Bip01_R_Clavicle" rotation
$bonesaveframe "ValveBiped.Bip01_R_UpperArm" rotation
$bonesaveframe "ValveBiped.Bip01_R_Forearm" rotation
$bonesaveframe "ValveBiped.Bip01_R_Hand" rotation
$bonesaveframe "ValveBiped.Bip01_L_Clavicle" rotation
$bonesaveframe "ValveBiped.Bip01_L_UpperArm" rotation
$bonesaveframe "ValveBiped.Bip01_L_Forearm" rotation
$bonesaveframe "ValveBiped.Bip01_L_Hand" rotation
$bonesaveframe "ValveBiped.Bip01_R_Thigh" rotation
$bonesaveframe "ValveBiped.Bip01_R_Calf" rotation
$bonesaveframe "ValveBiped.Bip01_R_Foot" rotation
$bonesaveframe "ValveBiped.Bip01_L_Thigh" rotation
$bonesaveframe "ValveBiped.Bip01_L_Calf" rotation
$bonesaveframe "ValveBiped.Bip01_L_Foot" rotation

$sectionframes 30 119

$ikchain "rhand" "ValveBiped.Bip01_R_Hand" knee 0.707 0.707 0
$ikchain "lhand" "ValveBiped.Bip01_L_Hand" knee 0.707 0.707 0
$ikchain "rfoot" "ValveBiped.Bip01_R_Foot" knee 0.707 -0.707 0
$ikchain "lfoot" "ValveBiped.Bip01_L_Foot" knee 0.707 -0.707 0

$ikautoplaylock "rfoot" 1 0.1
$ikautoplaylock "lfoot" 1 0.1

$weightlist "weights_shiftrightin" {
	 "ValveBiped.Bip01_Pelvis" 1
	 "ValveBiped.Bip01_Spine" 1
	 "ValveBiped.Bip01_Spine1" 1
	 "ValveBiped.Bip01_Spine2" 1
	 "ValveBiped.Bip01_Spine4" 1
	 "ValveBiped.Bip01_Neck1" 1
	 "ValveBiped.Bip01_Head1" 1
	 "ValveBiped.forward" 1
	 "ValveBiped.Bip01_R_Clavicle" 1
	 "ValveBiped.Bip01_R_UpperArm" 1
	 "ValveBiped.Bip01_R_Forearm" 1
	 "ValveBiped.Bip01_R_Hand" 0
	 "ValveBiped.Anim_Attachment_RH" 0
	 "ValveBiped.Bip01_L_Clavicle" 1
	 "ValveBiped.Bip01_L_UpperArm" 1
	 "ValveBiped.Bip01_L_Forearm" 1
	 "ValveBiped.Bip01_L_Hand" 0
	 "ValveBiped.Anim_Attachment_LH" 0
	 "ValveBiped.Bip01_R_Thigh" 1
	 "ValveBiped.Bip01_R_Calf" 1
	 "ValveBiped.Bip01_R_Foot" 1
	 "ValveBiped.Bip01_R_Toe0" 1
	 "ValveBiped.Bip01_L_Thigh" 1
	 "ValveBiped.Bip01_L_Calf" 1
	 "ValveBiped.Bip01_L_Foot" 1
	 "ValveBiped.Bip01_L_Toe0" 1
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

$weightlist "weights_shiftright" {
	 "ValveBiped.Bip01_Pelvis" 0
	 "ValveBiped.Bip01_Spine" 0
	 "ValveBiped.Bip01_Spine1" 0
	 "ValveBiped.Bip01_Spine2" 0
	 "ValveBiped.Bip01_Spine4" 0
	 "ValveBiped.Bip01_Neck1" 0
	 "ValveBiped.Bip01_Head1" 0
	 "ValveBiped.forward" 0
	 "ValveBiped.Bip01_R_Clavicle" 0
	 "ValveBiped.Bip01_R_UpperArm" 0
	 "ValveBiped.Bip01_R_Forearm" 0
	 "ValveBiped.Bip01_R_Hand" 0
	 "ValveBiped.Anim_Attachment_RH" 0
	 "ValveBiped.Bip01_L_Clavicle" 0
	 "ValveBiped.Bip01_L_UpperArm" 0
	 "ValveBiped.Bip01_L_Forearm" 0
	 "ValveBiped.Bip01_L_Hand" 0
	 "ValveBiped.Anim_Attachment_LH" 0
	 "ValveBiped.Bip01_R_Thigh" 0
	 "ValveBiped.Bip01_R_Calf" 0
	 "ValveBiped.Bip01_R_Foot" 0
	 "ValveBiped.Bip01_R_Toe0" 0
	 "ValveBiped.Bip01_L_Thigh" 0
	 "ValveBiped.Bip01_L_Calf" 0
	 "ValveBiped.Bip01_L_Foot" 0
	 "ValveBiped.Bip01_L_Toe0" 0
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

$animation "@shiftrightin_corrective_animation" "male_postures_anims\@shiftrightin_corrective_animation.smd" {
}

$animation "@shiftrightout_corrective_animation" "male_postures_anims\@shiftrightout_corrective_animation.smd" {
}

$animation "@shiftrightbigin_corrective_animation" "male_postures_anims\@shiftrightbigin_corrective_animation.smd" {
}

$animation "@shiftrightbigout_corrective_animation" "male_postures_anims\@shiftrightbigout_corrective_animation.smd" {
}

$animation "@shiftleftin_corrective_animation" "male_postures_anims\@shiftleftin_corrective_animation.smd" {
}

$animation "@shiftleftout_corrective_animation" "male_postures_anims\@shiftleftout_corrective_animation.smd" {
}

$animation "@P_Drinker_lookrightin_corrective_animation" "male_postures_anims\@P_Drinker_lookrightin_corrective_animation.smd" {
}

$animation "@P_Drinker_lookrightout_corrective_animation" "male_postures_anims\@P_Drinker_lookrightout_corrective_animation.smd" {
}

$animation "@P_Drinker_lookleftin_corrective_animation" "male_postures_anims\@P_Drinker_lookleftin_corrective_animation.smd" {
}

$animation "@P_Drinker_lookleftout_corrective_animation" "male_postures_anims\@P_Drinker_lookleftout_corrective_animation.smd" {
}

$animation "@P_BreakRoom_WatchClockin_corrective_animation" "male_postures_anims\@P_BreakRoom_WatchClockin_corrective_animation.smd" {
}

$animation "@P_BreakRoom_WatchClockout_corrective_animation" "male_postures_anims\@P_BreakRoom_WatchClockout_corrective_animation.smd" {
}

$animation "@P_BreakRoom_Sit_01in_corrective_animation" "male_postures_anims\@P_BreakRoom_Sit_01in_corrective_animation.smd" {
}

$animation "@P_BreakRoom_Sit_01out_corrective_animation" "male_postures_anims\@P_BreakRoom_Sit_01out_corrective_animation.smd" {
}

$animation "@Scan_Skies_Respondin_corrective_animation" "male_postures_anims\@Scan_Skies_Respondin_corrective_animation.smd" {
}

$animation "@Scan_Skies_Respondout_corrective_animation" "male_postures_anims\@Scan_Skies_Respondout_corrective_animation.smd" {
}

$animation "@p_ConsoleType_Riflein_corrective_animation" "male_postures_anims\@p_ConsoleType_Riflein_corrective_animation.smd" {
}

$animation "@p_ConsoleType_Rifleout_corrective_animation" "male_postures_anims\@p_ConsoleType_Rifleout_corrective_animation.smd" {
}

$animation "@p_town05_RadioLeanin_corrective_animation" "male_postures_anims\@p_town05_RadioLeanin_corrective_animation.smd" {
}

$animation "@p_town05_RadioLeanout_corrective_animation" "male_postures_anims\@p_town05_RadioLeanout_corrective_animation.smd" {
}

$animation "@p_bouncingin_corrective_animation" "male_postures_anims\@p_bouncingin_corrective_animation.smd" {
}

$animation "@p_bouncingout_corrective_animation" "male_postures_anims\@p_bouncingout_corrective_animation.smd" {
}

$animation "@p_stepleftin_corrective_animation" "male_postures_anims\@p_stepleftin_corrective_animation.smd" {
}

$animation "@p_stepleftout_corrective_animation" "male_postures_anims\@p_stepleftout_corrective_animation.smd" {
}

$animation "@p_jumpupin_corrective_animation" "male_postures_anims\@p_jumpupin_corrective_animation.smd" {
}

$animation "@p_jumpupout_corrective_animation" "male_postures_anims\@p_jumpupout_corrective_animation.smd" {
}

$animation "@p_balance_toesin_corrective_animation" "male_postures_anims\@p_balance_toesin_corrective_animation.smd" {
}

$animation "@p_balance_toesout_corrective_animation" "male_postures_anims\@p_balance_toesout_corrective_animation.smd" {
}

$animation "@p_bendoverin_corrective_animation" "male_postures_anims\@p_bendoverin_corrective_animation.smd" {
}

$animation "@p_bendoverout_corrective_animation" "male_postures_anims\@p_bendoverout_corrective_animation.smd" {
}

$animation "@p_stepinin_corrective_animation" "male_postures_anims\@p_stepinin_corrective_animation.smd" {
}

$animation "@p_stepinout_corrective_animation" "male_postures_anims\@p_stepinout_corrective_animation.smd" {
}

$animation "@P_lean_on_carin_corrective_animation" "male_postures_anims\@P_lean_on_carin_corrective_animation.smd" {
}

$animation "@P_lean_on_carout_corrective_animation" "male_postures_anims\@P_lean_on_carout_corrective_animation.smd" {
}

$animation "@p_kickin_corrective_animation" "male_postures_anims\@p_kickin_corrective_animation.smd" {
}

$animation "@p_kickout_corrective_animation" "male_postures_anims\@p_kickout_corrective_animation.smd" {
}

$animation "@p_ar2_step_lin_corrective_animation" "male_postures_anims\@p_ar2_step_lin_corrective_animation.smd" {
}

$animation "@p_ar2_step_lout_corrective_animation" "male_postures_anims\@p_ar2_step_lout_corrective_animation.smd" {
}

$animation "@p_ar2_relaxedin_corrective_animation" "male_postures_anims\@p_ar2_relaxedin_corrective_animation.smd" {
}

$animation "@p_ar2_relaxedout_corrective_animation" "male_postures_anims\@p_ar2_relaxedout_corrective_animation.smd" {
}

$animation "@p_point_down_leftin_corrective_animation" "male_postures_anims\@p_point_down_leftin_corrective_animation.smd" {
}

$animation "@p_point_down_leftout_corrective_animation" "male_postures_anims\@p_point_down_leftout_corrective_animation.smd" {
}

$animation "@p_fingerpointupin_corrective_animation" "male_postures_anims\@p_fingerpointupin_corrective_animation.smd" {
}

$animation "@p_fingerpointupout_corrective_animation" "male_postures_anims\@p_fingerpointupout_corrective_animation.smd" {
}

$animation "@p_readyin_corrective_animation" "male_postures_anims\@p_readyin_corrective_animation.smd" {
}

$animation "@p_readyout_corrective_animation" "male_postures_anims\@p_readyout_corrective_animation.smd" {
}

$animation "@p_L_foot_forwin_corrective_animation" "male_postures_anims\@p_L_foot_forwin_corrective_animation.smd" {
}

$animation "@p_L_foot_forwout_corrective_animation" "male_postures_anims\@p_L_foot_forwout_corrective_animation.smd" {
}

$sequence "reference" {
	"male_postures_anims\reference.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "shiftrightloop" {
	"male_postures_anims\shiftrightloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "shiftrightin" {
	"male_postures_anims\shiftrightin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftrightin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftrightout" {
	"male_postures_anims\shiftrightout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftrightout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftright" {
	"male_postures_anims\shiftright.smd"
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
			"loop"			"40"
			"end"			"70"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "shiftrightloop" 0 40 70 100 spline
	blendlayer "shiftrightin" 0 0 40 40
	blendlayer "shiftrightout" 70 70 100 100
	fps 30
	weightlist "weights_shiftright"
}

$sequence "shiftrightbigloop" {
	"male_postures_anims\shiftrightbigloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "shiftrightbigin" {
	"male_postures_anims\shiftrightbigin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftrightbigin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftrightbigout" {
	"male_postures_anims\shiftrightbigout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftrightbigout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftrightbig" {
	"male_postures_anims\shiftrightbig.smd"
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
			"loop"			"30"
			"end"			"50"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"30"
	}
}
	blendlayer "shiftrightbigloop" 0 30 50 80 spline
	blendlayer "shiftrightbigin" 0 0 30 30
	blendlayer "shiftrightbigout" 50 50 80 80
	fps 30
	weightlist "weights_shiftright"
}

$sequence "shiftleftloop" {
	"male_postures_anims\shiftleftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "shiftleftin" {
	"male_postures_anims\shiftleftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftleftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftleftout" {
	"male_postures_anims\shiftleftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@shiftleftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "shiftleft" {
	"male_postures_anims\shiftleft.smd"
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
			"loop"			"22"
			"end"			"40"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"22"
	}
}
	blendlayer "shiftleftloop" 0 22 40 60 spline
	blendlayer "shiftleftin" 0 0 22 22
	blendlayer "shiftleftout" 40 40 60 60
	fps 30
	weightlist "weights_shiftright"
}

$sequence "P_Drinker_lookrightloop" {
	"male_postures_anims\P_Drinker_lookrightloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "P_Drinker_lookrightin" {
	"male_postures_anims\P_Drinker_lookrightin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Drinker_lookrightin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_Drinker_lookrightout" {
	"male_postures_anims\P_Drinker_lookrightout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Drinker_lookrightout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_Drinker_lookright" {
	"male_postures_anims\P_Drinker_lookright.smd"
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
			"loop"			"24"
			"end"			"34"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"24"
	}
}
	blendlayer "P_Drinker_lookrightloop" 0 24 34 60 spline
	blendlayer "P_Drinker_lookrightin" 0 0 24 24
	blendlayer "P_Drinker_lookrightout" 34 34 60 60
	fps 30
	weightlist "weights_shiftright"
}

$sequence "P_Drinker_lookleftloop" {
	"male_postures_anims\P_Drinker_lookleftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "P_Drinker_lookleftin" {
	"male_postures_anims\P_Drinker_lookleftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Drinker_lookleftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_Drinker_lookleftout" {
	"male_postures_anims\P_Drinker_lookleftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_Drinker_lookleftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_Drinker_lookleft" {
	"male_postures_anims\P_Drinker_lookleft.smd"
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
			"loop"			"20"
			"end"			"25"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"20"
	}
}
	blendlayer "P_Drinker_lookleftloop" 0 20 25 50 spline
	blendlayer "P_Drinker_lookleftin" 0 0 20 20
	blendlayer "P_Drinker_lookleftout" 25 25 50 50
	fps 30
	weightlist "weights_shiftright"
}

$sequence "P_BreakRoom_WatchClockloop" {
	"male_postures_anims\P_BreakRoom_WatchClockloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "P_BreakRoom_WatchClockin" {
	"male_postures_anims\P_BreakRoom_WatchClockin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_BreakRoom_WatchClockin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_BreakRoom_WatchClockout" {
	"male_postures_anims\P_BreakRoom_WatchClockout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_BreakRoom_WatchClockout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_BreakRoom_WatchClock" {
	"male_postures_anims\P_BreakRoom_WatchClock.smd"
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
	blendlayer "P_BreakRoom_WatchClockloop" 0 30 40 70 spline
	blendlayer "P_BreakRoom_WatchClockin" 0 0 30 30
	blendlayer "P_BreakRoom_WatchClockout" 40 40 70 70
	fps 30
	weightlist "weights_shiftright"
}

$sequence "P_BreakRoom_Sit_01loop" {
	"male_postures_anims\P_BreakRoom_Sit_01loop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "P_BreakRoom_Sit_01in" {
	"male_postures_anims\P_BreakRoom_Sit_01in.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_BreakRoom_Sit_01in_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_BreakRoom_Sit_01out" {
	"male_postures_anims\P_BreakRoom_Sit_01out.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_BreakRoom_Sit_01out_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_BreakRoom_Sit_01" {
	"male_postures_anims\P_BreakRoom_Sit_01.smd"
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
	blendlayer "P_BreakRoom_Sit_01loop" 0 40 50 80 spline
	blendlayer "P_BreakRoom_Sit_01in" 0 0 40 40
	blendlayer "P_BreakRoom_Sit_01out" 50 50 80 80
	fps 30
	weightlist "weights_shiftright"
}

$sequence "Scan_Skies_Respondloop" {
	"male_postures_anims\Scan_Skies_Respondloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "Scan_Skies_Respondin" {
	"male_postures_anims\Scan_Skies_Respondin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@Scan_Skies_Respondin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "Scan_Skies_Respondout" {
	"male_postures_anims\Scan_Skies_Respondout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@Scan_Skies_Respondout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "Scan_Skies_Respond" {
	"male_postures_anims\Scan_Skies_Respond.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_ConsoleType_Rifleloop" {
	"male_postures_anims\p_ConsoleType_Rifleloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_ConsoleType_Riflein" {
	"male_postures_anims\p_ConsoleType_Riflein.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ConsoleType_Riflein_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ConsoleType_Rifleout" {
	"male_postures_anims\p_ConsoleType_Rifleout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ConsoleType_Rifleout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ConsoleType_Rifle" {
	"male_postures_anims\p_ConsoleType_Rifle.smd"
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
			"loop"			"47"
			"end"			"60"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"47"
	}
}
	blendlayer "p_ConsoleType_Rifleloop" 0 47 60 88 spline
	blendlayer "p_ConsoleType_Riflein" 0 0 47 47
	blendlayer "p_ConsoleType_Rifleout" 60 60 88 88
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_town05_RadioLeanloop" {
	"male_postures_anims\p_town05_RadioLeanloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_town05_RadioLeanin" {
	"male_postures_anims\p_town05_RadioLeanin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_town05_RadioLeanin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_town05_RadioLeanout" {
	"male_postures_anims\p_town05_RadioLeanout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_town05_RadioLeanout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_town05_RadioLean" {
	"male_postures_anims\p_town05_RadioLean.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"6"
			"loop"			"50"
			"end"			"111"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"50"
	}
}
	blendlayer "p_town05_RadioLeanloop" 0 50 111 170 spline
	blendlayer "p_town05_RadioLeanin" 0 0 50 50
	blendlayer "p_town05_RadioLeanout" 111 111 170 170
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_bouncingloop" {
	"male_postures_anims\p_bouncingloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_bouncingin" {
	"male_postures_anims\p_bouncingin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bouncingin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_bouncingout" {
	"male_postures_anims\p_bouncingout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bouncingout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_bouncing" {
	"male_postures_anims\p_bouncing.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_stepleftloop" {
	"male_postures_anims\p_stepleftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_stepleftin" {
	"male_postures_anims\p_stepleftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepleftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_stepleftout" {
	"male_postures_anims\p_stepleftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepleftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_stepleft" {
	"male_postures_anims\p_stepleft.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_jumpuploop" {
	"male_postures_anims\p_jumpuploop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_jumpupin" {
	"male_postures_anims\p_jumpupin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_jumpupin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_jumpupout" {
	"male_postures_anims\p_jumpupout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_jumpupout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_jumpup" {
	"male_postures_anims\p_jumpup.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_balance_toesloop" {
	"male_postures_anims\p_balance_toesloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_balance_toesin" {
	"male_postures_anims\p_balance_toesin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_balance_toesin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_balance_toesout" {
	"male_postures_anims\p_balance_toesout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_balance_toesout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_balance_toes" {
	"male_postures_anims\p_balance_toes.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_bendoverloop" {
	"male_postures_anims\p_bendoverloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_bendoverin" {
	"male_postures_anims\p_bendoverin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bendoverin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_bendoverout" {
	"male_postures_anims\p_bendoverout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_bendoverout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_bendover" {
	"male_postures_anims\p_bendover.smd"
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
	weightlist "weights_shiftright"
}

$sequence "p_stepinloop" {
	"male_postures_anims\p_stepinloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_stepinin" {
	"male_postures_anims\p_stepinin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepinin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_stepinout" {
	"male_postures_anims\p_stepinout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_stepinout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_stepin" {
	"male_postures_anims\p_stepin.smd"
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
	weightlist "weights_shiftright"
}

$sequence "P_lean_on_carloop" {
	"male_postures_anims\P_lean_on_carloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 20
	loop
}

$sequence "P_lean_on_carin" {
	"male_postures_anims\P_lean_on_carin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_lean_on_carin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_lean_on_carout" {
	"male_postures_anims\P_lean_on_carout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@P_lean_on_carout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "P_lean_on_car" {
	"male_postures_anims\P_lean_on_car.smd"
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
			"loop"			"30"
			"end"			"60"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"30"
	}
}
	blendlayer "P_lean_on_carloop" 0 30 60 90 spline
	blendlayer "P_lean_on_carin" 0 0 30 30
	blendlayer "P_lean_on_carout" 60 60 90 90
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_kickloop" {
	"male_postures_anims\p_kickloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 20
	loop
}

$sequence "p_kickin" {
	"male_postures_anims\p_kickin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_kickin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_kickout" {
	"male_postures_anims\p_kickout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_kickout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_kick" {
	"male_postures_anims\p_kick.smd"
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
			"loop"			"20"
			"end"			"40"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"20"
	}
}
	blendlayer "p_kickloop" 0 20 40 60 spline
	blendlayer "p_kickin" 0 0 20 20
	blendlayer "p_kickout" 40 40 60 60
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_ar2_step_lloop" {
	"male_postures_anims\p_ar2_step_lloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "p_ar2_step_lin" {
	"male_postures_anims\p_ar2_step_lin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ar2_step_lin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ar2_step_lout" {
	"male_postures_anims\p_ar2_step_lout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ar2_step_lout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ar2_step_l" {
	"male_postures_anims\p_ar2_step_l.smd"
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
			"loop"			"41"
			"end"			"61"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"41"
	}
}
	blendlayer "p_ar2_step_lloop" 0 41 61 86 spline
	blendlayer "p_ar2_step_lin" 0 0 41 41
	blendlayer "p_ar2_step_lout" 61 61 86 86
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_ar2_relaxedloop" {
	"male_postures_anims\p_ar2_relaxedloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 10
	loop
}

$sequence "p_ar2_relaxedin" {
	"male_postures_anims\p_ar2_relaxedin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ar2_relaxedin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ar2_relaxedout" {
	"male_postures_anims\p_ar2_relaxedout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_ar2_relaxedout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ar2_relaxed" {
	"male_postures_anims\p_ar2_relaxed.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"5"
			"loop"			"38"
			"end"			"70"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"38"
	}
}
	blendlayer "p_ar2_relaxedloop" 0 38 70 100 spline
	blendlayer "p_ar2_relaxedin" 0 0 38 38
	blendlayer "p_ar2_relaxedout" 70 70 100 100
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_point_down_leftloop" {
	"male_postures_anims\p_point_down_leftloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_point_down_leftin" {
	"male_postures_anims\p_point_down_leftin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_point_down_leftin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_point_down_leftout" {
	"male_postures_anims\p_point_down_leftout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_point_down_leftout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_point_down_left" {
	"male_postures_anims\p_point_down_left.smd"
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
			"loop"			"36"
			"end"			"40"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"36"
	}
}
	blendlayer "p_point_down_leftloop" 0 36 40 76 spline
	blendlayer "p_point_down_leftin" 0 0 36 36
	blendlayer "p_point_down_leftout" 40 40 76 76
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_fingerpointuploop" {
	"male_postures_anims\p_fingerpointuploop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_fingerpointupin" {
	"male_postures_anims\p_fingerpointupin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_fingerpointupin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_fingerpointupout" {
	"male_postures_anims\p_fingerpointupout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_fingerpointupout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
}

$sequence "p_fingerpointup" {
	"male_postures_anims\p_fingerpointup.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"25"
			"loop"			"40"
			"end"			"41"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "p_fingerpointuploop" 0 40 41 70 spline
	blendlayer "p_fingerpointupin" 0 0 40 40
	blendlayer "p_fingerpointupout" 41 41 70 70
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_readyloop" {
	"male_postures_anims\p_readyloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_readyin" {
	"male_postures_anims\p_readyin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_readyin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_readyout" {
	"male_postures_anims\p_readyout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_readyout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_ready" {
	"male_postures_anims\p_ready.smd"
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
			"end"			"80"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"40"
	}
}
	blendlayer "p_readyloop" 0 40 80 105 spline
	blendlayer "p_readyin" 0 0 40 40
	blendlayer "p_readyout" 80 80 105 105
	fps 30
	weightlist "weights_shiftright"
}

$sequence "p_L_foot_forwloop" {
	"male_postures_anims\p_L_foot_forwloop.smd"
	fadein 0.2
	fadeout 0.2
	hidden
	realtime
	fps 30
	loop
}

$sequence "p_L_foot_forwin" {
	"male_postures_anims\p_L_foot_forwin.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_L_foot_forwin_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_L_foot_forwout" {
	"male_postures_anims\p_L_foot_forwout.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@p_L_foot_forwout_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	hidden
	fps 30
	weightlist "weights_shiftrightin"
}

$sequence "p_L_foot_forw" {
	"male_postures_anims\p_L_foot_forw.smd"
	fadein 0.2
	fadeout 0.2

keyvalues
{
	faceposer 
	{
		"type"		"posture"
		"tags"		 
		{
			"apex"			"25"
			"loop"			"45"
			"end"			"80"
		}
		"endmatch"		"loop"
		"thumbnail_frame"		"45"
	}
}
	blendlayer "p_L_foot_forwloop" 0 45 80 120 spline
	blendlayer "p_L_foot_forwin" 0 0 45 45
	blendlayer "p_L_foot_forwout" 80 80 120 120
	fps 30
	weightlist "weights_shiftright"
}
