-- Recycling Processing Event
RegisterNetEvent('hrs_base_building:server:processRecycling', function(entity)
    local src = source
    local player = nil
    
    -- Get player based on framework
    if Config.Framework == "ESX" then
        player = ESX.GetPlayerFromId(src)
    elseif Config.Framework == "QB" then
        player = QBCore.Functions.GetPlayer(src)
    end
    
    if not player then return end
    
    -- Get player inventory
    local inventory = nil
    if Config.Framework == "ESX" then
        inventory = player.getInventory()
    elseif Config.Framework == "QB" then
        inventory = player.PlayerData.items
    end
    
    -- Define recyclable items and their rewards
    local recyclableItems = {
        ["metalscrap"] = {
            rewards = {
                {name = "iron", count = 1},
                {name = "steel", count = 1}
            }
        },
        ["wood"] = {
            rewards = {
                {name = "wood", count = 1},
                {name = "paper", count = 1}
            }
        },
        ["stone"] = {
            rewards = {
                {name = "stone", count = 1},
                {name = "sand", count = 1}
            }
        },
        ["plastic"] = {
            rewards = {
                {name = "plastic", count = 1},
                {name = "rubber", count = 1}
            }
        },
        ["glass"] = {
            rewards = {
                {name = "glass", count = 1},
                {name = "sand", count = 1}
            }
        },
        ["electronics"] = {
            rewards = {
                {name = "copper", count = 1},
                {name = "plastic", count = 1},
                {name = "glass", count = 1}
            }
        }
    }
    
    -- Process each item in inventory
    for _, item in pairs(inventory) do
        local itemName = item.name
        local itemCount = item.count or item.amount
        
        -- Check if item is recyclable
        if recyclableItems[itemName] and itemCount > 0 then
            -- Remove item from inventory
            if Config.Framework == "ESX" then
                player.removeInventoryItem(itemName, 1)
            elseif Config.Framework == "QB" then
                player.Functions.RemoveItem(itemName, 1)
            end
            
            -- Give rewards
            for _, reward in ipairs(recyclableItems[itemName].rewards) do
                if Config.Framework == "ESX" then
                    player.addInventoryItem(reward.name, reward.count)
                elseif Config.Framework == "QB" then
                    player.Functions.AddItem(reward.name, reward.count)
                end
            end
            
            -- Notify player
            if Config.Framework == "ESX" then
                TriggerClientEvent('esx:showNotification', src, 'Recycled 1x ' .. itemName)
            elseif Config.Framework == "QB" then
                TriggerClientEvent('QBCore:Notify', src, 'Recycled 1x ' .. itemName, 'success')
            end
        end
    end
end) 