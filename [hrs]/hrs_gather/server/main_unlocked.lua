if Config.Framework == "ESX" then


    ESX = exports["es_extended"]:getSharedObject()

--[[     ESX = nil  
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) ]]

    function addItems(source,type)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = getItemsList(type)
        local carry = true
        
        for item,count in pairs(items) do
            if xPlayer.canCarryItem(item,count) then 
                xPlayer.addInventoryItem(item,count)
                
            else
                carry = false
            end
        end

        if not carry then
            xPlayer.showNotification("You can't carry all the items") 
        end
    end

    function canGather(source,count,max)
        local bool = false
        
        if count < max then
            bool = true
        else
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.showNotification("~r~You can't gather anymore from here")
        end
        
        return bool
    end

    function UseItem(item,source)
        TriggerClientEvent('esx_loot:water', source, item)
    end

    for k,v in pairs(Config.empty) do	
        ESX.RegisterUsableItem(k, function(source)
            local item = k
            UseItem(item,source)
        end)	
    end

    RegisterNetEvent('hrs_gather:waters')
    AddEventHandler('hrs_gather:waters', function(item)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
    
        local count = xPlayer.getInventoryItem(item).count 
    
        if count > 0 then
            xPlayer.removeInventoryItem(item,1)
            local default = Config.empty[item]
            xPlayer.addInventoryItem(default,1)
            xPlayer.showNotification("You got some water")
        end
    end)    

elseif Config.Framework == "QB" then

    QBCore = exports['qb-core']:GetCoreObject()

    function addItems(source,type)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local items = getItemsList(type)
        local carry = true
        
        for item,count in pairs(items) do
            if not xPlayer.Functions.AddItem(item,count) then 
                carry = false
            else
                TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, QBCore.Shared.Items[item], "add", count)
            end
        end

        if not carry then
            TriggerClientEvent('QBCore:Notify',source,"You can't carry all the items") 
        end
    end

    function canGather(source,count,max)
        local bool = false
        
        if count < max then
            bool = true
        else
            TriggerClientEvent('QBCore:Notify', source, "~r~You can't gather anymore from here")
        end
        
        return bool
    end

    for k,v in pairs(Config.empty) do
        QBCore.Functions.CreateUseableItem(k, function(source)
            local item = k
            UseItem(item,source)
        end)	
    end

    function UseItem(item,source)
        TriggerClientEvent('esx_loot:water', source, item)
    end

    RegisterNetEvent('hrs_gather:waters')
    AddEventHandler('hrs_gather:waters', function(item)
        local _source = source
        local xPlayer = QBCore.Functions.GetPlayer(_source)
    
        local itemAmount = xPlayer.Functions.GetItemByName(item)

        if itemAmount and itemAmount.amount > 0 then
            xPlayer.Functions.RemoveItem(item,1)
            local default = Config.empty[item]
            xPlayer.Functions.AddItem(default,1)

            TriggerClientEvent('QBCore:Notify', _source, "You got some water")
        end
    end)    
end


RegisterNetEvent("hrs_gather:customWeaponImpactMyPed_s")
AddEventHandler("hrs_gather:customWeaponImpactMyPed_s",function(victim, weaponHash)
    TriggerClientEvent("hrs_gather:customWeaponImpactMyPed_c", victim, source, weaponHash)
end)


