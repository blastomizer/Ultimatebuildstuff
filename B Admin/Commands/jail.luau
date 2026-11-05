local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
local success, result = pcall(function()
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
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
		elseif query == "random" then
			
			local randomPlr = math.random(1, #Players:GetPlayers())
			
			if randomPlr then
				for VNum, v in ipairs(Players:GetPlayers()) do
					if VNum == randomPlr then
						table.insert(matches, v)
					end
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
	--print("choseplayer".. " was trapped muahhahaha)
	local list1 = search(p1)
	local list2 = {LocalPlayer}
	for _, plr1 in ipairs(list1) do
			if plr1 and plr1.Character:FindFirstChild("HumanoidRootPart") then
				task.spawn(function()
				
					local plr1CFrame = plr1.Character:GetPivot()
					local Base = Instance.new("Part")
					local Celling = Instance.new("Part")
					local WallFront = Instance.new("Part")
					local WallLeft = Instance.new("Part")
					local WallRight = Instance.new("Part")
					local WallBack = Instance.new("Part")
					
					Base.Size = Vector3.new(5.5, 1, 5.5)
					Celling.Size = Vector3.new(5.5,1,5.5)
					Celling.Material = "SmoothPlastic"
					Base.Material = "SmoothPlastic"
					Base.Color = Color3.fromRGB(50,50,50)
					Celling.Color = Color3.fromRGB(50,50,50)
					WallFront.Size = Vector3.new(1,6.5,5)
					WallFront.Transparency = 0.5
					WallFront.Reflectance = 0.5
					WallBack.Size = Vector3.new(1,6.5,5)
					WallBack.Transparency = 0.5
					WallBack.Reflectance = 0.5
					WallLeft.Size = Vector3.new(5,6.5,1)
					WallLeft.Transparency = 0.5
					WallLeft.Reflectance = 0.5
					WallRight.Size = Vector3.new(5,6.5,1)
					WallRight.Transparency = 0.5
					WallRight.Reflectance = 0.5
													
				
					Base.Anchored = true
					Celling.Anchored = true
					WallFront.Anchored = true
				    WallBack.Anchored = true
					WallLeft.Anchored = true
				    WallRight.Anchored = true
					task.wait(0.1)
					Base.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,-3,0)
					Celling.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,4.5,0)
					WallFront.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,10,2.5)
					WallBack.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(0,1,-2.5)
					WallLeft.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(-2.5,1,0)
					WallRight.Position = plr1.Character:FindFirstChild("HumanoidRootPart").Position + Vector3.new(2.5,1,0)

					task.wait(0.25)
						
			end)
		end
	end
end)
if not success then warn(tostring(result)) end
