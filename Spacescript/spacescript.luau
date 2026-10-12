---------------------------------------------------------------------------------------------

local CurrentVersion = 3

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
		return HttpService:JSONDecode(HttpService:GetAsync(VersionURL)).Version
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

if CurrentVersion < Version then
	print("This code is outdated! " .. CurrentVersion .. " < " .. Version .. " (updating...)")
	local CurrentCode = 
	"local Music = {\n" .. table.concat(Music, ", \n") .. "\n}\n" ..
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
	"local SunTextureId = " .. tostring(SunTextureId) .. "\n" ..
	"local MoonTextureId = " .. tostring(MoonTextureId) .. "\n" ..
	"local AirBlockSearchDistance = " .. tostring(AirBlockSearchDistance) .. "\n\n"

	script:SetAttribute("Code", CurrentCode .. Code)
end

local Game = getfenv().game

local Workspace = Game:GetService("Workspace")
local Lighting = Game:GetService("Lighting")
local Players = Game:GetService("Players")
local MarketplaceService = Game:GetService("MarketplaceService")
local AssetService = Game:GetService("AssetService")
local TweenService = game:GetService("TweenService")
local UserInputService = Game:GetService("UserInputService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local HalfTime = true
local IsPlayingMusic = false
local MusicSound = nil
local MusicConnection = nil
local Metadata = {}

function GetMetadata()
	local Success, Result = pcall(function()
		return AssetService:GetAudioMetadataAsync(Music)
	end)

	if Success and Result then
		Metadata = Result
	else
		warn("Failed to load metadata, Retrying in 2 seconds. Error: " .. tostring(Result))
		task.wait(2)
		GetMetadata()
	end
end

task.spawn(GetMetadata)


--------------------------------------- LIGHTING & ATMOSPHERE ---------------------------------------

local Sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)

--Ground--
local SkyboxBkPrev = Sky.SkyboxBk
local SkyboxDnPrev = Sky.SkyboxDn
local SkyboxFtPrev = Sky.SkyboxFt
local SkyboxLfPrev = Sky.SkyboxLf
local SkyboxRtPrev = Sky.SkyboxRt
local SkyboxUpPrev = Sky.SkyboxUp

--Space--

local SkyboxBk = "rbxassetid://8246680898"
local SkyboxDn = "rbxassetid://8246680712"
local SkyboxFt = "rbxassetid://8246680301"
local SkyboxLf = "rbxassetid://8246680439"
local SkyboxRt = "rbxassetid://8246680055"
local SkyboxUp = "rbxassetid://8246680165"

local Blue = SkyboxBk

function SkyboxSpace()
	Sky.SkyboxBk = SkyboxBk
	Sky.SkyboxDn = SkyboxDn
	Sky.SkyboxFt = SkyboxFt
	Sky.SkyboxLf = SkyboxLf
	Sky.SkyboxRt = SkyboxRt
	Sky.SkyboxUp = SkyboxUp
end

function SkyboxDefault()
	Sky.SkyboxBk = SkyboxBkPrev
	Sky.SkyboxDn = SkyboxDnPrev
	Sky.SkyboxFt = SkyboxFtPrev
	Sky.SkyboxLf = SkyboxLfPrev
	Sky.SkyboxRt = SkyboxRtPrev
	Sky.SkyboxUp = SkyboxUpPrev
end

Lighting.FogStart = 999999999999999
Lighting.FogEnd = 999999999999999

Lighting.SunRays.Intensity = SunRaysIntensity
Lighting.SunRays.Spread = SunRaySpread

local Atmosphere = Lighting:FindFirstChild("Atmosphere") or nil
if Atmosphere == nil then
	Atmosphere = Instance.new("Atmosphere")
	Atmosphere.Parent = Lighting
end

Atmosphere.Color = Color3.fromRGB(0, 0, 0)
Atmosphere.Decay = Color3.fromRGB(179, 208, 255)

Atmosphere.Haze = 10
Atmosphere.Glare = 0.18

