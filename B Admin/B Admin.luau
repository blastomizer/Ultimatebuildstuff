local CurrentVersion = 1

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
