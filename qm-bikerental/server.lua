local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qm-bikerental:server:rentVehicle', function(source, cb, model, price, time, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return cb(false) end
    
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price, "bike-rental")
    elseif Player.PlayerData.money.bank >= price then
        Player.Functions.RemoveMoney('bank', price, "bike-rental")
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Messages.error.no_money, 'error')
        return cb(false)
    end
    
    -- Spawn vehicle using QBCore's function
    local vehicle = QBCore.Functions.SpawnVehicle(src, model, coords, true)
    if not vehicle then
        TriggerClientEvent('QBCore:Notify', src, 'Failed to spawn vehicle', 'error')
        return cb(false)
    end
    
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    cb(true, netId)
end)

QBCore.Functions.CreateCallback('qm-bikerental:server:returnVehicle', function(source, cb, price, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return cb(false) end
    
    local refund = math.floor(price * 0.5) -- 50% refund for early return
    Player.Functions.AddMoney('cash', refund, "bike-rental-refund")
    
    cb(true, refund)
end) 