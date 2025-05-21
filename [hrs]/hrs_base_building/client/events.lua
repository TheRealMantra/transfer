-- Recycling Machine Event Handler
RegisterNetEvent('hrs_base_building:recycleItem', function(entity)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local entityCoords = GetEntityCoords(entity)
    
    -- Check if player is close enough to the recycling machine
    if #(playerCoords - entityCoords) > 3.0 then
        return
    end
    
    -- Open inventory to select items to recycle
    if Config.Framework == "ESX" then
        TriggerEvent('esx_inventoryhud:openInventory')
    elseif Config.Framework == "QB" then
        TriggerEvent('inventory:client:OpenInventory')
    end
    
    -- Play recycling animation
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
    
    -- Progress bar for recycling
    if Config.UseProgressBar then
        if Config.ProgressBars["prop_repair"] then
            local progressBar = Config.ProgressBars["prop_repair"]
            
            if progressBar.animation then
                if progressBar.animation.task then
                    TaskStartScenarioInPlace(playerPed, progressBar.animation.task, 0, true)
                elseif progressBar.animation.animDict and progressBar.animation.anim then
                    RequestAnimDict(progressBar.animation.animDict)
                    while not HasAnimDictLoaded(progressBar.animation.animDict) do
                        Wait(10)
                    end
                    
                    TaskPlayAnim(playerPed, progressBar.animation.animDict, progressBar.animation.anim, 8.0, -8.0, -1, progressBar.animation.flag or 1, 0, false, false, false)
                end
            end
            
            -- Wait for progress bar to complete
            Wait(progressBar.duration)
            
            -- Clear animation
            ClearPedTasks(playerPed)
        end
    end
    
    -- Trigger server event to process recycling
    TriggerServerEvent('hrs_base_building:server:processRecycling', entity)
end) 