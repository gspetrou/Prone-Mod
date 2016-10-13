-- Copyright 2016 George "Stalker" Petrou, enjoy!
prone = prone or {}
prone.config = prone.config or {}

function net.WritePlayer(pl)
	if IsValid(pl) then 
		net.WriteUInt(pl:EntIndex(), 7)
	else
		net.WriteUInt(0, 7)
	end
end

function net.ReadPlayer()
	local i = net.ReadUInt(7)
	if not i then
		return
	end
	return Entity(i)
end

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