SkyboxSpace()
Sky.SunAngularSize = SunAngularSize
Sky.SunTextureId = "rbxassetid://" .. SunTextureId

Sky.MoonTextureId = "rbxassetid://" .. MoonTextureId
Sky.MoonAngularSize = MoonAngularSize

Sky.StarCount = 0

Sky.SkyboxOrientation = Vector3.new(0, 0, 0)
Lighting.Brightness = 2
Sky.MoonAngularSize = MoonAngularSize

Workspace.Terrain.Clouds.Cover = 0.688
Workspace.Terrain.Clouds.Density = 0.8

--------------------------------------- MAIN --------------------------------------- 

function CalculateGravity(Height)
	local ClampedHeight = math.clamp(Height, 0, SpaceHeightConstant)
	local t = ClampedHeight / SpaceHeightConstant

	local Formula = (1 - t)

	return SpaceGravityConstant + (DefaultGravityConstant - SpaceGravityConstant) * Formula
end

function CalculateAtmosphere(Height)
	local Percent = math.clamp(Height / SpaceHeightConstant, 0, 1)
	local Inverse = 1 - Percent
	Atmosphere.Glare = 0.18 * Inverse
	Atmosphere.Haze =  20 * Inverse

	local ClampedHeight = math.clamp(Height, 0, SpaceHeightConstant * 1.5)
	local t = ClampedHeight / SpaceHeightConstant

	local Formula = (1 - t) * 7

	local gh = SpaceGravityConstant + (255 - 196.2) * Formula
	local Divider = 1.7
	local Reducer = 0

	if Lighting.ClockTime >= 19 or Lighting.ClockTime <= 5 then -- Night
		Divider = 700
		Reducer = 500

		Sky.StarCount = 50000
		Workspace.Terrain.Clouds.Cover = 0
	else -- Day
		Divider = 1.7
		Reducer = 0

		Sky.StarCount = 0
		Workspace.Terrain.Clouds.Cover = 0.688
	end

	local WhiteValue = (gh / Divider)

	Atmosphere.Color = Color3.fromRGB(WhiteValue + 50, WhiteValue * 2, WhiteValue * 3)
	Atmosphere.Decay = Color3.fromRGB(WhiteValue + 50, WhiteValue * 2, WhiteValue * 3)

end

local IsMuted = false
local MusicIndex = 0

local function StartMusicSystem()
	IsPlayingMusic = true;
	local y = Instance.new("Sound")
	y.Parent = Workspace;
	MusicSound = y;
	MusicSound.Name = "OUTERSPACEMUSIC"
	MusicSound.Volume = IsMuted and 0 or MusicVolume
	
	if MusicConnection then MusicConnection:Disconnect() end
	
	MusicConnection = UserInputService.InputBegan:Connect(function(z, A)
		if z.KeyCode == MusicKeybind and not A then
			IsMuted = not IsMuted;
			if IsMuted == true then
				MusicSound.Volume = 0
			else
				MusicSound.Volume = MusicVolume
			end
		end
	end)

	local i = 0
	local function PlayTrack()
		if IsPlayingMusic ~= true then return end
		i += 1
		if i > #Music then
			i = 1
		end
		local Chosen = Music[i]
		local AntiFloatingPoint
		local Successs, Resuult = pcall(function()
			local Info = MarketplaceService:GetProductInfoAsync(Chosen)
			AntiFloatingPoint = Info.TargetId
			if MusicSound then
				MusicSound.SoundId = "rbxassetid://" .. AntiFloatingPoint
			end
			return Info
		end)
		if not Successs then
			warn("Music loading failed: " .. tostring(Resuult))
			task.wait(5)
			PlayTrack()
			return
		end
		if MusicSound then
			if Chosen == 94807404649914 then
				MusicSound.PlaybackSpeed = 0.1
			else
				MusicSound.PlaybackSpeed = 1
			end

			if MusicSound.Volume == MusicVolume and PopupNowPlaying == true then
				task.wait(0.1)
				if Metadata and Metadata[i] then
					local ArtistName = Metadata[i].Artist or "Unknown Artist"
					local TrackTitle = Metadata[i].Title or (Resuult and Resuult.Name) or "Unknown Track"
					print("Track " .. i .. ": " .. ArtistName .. " - " .. TrackTitle .. " (" .. Chosen .. ",  " .. math.floor(MusicSound.TimeLength) .. "s).")
				elseif Resuult then
					print("Track " .. i .. ": " .. Resuult.Name .. " (" .. Chosen .. ",  " .. math.floor(MusicSound.TimeLength) .. "s).")
				else
					warn("Failed to get song name data for track: " .. i)
				end
			end
			MusicSound:Play()
		end
	end;
	
	y.Ended:Connect(PlayTrack)
	PlayTrack()
