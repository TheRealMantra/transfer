local webhooks = {
    ['raid'] = {
        name = 'Raid Situation',
        url = 'Your_Webhook_Here',
        type = 'player',
        color = 65280
    },
    ['raid_status_true'] = {
        name = 'Raid Status',
        url = 'Your_Webhook_Here',
        color = 65280
    },
    ['raid_status_false'] = {
        name = 'Raid Status',
        url = 'Your_Webhook_Here',
        color = 16711680
    },
    ['raid_notify'] = {
        name = 'Raid Notify',
        url = 'Your_Webhook_Here',
        color = 16711680
    },
    ['prop_info'] = {
        name = 'Get Prop Info',
        url = 'Your_Webhook_Here',
        color = 65280,
        type = 'player'
    },
}

----- Logs Code -----
function GetIdentInfo(source)
    local num = GetNumPlayerIdentifiers(source)
    local text = 'Known Identifiers:\n'
    for i = 0, num - 2 do
        --print(GetPlayerIdentifier(source,i))
       text = text .. GetPlayerIdentifier(source,i) .. '\n'
    end
    return text
end

function sendToDiscord(index,source,text)
    local web = webhooks[index]
    local title = 'LOG'
    local footer = nil

    if web.type == 'player' then
        if not text then
            text = GetIdentInfo(source)
        else
            footer = {["text"] = GetIdentInfo(source)}
        end
        title = "**".. GetPlayerName(source) ..", ID: "..source.."**"
    end
    
    local embed = {
        {
            ["color"] = web.color,
            ["title"] = title,
            ["description"] = text,
           -- ["fields"] = text,
            ["footer"] = footer,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
  
    PerformHttpRequest(web.url, function(err, text, headers) end, 'POST', json.encode({username = web.name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('hrs_base_building:log',function(index,source,text)
    sendToDiscord(index,source,text)
end)

---------------------------------------------- IN DEVELOPMENT ------------------------------------------------------------------------------------------
local bots = {
    ["dms"] = {
        token = "YOUR_BOT_TOKEN",
        serverGuild = "YOUR_SERVER_GUILD" --- NOT IMPLEMENTED YET
    }
}

local dmCache = {}
if Config.raidNotificationDiscordDm then
    CreateThread(function()
        while true do
            if dmCache[1] then
                sendDmFinal(dmCache[1].botName,dmCache[1].discordId,dmCache[1].message)
                table.remove(dmCache, 1)
            end
            Wait(1500)
        end
    end)
end

function sendDm(botName,discordId,message)
  --  debug(botName,discordId)
    table.insert(dmCache, {botName = botName, discordId = discordId, message = message})
end

function sendDmFinal(botName,discordId,message)
    local botToken = bots[botName].token

    PerformHttpRequest("https://discord.com/api/v10/users/@me/channels", function(statusCode, response, headers)
        if statusCode == 200 then
            local responseData = json.decode(response)
            local channelID = responseData.id
            PerformHttpRequest("https://discord.com/api/v10/channels/" .. channelID .. "/messages", function(statusCode2, response2, headers2)
                if statusCode2 == 200 then
                    print("Message sent successfully!")
                else
                    print("Failed to send message: " .. statusCode2)
                end
            end, "POST", json.encode({content = message}), {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bot " .. botToken
            })
        else
            print("Failed to create DM channel: " .. statusCode)
        end
    end, "POST", json.encode({recipient_id = discordId}), {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bot " .. botToken
    })
end