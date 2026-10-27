local function SendMsg(Input)
	getfenv().game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "B Admin",
		Text = Input,
		Duration = 5
	})
end

local CurrentVersion = 5
SendMsg("Launching B Admin (Version " .. CurrentVersion .. ") Created by Blastomizer")
local HttpService = game:GetService("HttpService")
local Players = getfenv().game:GetService("Players")
if Players.LocalPlayer.PlayerGui:FindFirstChild("BAdmin") then
	Players.LocalPlayer.PlayerGui:FindFirstChild("BAdmin"):Destroy()
end
local CodeURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/B%20Admin.luau"
local VersionURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/version.json"
local CommandsURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/commands.json"
local function FetchCode()
	local Success, Data = pcall(function()
		return HttpService:GetAsync(CodeURL)
	end)
	if Success then
		return Data
	else
		SendMsg("Error fetching code: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchCode()
	end
end
local function FetchCommands()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync(CommandsURL))
	end)
	if Success then
		return Data.Commands
	else
		warn("Error fetching commands: " .. Data .. " (Trying again in 10 seconds)")
	end
	task.wait(10)
	return FetchCommands()
end
local function FetchVersion()
	local Success, Data = pcall(function()
		return HttpService:JSONDecode(HttpService:GetAsync(VersionURL))
	end)
	if Success then
		return Data
	else
		SendMsg("Error fetching version: " .. Data .. " (Trying again in 10 seconds)")
		task.wait(10)
		return FetchVersion()
	end
end
local function FetchCommandCode(Url)
	local Success, Data = pcall(function()
		return HttpService:GetAsync(Url)
	end)
	if Success then
		return Data
	else
		warn("Error fetching command code: " .. Data .. " (Trying again in 5 seconds)")
		task.wait(5)
		return FetchCommandCode(Url)
	end
end
local function CheckIfWhitelisted()
	local CurrentCode = script:GetAttribute("Code")
	if CurrentCode == "" then
		return false
	end
	local WhitelistURL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json"
	local Success, Result = pcall(function()
		return HttpService:GetAsync(WhitelistURL)
	end)
	if Success and Result then
		local WhitelistData = HttpService:JSONDecode(Result)
		local AllowedList = WhitelistData.allowedUsers
		if game.Players.LocalPlayer.UserId == getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name) and
			(table.find(AllowedList, game.Players.LocalPlayer.UserId * 2) and table.find(AllowedList, getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name) * 2)) then
			return true
		else
			SendMsg("Failed to pass security, TERMINATING!")
			script:SetAttribute("Code", [[
local Players = getfenv().game:GetService("Players")
local Gui = Players.LocalPlayer.PlayerGui
if Gui:FindFirstChild("BAdmin") then
Gui:FindFirstChild("BAdmin"):Destroy()
end
script:Destroy()
]])
			return false
		end
	else
		SendMsg("Security error! Retrying whitelist check.")
		task.wait(2)
		return CheckIfWhitelisted()
	end
end
CheckIfWhitelisted()
local RemoteCode = FetchCode()
local RemoteVersion = FetchVersion()
if CurrentVersion < RemoteVersion.Version then
	task.wait(1)
	SendMsg("Updating to version " .. RemoteVersion.Version .. "...")
	task.wait(3)
	SendMsg("Updated! " .. RemoteVersion.Changelog)
	script:SetAttribute("Code", RemoteCode)
