local function a()local b=game:GetService("HttpService")local c=script:GetAttribute("Code")if c==""then return false end;local c="https://raw.githubusercontent.com/blastomizer/Ultimatebuildstuff/refs/heads/main/B%20Admin/Whitelist.json";local c,d=pcall(function()return b:GetAsync(c)end)if c and d then local a=b:JSONDecode(d)local a=a.allowedUsers;if getfenv().game.Players.LocalPlayer.UserId==getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)and(table.find(a,game.Players.LocalPlayer.UserId*2)and table.find(a,getfenv().game.Players:GetUserIdFromNameAsync(game.Players.LocalPlayer.Name)*2))then return true else getfenv().game.Players.LocalPlayer:Kick("Unwhitelisted client tried to run command.")script:Destroy()return false end else warn("Security error! Retrying whitelist check.")task.wait(2)return a()end end;a()

local success, result = pcall(function()
local function hexToString(hex)
local result = {}
for pair in hex:gmatch("%x%x") do
table.insert(result, string.char(tonumber(pair, 16)))
end
return table.concat(result)
end

local setupCode = hexToString(
	"6c6f63616c2052617754657874203d2022215241575445585421220a" ..
	"6c6f63616c20506172616d6574657273203d20737472696e672e73706c697428526177546578742c20222022290a" ..
	"6c6f63616c207031203d20506172616d65746572735b325d0a" ..
	"6c6f63616c207032203d20506172616d65746572735b335d0a" ..
	"6c6f63616c20506172616d6574657273203d20676574656e7628292e67616d653a476574536572766963652822506c617965727322290a" ..
	"6c6f63616c204c6f63616c506c61796572203d20506172616d65746572732e4c6f63616c506c617965720a" ..
	"6c6f63616c2066756e6374696f6e2073656172636828696e707574290a" ..
	"6966206e6f7420696e707574207468656e2072657475726e207b7d20656e640a" ..
	"6c6f63616c207175657279203d20737472696e672e6c6f77657228746f737472696e6728696e70757429290a" ..
	"6c6f63616c206d617463686573203d207b7d0a" ..
	"6966207175657279203d3d20226d6522207468656e0a" ..
	"6966204c6f63616c506c61796572207468656e207461626c652e696e73657274286d6174636865732c204c6f63616c506c617965722920656e640a" ..
	"656c73656966207175657279203d3d2022616c6c22207468656e0a" ..
	"6d617463686573203d20506172616d65746572733a476574506c617965727328290a" ..
	"656c73656966207175657279203d3d20226f746865727322207468656e0a" ..
	"666f72205f2c207620696e2069706169727328506172616d65746572733a476574506c617965727328292920646f0a" ..
	"6966207620213d204c6f63616c506c61796572207468656e207461626c652e696e73657274286d6174636865732c20762920656e640a" ..
	"656e640a" ..
	"656c73650a" ..
	"666f72205f2c207620696e2069706169727328506172616d65746572733a476574506c617965727328292920646f0a" ..
	"696620737472696e672e66696e6428762e4e616d653a6c6f77657228292c2071756572792c20312c207472756529207468656e0a" ..
	"7461626c652e696e73657274286d6174636865732c2076290a" ..
	"627265616b0a" ..
	"656e640a" ..
	"656e640a" ..
	"72657475726e206d61746368657320656e640a" ..
	"6c6f63616c206c69737431203d20736561726368287031290a" ..
	"6c6f63616c206c69737432203d2073656172636828703229"
)

script:SetAttribute("Code", [[
	local success, result = pcall(function()
]] .. setupCode .. [[
		
		-- Teleports p1 to p2
		for _, plr1 in ipairs(list1) do
			for _, plr2 in ipairs(list2) do
				if plr1 and plr2 and plr1.Character and plr2.Character then
					if plr1.Character:FindFirstChild("HumanoidRootPart") and plr2.Character:FindFirstChild("HumanoidRootPart") then
						plr1.Character.HumanoidRootPart.CFrame = plr2.Character.HumanoidRootPart.CFrame
					end
				end
			end
		end
		
	end)
]])


end)

if not success then
warn("Command Error! : " .. tostring(result))
end
