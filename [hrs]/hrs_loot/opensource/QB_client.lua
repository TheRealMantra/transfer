if Config.Framework == "QB" then

    QBCore = exports['qb-core']:GetCoreObject()

    function ShowNotification(text)
        QBCore.Functions.Notify(text)
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() 
        TriggerServerEvent('hrs_loot:lists')
    end)

end