end;

local function CleanMusicSystem()
	IsPlayingMusic = false
	if MusicSound then
		MusicSound:Destroy()
		MusicSound = nil
	end
	if MusicConnection then
		MusicConnection:Disconnect()
		MusicConnection = nil
	end
end

local SpatialParams = OverlapParams.new()
SpatialParams.FilterType = Enum.RaycastFilterType.Include

function load()
	local OldMusic = Workspace:FindFirstChild("OUTERSPACEMUSIC")

	if OldMusic ~= nil and OldMusic then
		OldMusic:Destroy()
	end
	IsPlayingMusic = false

	task.wait(1)

	while true do
		if LocalPlayer.Character then
			local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			
			if HumanoidRootPart and Humanoid then
				local Height = HumanoidRootPart.Position.Y or nil
				local CameraHeight = Workspace.CurrentCamera.CFrame.Position.Y or nil
				Workspace.Gravity = CalculateGravity(Height)
				CalculateAtmosphere(CameraHeight) --that way we can see space through satellites with cams and stuff without actually being up there
				SkyboxSpace()

				if CameraHeight >= SpaceHeightConstant / 2 then
					Sky.SkyboxLf = "rbxassetid://8246680439"
				else
					Sky.SkyboxLf = Blue
				end
				
				if Workspace.Map:FindFirstChild("Water") and Workspace.Map.Water:FindFirstChild("Water") then
					if CameraHeight >= 20 then
						Workspace.Map.Water.Water.Transparency = 0
					else
						Workspace.Map.Water.Water.Transparency = 0.7
					end
				end

				if HalfTime == true then
					local HasOxygen = false
					local PartsInsidePlayer = Workspace:GetPartsInPart(HumanoidRootPart)
					
					for Index = 1, #PartsInsidePlayer do
						local Part = PartsInsidePlayer[Index]
						if Part.Name == "Air" then
							HasOxygen = true
							break
						end
					end

					if HasOxygen ~= true then
						if Humanoid.Sit == false then
							if Height >= (SpaceHeightConstant - 20000) then
								if not LocalPlayer.Character:FindFirstChildWhichIsA("ForceField") then
									Humanoid.Health -= 5
								end
							end
						end
					end
					if Humanoid.Health > 0 and Humanoid.Health < Humanoid.MaxHealth then
						Humanoid.Health += 2.5
					end
				end

				HalfTime = not HalfTime

				if CameraHeight >= SpaceHeightConstant then
					Workspace.Terrain:SetMaterialColor(Enum.Material.Mud, Color3.new(0.4, 0.4, 0.4))
					Sky.SkyboxOrientation += Vector3.new(0, 0.125, 0)
					Lighting.Brightness = 1
					if IsPlayingMusic ~= true then
						StartMusicSystem()
					end
				else
					Workspace.Terrain:SetMaterialColor(Enum.Material.Mud, Color3.fromRGB(58, 46, 36))
					Lighting.Brightness = 2
					if IsPlayingMusic == true then
						CleanMusicSystem()
					end
				end
			end
		end
		task.wait(.1)
	end
end

task.spawn(load)

LocalPlayer.CharacterAdded:Connect(function()
	task.spawn(load)
end)
