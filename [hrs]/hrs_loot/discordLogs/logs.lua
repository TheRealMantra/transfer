local webhooks = {
    ['loot'] = {
        name = 'Player Loot',
        url = 'Your_Webhook_Here',
        type = 'player',
        color = 65280
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

AddEventHandler('hrs_loot:log',function(index,source,text)
    sendToDiscord(index,source,text)
end)