---------------------------------------------------------------------------------------------

local CurrentVersion = 0 -- forcibly update the code to make it compatible with the location change!

local HttpService = game:GetService("HttpService")

local CodeURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/Spacescript/spacescript.luau"
local VersionURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/Spacescript/version.json"

local function FetchCode()
	local Success, Data = pcall(function()
		return HttpService:GetAsync(CodeURL)
	end)

	if Success then
		return Data
	else
		warn("Error fetching code: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchCode()
	end
end

local function FetchVersion()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync(VersionURL))
	end)

	if Success then
		return Data
	else
		warn("Error fetching version: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchVersion()
	end
end

local Code = FetchCode() 
local Version = FetchVersion()

if CurrentVersion < Version.Version then
	task.wait(1)
	warn("Updating to version " .. Version.Version .. "... (" .. Version.Changelog .. ")")
	
	local CurrentCode = 
	"local Music = {\n\t" .. table.concat(Music, ", \n\t") .. "\n}\n" ..
	"local MusicKeybind = " .. tostring(MusicKeybind) .. "\n" ..
	"local MusicVolume = " .. tostring(MusicVolume) .. "\n" ..
	"local MusicEnabled = " .. tostring(MusicEnabled) .. "\n" ..
	"local PopupNowPlaying = " .. tostring(PopupNowPlaying) .. "\n" ..
	"local DefaultGravityConstant = " .. tostring(DefaultGravityConstant) .. "\n" ..
	"local SpaceGravityConstant = " .. tostring(SpaceGravityConstant) .. "\n" ..
	"local SpaceHeightConstant = " .. tostring(SpaceHeightConstant) .. "\n" ..
	"local SunAngularSize = " .. tostring(SunAngularSize) .. "\n" ..
	"local MoonAngularSize = " .. tostring(MoonAngularSize) .. "\n" ..
	"local SunRaysIntensity = " .. tostring(SunRaysIntensity) .. "\n" ..
	"local SunRaySpread = " .. tostring(SunRaySpread) .. "\n" ..
	"local SunTextureId = \"" .. tostring(SunTextureId) .. "\"\n" ..
	"local MoonTextureId = \"" .. tostring(MoonTextureId) .. "\"\n" ..
	"local AirBlockSearchDistance = " .. tostring(AirBlockSearchDistance) .. "\n\n"
	
	task.wait(3)
	print("Updated!")
	script:SetAttribute("Code", CurrentCode .. Code)
end
