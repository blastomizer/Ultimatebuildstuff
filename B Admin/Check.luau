local function CheckIfWhitelisted()
	local CurrentCode = script:GetAttribute("Code") or ""
	if CurrentCode == "" then
		return false
	end

	local Url = "https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json"
	local HttpService = game:GetService("HttpService")

	local Success, Result = pcall(function()
		return HttpService:GetAsync(Url)
	end)

	if Success and Result and Result.Success then
		local List = HttpService:JSONDecode(Result.Body)

		if game.Players.LocalPlayer.UserId == getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name) then
			return true
		else
			warn("Failed to pass security, TERMINATING!")
			script:SetAttribute("Code", "")
			return false
		end
	else
		warn("Security error! Retrying whitelist check.")
		task.wait(2)
		return CheckIfWhitelisted()
	end
end
