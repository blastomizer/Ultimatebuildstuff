local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c==""then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.")script:Destroy()return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()

local success, result = pcall(function()
	local TeleportService = game:GetService("TeleportService")
	local LocalPlayer = getfenv().game:GetService("Players").LocalPlayer
	-- Code here
	local ScreenGui = Instance.new("ScreenGui")		
	ScreenGui.Name = "BadminTeleportGui"
	ScreenGui.Parent = LocalPlayer.PlayerGui

	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Name = "ImageLabel"
	ImageLabel.Visible = true
	ImageLabel.Position = UDim2.new(0,0,0,0)
	ImageLabel.Size = UDim2.new(1,0,1,0)

	ImageLabel.ImageColor3 = Color3.new(1,1,1)
	ImageLabel.Image = "rbxassetid://1038133768"
	ImageLabel.BorderColor3 = Color3.new(0,0,0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.BackgroundColor3 = Color3.new(0,0,0)
	ImageLabel.Parent = ScreenGui
	ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "TextLabel"
	TextLabel.Visible = true
	TextLabel.Position = UDim2.new(0.25,0,0.3745329976081848,0)
	TextLabel.Size = UDim2.new(0.5,0,0.25,0)

	TextLabel.TextWrapped = true
	TextLabel.TextColor3 = Color3.new(1,1,1)
	TextLabel.BorderColor3 = Color3.new(0,0,0)
	TextLabel.Text = "B Admin"
	TextLabel.Font = Enum.Font.SciFi
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14
	TextLabel.BorderSizePixel = 0
	TextLabel.BackgroundColor3 = Color3.new(1,1,1)
	TextLabel.Parent = ImageLabel

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "TextLabel"
	TextLabel.Visible = true
	TextLabel.Position = UDim2.new(0.2599693238735199,0,0.5902864336967468,0)
	TextLabel.Size = UDim2.new(0,637,0,27)

	TextLabel.TextWrapped = true
	TextLabel.TextColor3 = Color3.new(1,1,1)
	TextLabel.BorderColor3 = Color3.new(0,0,0)
	TextLabel.Text = "Thank you for using B Admin!"
	TextLabel.Font = Enum.Font.SciFi
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14
	TextLabel.BorderSizePixel = 0
	TextLabel.BackgroundColor3 = Color3.new(1,1,1)
	TextLabel.Parent = ImageLabel

	TeleportService:Teleport(getfenv().game.PlaceId, LocalPlayer, nil, ScreenGui)
end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
