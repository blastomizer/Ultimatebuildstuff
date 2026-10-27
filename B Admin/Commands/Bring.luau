local success, result = pcall(function()
	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local p1 = Parameters[2]
	
	-- Stop if no target argument was provided
	if not p1 then return end

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
			local char1 = plr1 and plr1.Character
			local char2 = plr2 and plr2.Character
			if char1 and char1:FindFirstChild("HumanoidRootPart") and char2 and char2:FindFirstChild("HumanoidRootPart") then
				task.spawn(function()
					local Seat = Instance.new("Seat")
					Seat.Transparency = 1
					Seat.Anchored = true
					Seat.Position = char1.HumanoidRootPart.Position
					task.wait(0.5)
					Seat.CFrame = char2:GetPivot()
					task.wait(0.5)
					Seat:Destroy()
				end)
			end
		end
	end
end)

if not success then warn(tostring(result)) end
