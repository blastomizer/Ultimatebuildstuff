local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wairs(2)return a()end end;a()
local success, result = pcall(function()
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
	local Players = getfenv().game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local function search(input)
		if not input then return {} end
		local query = string.lower(tostring(input))
		local matches = {}
		if query == "me" then
			if LocalPlayer then
				table.insert(matches, LocalPlayer)
			end
		elseif query == "all" then
			matches = Players:GetPlayers()
		elseif query == "others" then
			for _, v in ipairs(Players:GetPlayers()) do
				if v ~= LocalPlayer then
					table.insert(matches, v)
				end
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
	local list2 = {LocalPlayer}
	for _, plr1 in ipairs(list1) do
		for _, plr2 in ipairs(list2) do
			if plr1 and plr2 and plr1.Character:FindFirstChild("HumanoidRootPart") and plr1.Character:FindFirstChild("HumanoidRootPart") then
				task.spawn(function()
					local pr1CFrame = plr1.Character:GetPivot()
					local Seat = Instance.new("Seat")
					Seat.Size = Vector3.new(2, 0.5, 2)
					Seat.Transparency = 1
					Seat.Anchored = true
					Seat.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position
					Seat.Parent = workspace
					task.wait(0.5)
					local pr2CFrame = plr2.Character:GetPlvot()
					Seat.CFrame = pr2CFrame
					task.wait(.1)
					Seat:Destroy()
				end)
			end
		end
	end
end)
