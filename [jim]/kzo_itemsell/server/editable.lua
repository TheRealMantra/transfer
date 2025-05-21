QBCore = exports['qb-core']:GetCoreObject()

function AddMarkedBills(source, price)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local info = {
        worth = price
    }
    xPlayer.Functions.AddItem('markedbills', 1, false, info)
end
function AddMoneyIT(source, moneyType, price, reason)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney(moneyType, price, reason)
end
function RemoveItemIT(source, itemName, itemAmount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local xItem = xPlayer.Functions.GetItemByName(itemName)
    if xItem.amount >= itemAmount then
        xPlayer.Functions.RemoveItem(itemName, itemAmount)
    else
        for i = 1, itemAmount, 1 do
            xPlayer.Functions.RemoveItem(itemName, 1)
        end
    end
end
function GetItemAmount(source, itemName)
    local itemAmount = 0
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local xItem = xPlayer.Functions.GetItemsByName(itemName)
    if xItem and xItem[1] then
        for k, v in pairs(xItem) do
            if v.amount then
                itemAmount = itemAmount + v.amount
            end
        end
    end
    return itemAmount
end
function HasItemToSell(source, itemName, itemAmount)
    local hasItemAmount = 0
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local xItem = xPlayer.Functions.GetItemsByName(itemName)
    if xItem[1] then
        for k, v in pairs(xItem) do
            hasItemAmount = hasItemAmount + v.amount
        end
    end
    return hasItemAmount >= itemAmount
end
function TriggerNotify(source, msg, type)
    TriggerClientEvent("QBCore:Notify", source, msg, type)
end

function PriceUpdateNotify()
    TriggerClientEvent('chatMessage', -1, Config.ServerName, {254, 218, 36}, Config.PriceUpdateNotify)

    -- TriggerClientEvent("QBCore:Notify", -1, Config.PriceUpdateNotify) -- or use qb-notify
end

function Sendlogdiscord(source, totalprice, msg, category)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    sendlog(xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' | ' .. msg ..
                ' | Price: $' .. totalprice .. ' | Category: ' .. Config.Category[category].CategoryLabel, '57087')
end

function sendlog(message, color)
    local content = {{
        ["color"] = color,
        ["title"] = Config.ServerName,
        ["description"] = message,
        ["footer"] = {
            ["text"] = Config.ServerName
        }
    }}
    PerformHttpRequest(Config.LogWebhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = Config.ServerName,
        embeds = content
    }), {
        ['Content-Type'] = 'application/json'
    })
end
