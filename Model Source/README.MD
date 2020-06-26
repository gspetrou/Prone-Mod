## Prone Model Source

The source for the Garry's Mod models is found [here](https://github.com/robotboy655/gmod-animations). The source for the two HL2 models found in the "hl2model_stuff" folder are decompiled versions of the same files found within the Garry's Mod vpks. Crowbar version 0.68 was used to compile these files.

**QC File Descriptions:**

 - player_male_anims_m_anm.qc - Builds m_anm.mdl and m_anm.ani, the animation base for male Garry's Mod models.
 - player_female_anims_f_anm.qc - Same as player_female_anims_m_anm but for females
 - player_female_anims_z_anm.qc - Same as player_female_anims_m_anm but for zombies.
 - wos_model_extension.qc - Builds a model, "player/wiltos/anim_extension_prone.mdl", which houses just the prone animations. Useful for other models to $IncludeModel so they can contain the prone animations. Used by [wOS](http://steamcommunity.com/sharedfiles/filedetails/?id=757604550) and the HL2 models in the hl2model_stuff folder.
 - hl2model_stuff/male_postures.qc - Created by decompiling models/humans/male_postures.mdl in the Garry's Mod vpks. Recompiled to $IncludeModel anim_extension_prone.mdl. Adds prone animations to the hl2 models.
 - hl2model_stuff/female_postures.qc - Same as hl2model_stuff/male_postures.qc but for females.
 - hl2model_stuff/police_ss.qc.qc - Created by decompiling models/police_ss.mdl in the Garry's Mod vpks. Recompiled to $IncludeModel anim_extension_prone.mdl. Adds prone animations to the police models.

All other qc files are not used and are commented out.
