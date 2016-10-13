-- Copyright 2016 George "Stalker" Petrou, enjoy!
prone = prone or {}
prone.config = prone.config or {}

if SERVER then
	resource.AddWorkshop("775573383")

	AddCSLuaFile("prone/config.lua")
	AddCSLuaFile("prone/sh_prone.lua")
	AddCSLuaFile("prone/cl_prone.lua")

	include("prone/config.lua")
	include("prone/sv_prone.lua")
else
	include("prone/config.lua")
	include("prone/cl_prone.lua")
end
include("prone/sh_prone.lua")