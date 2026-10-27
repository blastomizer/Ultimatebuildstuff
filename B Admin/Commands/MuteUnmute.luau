local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
local success, result = pcall(function()
	local h = getfenv().game:GetService("Players").LocalPlayer.PlayerScripts.MouseCursorClient
	
	local Players = getfenv().game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local command = Parameters[1]
	local p1 = Parameters[2]
	
	local function search(input)
		if not input then return {} end
		local query = string.lower(tostring(input))
		local matches = {}
		if query == "all" or query == "others" then
			for _, v in ipairs(Players:GetPlayers()) do
				if query == "all" or v.Name ~= LocalPlayer.Name then
					table.insert(matches, v)
				end
			end
		elseif query ~= "disowned" then
			for _, v in ipairs(Players:GetPlayers()) do
				if string.find(v.Name:lower(), query, 1, true) then
					table.insert(matches, v)
					break
				end
			end
		end
		return matches
	end

	local list1 = search(p1)
	local p1String = type(p1) == "string" and p1:lower() or ""
	local isDisowned = p1String == "disowned"

	if isDisowned or #list1 > 0 then
		for i, v in pairs(getfenv().workspace.Parts:GetChildren()) do
			if v:IsA("BasePart") and v.Name == "Soundblock" then
				local owner = v:GetAttribute("Owner")
				local shouldProcess = false

				if isDisowned then
					shouldProcess = owner == 180062
				else
					for _, plr1 in ipairs(list1) do
						if owner == plr1.UserId or (owner == 180062 and (p1String == "all" or p1String == "others")) then
							shouldProcess = true
							break
						end
					end
				end

				if shouldProcess then
					if command:lower() == "mute" then
						if not v.Sound:FindFirstChild("B_ADMIN_SOUNDBLOCK_MUTE") then
							local mute = getfenv().Instance.new("EqualizerSoundEffect")
							mute.Name = "B_ADMIN_SOUNDBLOCK_MUTE"
							mute.Parent = v.Sound
							mute.HighGain = -80
							mute.MidGain = -80
							mute.LowGain = -80
						end
					elseif command:lower() == "unmute" then
						if v.Sound:FindFirstChild("B_ADMIN_SOUNDBLOCK_MUTE") then
							v.Sound.B_ADMIN_SOUNDBLOCK_MUTE:Destroy()
						end
					end
				end
			end
		end
	end
end)

if not success then 
	warn(tostring(result)) 
end
