local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c=="" then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,getfenv().game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.");return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
local ScriptValue = nil
if not getfenv().game.Lighting:FindFirstChild("B_aDMIN_CURSORHH") then
	ScriptValue = getfenv().Instance.new("ObjectValue")
	ScriptValue.Name = "B_aDMIN_CURSORHH"
	ScriptValue.Parent = getfenv().game.Lighting
else
	ScriptValue = getfenv().game.Lighting:FindFirstChild("B_aDMIN_CURSORHH")
end

local CommandSuccess, CommandResult = pcall(function()
	local PlayersService = getfenv().game:GetService("Players")
	local LocalPlayer = PlayersService.LocalPlayer
	local CursorScript = LocalPlayer.PlayerScripts:FindFirstChild("MouseCursorClient") or ScriptValue.Value

	if CursorScript and ScriptValue.Value ~= CursorScript then
		ScriptValue.Value = CursorScript
	end

	local RawText = "!RAWTEXT!"
	local Parameters = string.split(RawText, " ")
	local TargetParameter = Parameters

	local function SearchPlayers(InputData)
		if not InputData then return {} end
		local QueryString = string.lower(tostring(InputData))
		local MatchList = {}
		if QueryString == "me" then
			if LocalPlayer then
				table.insert(MatchList, LocalPlayer)
			end
		else
			for _, PlayerObject in ipairs(PlayersService:GetPlayers()) do
				if string.find(PlayerObject.Name:lower(), QueryString, 1, true) then
					table.insert(MatchList, PlayerObject)
					break
				end
			end
		end
		return MatchList
	end

	local TargetPlayers = SearchPlayers(TargetParameter)

	for _, TargetPlayer in ipairs(TargetPlayers) do
		if TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
			if TargetPlayer.Name ~= LocalPlayer.Name then
				print("Currently spectating " .. TargetPlayer.Name .. ". (Spectate yourself to exit; your cursor has been hidden)")
				if CursorScript then 
					CursorScript.Enabled = false
					CursorScript.Parent = getfenv().game.Lighting 
				end 
			else
				if CursorScript then 
					CursorScript.Parent = LocalPlayer.PlayerScripts 
					CursorScript.Enabled = true
				end
				warn("Cursor visible")
			end

			getfenv().workspace.CurrentCamera.CameraSubject = TargetPlayer.Character.Humanoid
		end
	end
end)
if not CommandSuccess then warn(tostring(CommandResult)) end