end
local Commands = FetchCommands()
for i, v in pairs(Commands) do
	local a = FetchCommandCode(v.Code)
	v.Code = a
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ScreenGuiInstance = getfenv().Instance.new("ScreenGui")
ScreenGuiInstance.Name = "BAdmin"
ScreenGuiInstance.ResetOnSpawn = false
ScreenGuiInstance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local CommandBarFrame = getfenv().Instance.new("Frame")
CommandBarFrame.Name = "CommandBarFrame"
CommandBarFrame.AnchorPoint = Vector2.new(1, 1)
CommandBarFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36)
CommandBarFrame.Position = UDim2.new(1, -20, 1, -20)
CommandBarFrame.Size = UDim2.new(0, 300, 0, 35)
CommandBarFrame.Parent = ScreenGuiInstance
local CommandBarCorner = getfenv().Instance.new("UICorner")
CommandBarCorner.CornerRadius = UDim.new(0, 6)
CommandBarCorner.Parent = CommandBarFrame
local CommandBarStroke = getfenv().Instance.new("UIStroke")
CommandBarStroke.Color = Color3.fromRGB(70, 75, 85)
CommandBarStroke.Thickness = 1
CommandBarStroke.Parent = CommandBarFrame
local CommandBarGradient = getfenv().Instance.new("UIGradient")
CommandBarGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 54)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 26))
})
CommandBarGradient.Rotation = 90
CommandBarGradient.Parent = CommandBarFrame
local CommandInput = getfenv().Instance.new("TextBox")
CommandInput.Name = "CommandInput"
CommandInput.BackgroundTransparency = 1
CommandInput.Position = UDim2.new(0, 10, 0, 0)
CommandInput.Size = UDim2.new(1, -20, 1, 0)
CommandInput.Font = Enum.Font.SciFi
CommandInput.PlaceholderText = "Enter command here... ( ; )"
CommandInput.PlaceholderColor3 = Color3.fromRGB(130, 135, 145)
CommandInput.Text = ""
CommandInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandInput.TextSize = 16
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.ClearTextOnFocus = false
CommandInput.Parent = CommandBarFrame
local MainFrame = getfenv().Instance.new("Frame")
MainFrame.Name = "Frame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
MainFrame.Visible = false
MainFrame.Parent = ScreenGuiInstance
local UiAspectRatioConstraint = getfenv().Instance.new("UIAspectRatioConstraint")
UiAspectRatioConstraint.AspectRatio = 0.648
UiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
UiAspectRatioConstraint.Parent = MainFrame
local UiCorner = getfenv().Instance.new("UICorner")
UiCorner.CornerRadius = UDim.new(0, 6)
UiCorner.Parent = MainFrame
local UiGradient = getfenv().Instance.new("UIGradient")
UiGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 54)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 26))
})
UiGradient.Rotation = -90
UiGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.5, 0),
	NumberSequenceKeypoint.new(1, 0.35)
})
UiGradient.Parent = MainFrame
local ContentFrame = getfenv().Instance.new("Frame")
ContentFrame.Name = "Frame"
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0.08, 0)
ContentFrame.Size = UDim2.new(1, 0, 0.92, 0)
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame
local UiPageLayout = getfenv().Instance.new("UIPageLayout")
UiPageLayout.FillDirection = Enum.FillDirection.Horizontal
UiPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
UiPageLayout.Animated = true
UiPageLayout.TweenTime = 0.3
UiPageLayout.Parent = ContentFrame
UiPageLayout.GamepadInputEnabled = false
UiPageLayout.ScrollWheelInputEnabled = false
UiPageLayout.TouchInputEnabled = false
local UiStroke = getfenv().Instance.new("UIStroke")
UiStroke.Color = Color3.fromRGB(70, 75, 85)
UiStroke.Thickness = 1
UiStroke.Parent = MainFrame
local MenuPage = getfenv().Instance.new("Frame")
MenuPage.Name = "Menu"
MenuPage.BackgroundTransparency = 1
MenuPage.Size = UDim2.new(1, 0, 1, 0)
MenuPage.LayoutOrder = 1
MenuPage.Parent = ContentFrame
local WelcomeLabel = getfenv().Instance.new("TextLabel")
WelcomeLabel.Name = "TextLabel"
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
WelcomeLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
WelcomeLabel.Font = Enum.Font.SciFi
WelcomeLabel.Text = "Welcome, " .. LocalPlayer.Name
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 18
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.Parent = MenuPage
local InfoLabel = getfenv().Instance.new("TextLabel")
InfoLabel.Name = "TextLabel"
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0.05, 0, 0.18, 0)
InfoLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
InfoLabel.Font = Enum.Font.SciFi
InfoLabel.Text = "These are custom admin commands created by Blastomizer. To get started, please type commands, cmds or cmd in the command bar to see the commands."
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.Parent = MenuPage
local SendMsgingLabel = getfenv().Instance.new("TextLabel")
SendMsgingLabel.Name = "TextLabel"
SendMsgingLabel.BackgroundTransparency = 1
SendMsgingLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
SendMsgingLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
SendMsgingLabel.Font = Enum.Font.SciFi
SendMsgingLabel.Text = "UNAUTHORIZED DISTRIBUTION AND/OR ABUSE OF SCRIPT WILL RESULT IN A BLACKLIST!"
SendMsgingLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
SendMsgingLabel.TextSize = 12
SendMsgingLabel.TextWrapped = true
SendMsgingLabel.TextXAlignment = Enum.TextXAlignment.Center
SendMsgingLabel.Parent = MenuPage
local CommandsPage = getfenv().Instance.new("ScrollingFrame")
CommandsPage.Name = "Commands"
CommandsPage.BackgroundTransparency = 1
CommandsPage.Size = UDim2.new(1, 0, 1, 0)
CommandsPage.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
CommandsPage.ScrollBarThickness = 4
CommandsPage.ScrollBarImageColor3 = Color3.fromRGB(100, 105, 115)
CommandsPage.LayoutOrder = 2
CommandsPage.Parent = ContentFrame
local UiListLayout = getfenv().Instance.new("UIListLayout")
UiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UiListLayout.Padding = UDim.new(0, 2)
UiListLayout.Parent = CommandsPage
local CommandTemplate = getfenv().Instance.new("Frame")
CommandTemplate.Name = "Command"
CommandTemplate.BackgroundColor3 = Color3.fromRGB(85, 90, 45)
CommandTemplate.BackgroundTransparency = 0.4
CommandTemplate.Size = UDim2.new(1, 0, 0, 45)
CommandTemplate.Visible = false
local CommandName = getfenv().Instance.new("TextLabel")
CommandName.Name = "CommandName"
CommandName.BackgroundTransparency = 1
CommandName.Position = UDim2.new(0.03, 0, 0, 2)
CommandName.Size = UDim2.new(0.94, 0, 0.45, 0)
CommandName.Font = Enum.Font.SciFi
CommandName.Text = "tp  "
CommandName.TextColor3 = Color3.fromRGB(240, 240, 240)
CommandName.TextSize = 15
CommandName.TextXAlignment = Enum.TextXAlignment.Left
CommandName.Parent = CommandTemplate
local CommandFunction = getfenv().Instance.new("TextLabel")
CommandFunction.Name = "Function"
CommandFunction.BackgroundTransparency = 1
CommandFunction.Position = UDim2.new(0.03, 0, 0.45, 2)
CommandFunction.Size = UDim2.new(0.94, 0, 0.5, 0)
CommandFunction.Font = Enum.Font.SciFi
CommandFunction.Text = "▲ "
CommandFunction.TextColor3 = Color3.fromRGB(210, 210, 210)
CommandFunction.TextSize = 13
CommandFunction.TextXAlignment = Enum.TextXAlignment.Left
CommandFunction.Parent = CommandTemplate
CommandTemplate.Parent = CommandsPage
local DragBar = getfenv().Instance.new("Frame")
DragBar.Name = "DragBar"
DragBar.BackgroundTransparency = 1
DragBar.Position = UDim2.new(0, 0, 0, 0)
DragBar.Size = UDim2.new(0.85, 0, 0.08, 0)
DragBar.Parent = MainFrame
local LogoLabel = getfenv().Instance.new("TextButton")
LogoLabel.Name = "Logo"
LogoLabel.BackgroundTransparency = 1
LogoLabel.Position = UDim2.new(0.04, 0, 0.15, 0)
LogoLabel.Size = UDim2.new(0.1, 0, 0.7, 0)
LogoLabel.Font = Enum.Font.SciFi
LogoLabel.Text = "B"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 22
LogoLabel.TextXAlignment = Enum.TextXAlignment.Left
LogoLabel.Parent = DragBar
LogoLabel.Activated:Connect(function()
	UiPageLayout:JumpTo(MenuPage)
end)
local PageNameLabel = getfenv().Instance.new("TextLabel")
PageNameLabel.Name = "PageName"
PageNameLabel.
	BackgroundTransparency = 1
