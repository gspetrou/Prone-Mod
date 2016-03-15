-- Made by George "Stalker" Petrou, enjoy!

prone = {}
if SERVER then
	AddCSLuaFile("prone/cl_prone.lua")
	AddCSLuaFile("prone/sh_prone.lua")
	AddCSLuaFile("prone/sh_prone_hooks.lua")
	AddCSLuaFile("prone/config.lua")

	include("prone/config.lua")
	include("prone/sv_prone.lua")
	include("prone/sv_prone_hooks.lua")

	resource.AddWorkshop("609281761")
else
	include("prone/config.lua")
	include("prone/cl_prone.lua")
end

include("prone/sh_prone.lua")
include("prone/sh_prone_hooks.lua")