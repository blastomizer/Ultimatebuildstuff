local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
local success, result = pcall(function()
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
	local p2 = Parameters[3]
	--print(1)
	local Players = getfenv().game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local function search(input)
		--print(2)
		if not input then return {} end
		local query = string.lower(tostring(input))
		local matches = {}
		if query == "me" then
			if LocalPlayer then
				--warn("me")
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
	--print("choseplayer")
	local list1 = search(p1)
	local list2 = search(p2)
	for _, plr1 in ipairs(list1) do
		for _, plr2 in ipairs(list2) do
			if plr1 and plr2 and plr1.Character:FindFirstChild("HumanoidRootPart") and plr2.Character:FindFirstChild("HumanoidRootPart") then
				task.spawn(function()
					--print("gotposition")
					local plr1CFrame = plr1.Character:GetPivot()
					local Seat = Instance.new("Seat")
					task.wait(0.1)
					Seat.Transparency = 1
					Seat.Size = Vector3.new(5, 0.5, 5)
					Seat.Anchored = true
					task.wait(0.1)
					Seat.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position
					task.wait(0.25)
					--print("teleported")
					local plr2CFrame = plr2.Character:GetPivot()
					Seat.CFrame = plr2CFrame
					task.wait()
					Seat:Destroy()
					--print("seatbroke")
				end)
			end
		end
	end
end)
if not success then warn(tostring(result)) end