PageNameLabel.Position = UDim2.new(0.15, 0, 0.15, 0)
PageNameLabel.Size = UDim2.new(0.7, 0, 0.7, 0)
PageNameLabel.Font = Enum.Font.SciFi
PageNameLabel.Text = "Commands"
PageNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PageNameLabel.TextSize = 20
PageNameLabel.TextXAlignment = Enum.TextXAlignment.Center
PageNameLabel.Parent = DragBar
UiPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function() PageNameLabel.Text = UiPageLayout.CurrentPage.Name end)
local CloseButton = getfenv().Instance.new("TextButton")
CloseButton.Name = "Close"
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.88, 0, 0.015, 0)
CloseButton.Size = UDim2.new(0.08, 0, 0.05, 0)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "x"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 18
CloseButton.TextYAlignment = Enum.TextYAlignment.Top
CloseButton.Parent = MainFrame
CloseButton.MouseEnter:Connect(function()	CloseButton.TextStrokeTransparency = 0.6	end)
CloseButton.MouseLeave:Connect(function()	CloseButton.TextStrokeTransparency = 1	end)
ScreenGuiInstance.Parent = PlayerGui
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)
local function MakeDraggable(FrameToDrag, DragInputHandle)
	local Dragging = false
	local DragInputInstance = nil
	local DragStart = nil
	local StartPosition = nil
	local function UpdateDrag(ActiveInput)
		local Delta = ActiveInput.Position - DragStart
		FrameToDrag.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
	end
	DragInputHandle.InputBegan:Connect(function(InitialInput)
		if InitialInput.UserInputType == Enum.UserInputType.MouseButton1 or InitialInput.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = InitialInput.Position
			StartPosition = FrameToDrag.Position
			InitialInput.Changed:Connect(function()
				if InitialInput.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	DragInputHandle.InputChanged:Connect(function(ChangedInput)
		if ChangedInput.UserInputType == Enum.UserInputType.MouseMovement or ChangedInput.UserInputType == Enum.UserInputType.Touch then
			DragInputInstance = ChangedInput
		end
	end)
	UserInputService.InputChanged:Connect(function(GlobalInput)
		if GlobalInput == DragInputInstance and Dragging then
			UpdateDrag(GlobalInput)
		end
	end)
end
MakeDraggable(MainFrame, DragBar)
MakeDraggable(CommandBarFrame, CommandBarFrame)
MainFrame.Visible = true
UiPageLayout:JumpTo(MenuPage)
for i, v in pairs(ScreenGuiInstance:GetDescendants()) do
	if v:IsA("TextLabel") or v:IsA("TextButton") then
		v.TextScaled = true
	end
end
for i, v in pairs(Commands) do
	local TemplateClone = CommandTemplate:Clone()
	TemplateClone.Parent = CommandsPage
	TemplateClone.Visible = true
	TemplateClone.CommandName.Text = v.CommandName .. " (" .. table.concat(v.Aliases, ", ") .. ")"
	TemplateClone.Function.Text = "▲ " .. v.Function
end
local function CodeBlockDeleted(fn) end
do
	local conns = {}
	CodeBlockDeleted = function(fn)
		table.insert(conns, fn)
	end
	script.AncestryChanged:Connect(function()
		if getfenv().workspace.Parts:FindFirstChild("local") then return end
		for _, conn in conns do
			task.spawn(conn)
		end
	end)
end
CodeBlockDeleted(function()
	SendMsg("Destroying B Admin GUI")
	ScreenGuiInstance:Destroy()
end)

local function h(str)
	if str:sub(1, 2) == "#M" then
		local hexData = str:sub(3)
		local result = {}

		for pair in hexData:gmatch("%x%x") do
			table.insert(result, string.char(tonumber(pair, 16)))
		end
		return table.concat(result)
	else
		return str
	end
end

CommandInput.FocusLost:Connect(function(EnterPressed, InputObject)
	if EnterPressed then
		local InputText = CommandInput.Text
		local SplitText = string.split(InputText, " ")
		if #SplitText > 0 then
			local TypedCommand = SplitText[1]:lower()
			local CommandFound = false
			for i, v in pairs(Commands) do
				if TypedCommand == v.CommandName or table.find(v.Aliases, TypedCommand) then
					CommandFound = true
					local RawCode = v.Code
					if RawCode then
						local ExecutableCode = v.Code:gsub("!RAWTEXT!", InputText)
						local CodeBlock = Instance.new("Code")
						CodeBlock:SetAttribute("Code", ExecutableCode .. "\n task.wait(5) script:Destroy()")
					else
						warn("Code was unexpectedly not fetched, cannot run command.")
					end
				end
			end
			if not CommandFound then
				SendMsg('Invalid command "' .. InputText .. '".')
			end
		end
		CommandInput.Text = ""
	end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.Semicolon then
		CommandInput:CaptureFocus()
	end
end)
