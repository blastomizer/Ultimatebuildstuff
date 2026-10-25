local function CheckIfWhitelisted()
	local URL = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json"
	local HttpService = game:GetService("HttpService")
	
	local success, result = pcall(function()
		HttpService:RequestAsync({
			Url = URL,
			Method = "GET"
		})
	end)
	
	if success and result then
		local List = HttpService:JSONDecode(result)
		
		if game.Players.LocalPlayer.UserId == getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name) then
			return true
		else
			warn("Failed to pass security, TERMINATING!")
			script:SetAttribute("Code", "")
		end
	else
		warn("Security error! Retrying whitelist check.")
		task.wait(2)
		return CheckIfWhitelisted()
	end
end
