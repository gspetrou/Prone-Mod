
# The Prone Mod

Coded by [Stalker](https://steamcommunity.com/id/your-stalker) (George Petrou)

Animations by [Stiffy360](https://steamcommunity.com/id/barnwellewell/)

Animations ported to HL2 base by Stalker

## Installing
I have other animation mods installed
 - Install the [wOS Version](https://steamcommunity.com/sharedfiles/filedetails/?id=775573383) of the Prone Mod, the [wOS Prone Extension](https://steamcommunity.com/workshop/filedetails/?id=918084741), and the [wOS Base Extension](https://steamcommunity.com/workshop/filedetails/?id=757604550).
 - Note that this version of the Prone Mod will only work with other animation mods if they are compatible with wOS.

I do not have other animation mods installed
 - Simply install the standalone version of the [Prone Mod](https://steamcommunity.com/sharedfiles/filedetails/?id=1100368137).

If you're running a server make sure all your clients download the files too. **Only WorkshopDL will work!** FastDL will not work for downloading these files.

## Frequently Asked Questions
How do you add custom animations to Garry's Mod models?
 - You have to compile m_anm.mdl, f_anm.mdl, z_anm.mdl, found in the Garry's Mod model source [here](https://github.com/robotboy655/gmod-animations), with the animations you want.

How do you add custom animations to the HL2/Police models?
 - That was done by decompiling "humans/male_postures.mdl", "humans/female_postures.mdl", and "police_ss.mdl" from the Garry's Mod vpk, then recompiling them with the animations you want to add. You can see those in the "Model Source/gmod_animations/hl2model_stuff" folder in this repository.

Why can I only have one animation mod installed at a time?
- Only one addon will be able to override m_anm.mdl, f_anm.mdl, z_anm.mdl, male_postures.mdl, female_postures.mdl, and police_ss.mdl

What is the wOS version and why should I use it?
 - wOS is a coordinated effort to enable support for multiple animation mods at once. The wOS base overrides m_anm.mdl, f_anm.mdl, and z_anm.mdl, then tries to load all of the wOS extensions present. It loads them using the $IncludeModel qc command, and non-present wOS extensions will silently fail to load. This is different than my version of m_anm.mdl, f_anm.mdl, and z_anm.mdl which only include my own prone animations and don't look for any third-party animations.

Are gamemodes like Clockwork, Nutscript, and Helix supported?
 - Yes, the Prone Mod was updated to support player models using the HL2 NPC animation base so they should work fine. However, Clockwork support is not guaranteed since it is a private gamemode.

---
Copyright 2016-2020 George "Stalker" Petrou

You are free to do anything with the contents of this repository except the following:
 - Sell them, modified or not.
 - Claim them as your own.
