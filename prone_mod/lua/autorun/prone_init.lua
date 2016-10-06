-- Copyright 2016 George "Stalker" Petrou, enjoy!
prone = prone or {}

if SERVER then
	resource.AddWorkshop("775573383")
end

local function InitProne(folder)
	if SERVER then
		AddCSLuaFile("prone/"..folder.."/cl_prone.lua")
		AddCSLuaFile("prone/"..folder.."/sh_prone.lua")
		AddCSLuaFile("prone/"..folder.."/sh_prone_hooks.lua")
		AddCSLuaFile("prone/config.lua")

		include("prone/config.lua")
		include("prone/"..folder.."/sv_prone.lua")
		include("prone/"..folder.."/sv_prone_hooks.lua")
	else
		include("prone/config.lua")
		include("prone/"..folder.."/cl_prone.lua")
	end

	include("prone/"..folder.."/sh_prone.lua")
	include("prone/"..folder.."/sh_prone_hooks.lua")
end

hook.Add("Initialize", "Prone_Load", function()
	if GAMEMODE.DerivedFrom == "nutscript" or GAMEMODE.DerivedFrom == "clockwork" then
		prone.CW_NS_Mode = true
		InitProne("prone_cw_ns_version")
	else
		InitProne("prone_normal_version")
	end
end)