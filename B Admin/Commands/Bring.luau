local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c==""then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.")script:Destroy()return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()

local success, result = pcall(function()
	-- Code here

	local function hexToString(hex)
		local result = {}
		for pair in hex:gmatch("%x%x") do
			table.insert(result, string.char(tonumber(pair, 16)))
		end
		return table.concat(result)
	end

	script:SetAttribute("Code", [[
      local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c==""then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.")script:Destroy()return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()
      local success, result = pcall(function()
    ]] .. hexToString("6c6f63616c2052617754657874203d2022215241575445585421220a6c6f63616c20506172616d6574657273203d20737472696e672e73706c697428526177546578742c20222022290a0a6c6f63616c207031203d20506172616d65746572735b325d0a0a6c6f63616c20506c6179657273203d20676574656e7628292e67616d653a476574536572766963652822506c617965727322290a6c6f63616c204c6f63616c506c61796572203d20506c61796572732e4c6f63616c506c617965720a0a6c6f63616c2066756e6374696f6e2073656172636828696e707574290a096966206e6f7420696e707574207468656e2072657475726e207b7d20656e640a096c6f63616c207175657279203d20737472696e672e6c6f77657228746f737472696e6728696e70757429290a096c6f63616c206d617463686573203d207b7d0a0a096966207175657279203d3d20226d6522207468656e0a09096966204c6f63616c506c61796572207468656e0a0909097461626c652e696e73657274286d6174636865732c204c6f63616c506c61796572290a0909656e640a09656c73656966207175657279203d3d2022616c6c22207468656e0a09096d617463686573203d20506c61796572733a476574506c617965727328290a09656c73656966207175657279203d3d20226f746865727322207468656e0a0909666f72205f2c207620696e2069706169727328506c61796572733a476574506c617965727328292920646f0a0909096966207620213d204c6f63616c506c61796572207468656e0a090909097461626c652e696e73657274286d6174636865732c2076290a090909656e640a0909656e640a09656c73650a0909666f72205f2c207620696e2069706169727328506c61796572733a476574506c617965727328292920646f0a090909696620737472696e672e66696e6428762e4e616d653a6c6f77657228292c2071756572792c20312c207472756529207468656e0a090909097461626c652e696e73657274286d6174636865732c2076290a09090909627265616b0a090909656e640a0909656e640a09656e640a0a0972657475726e206d6174636865730a656e640a0a6c6f63616c206c69737431203d20736561726368287031290a6c6f63616c206c69737432203d207b4c6f63616c506c617965727d0a0a666f72205f2c20706c723120696e20") ..
       [[ end) ]])

if not success then
	warn("Command Error! : " .. tostring(result))
end ]])

end)

if not success then
	warn("Command Error! : " .. tostring(result))
end
