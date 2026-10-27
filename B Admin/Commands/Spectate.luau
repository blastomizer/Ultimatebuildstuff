local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
local success, result = pcall(function()
	local h = getfenv().game:GetService("Players").LocalPlayer.PlayerScripts.MouseCursorClient
	local backup = h:Clone()

	local Players = getfenv().game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
	local function search(input)
		if not input then return {} end
		local query = string.lower(tostring(input))
		local matches = {}
		if query == "me" then
			if LocalPlayer then
				table.insert(matches, LocalPlayer)
			end
		else
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

	for _, plr1 in ipairs(list1) do
		if plr1.Character and plr1.Character:FindFirstChild("Humanoid") then
			if plr1.Name ~= LocalPlayer.Name then
				print("Currently spectating " .. plr1.Name .. ". (Spectate yourself to exit; your cursor has been hidden)")
				if h then h:Destroy() end
			else
				if h then else backup.Parent = LocalPlayer.PlayerScripts h = backup end
				warn("Cursor visible")
			end

			getfenv().workspace.CurrentCamera.CameraSubject = plr1.Character.Humanoid
		end
	end
end)
if not success then warn(tostring(result)) end
