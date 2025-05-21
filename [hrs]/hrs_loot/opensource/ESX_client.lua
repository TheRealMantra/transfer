if Config.Framework == "ESX" then

    ESX = exports["es_extended"]:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function()
        TriggerServerEvent('hrs_loot:lists')
    end)

    function ShowNotification(text)
        ESX.ShowNotification(text)
    end

end








