QBCore = exports['qb-core']:GetCoreObject()
ped = {}
Citizen.CreateThread(function()
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Wait(1)
    end
    for k, v in pairs(Config.Category) do
        if v.Blip then
            local blip = AddBlipForCoord(v.Ped.location[1], v.Ped.location[2], v.Ped.location[3])
            SetBlipSprite(blip, 500)
            SetBlipColour(blip, 3)
            SetBlipScale(blip, 0.8)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.CategoryLabel .. " Trader")
            EndTextCommandSetBlipName(blip)
        end
        RequestModel(GetHashKey(v.Ped.model))
        while not HasModelLoaded(GetHashKey(v.Ped.model)) do
            Wait(1)
        end
        ped[k] = CreatePed(4, v.Ped.model, v.Ped.location[1], v.Ped.location[2], v.Ped.location[3], v.Ped.heading,
            false, true)
        SetEntityHeading(ped[k], v.Ped.heading)
        FreezeEntityPosition(ped[k], true)
        SetEntityInvincible(ped[k], true)
        SetBlockingOfNonTemporaryEvents(ped[k], true)
        if Config.UseTarget then
            exports['qb-target']:AddTargetEntity(ped[k], {
                options = {{
                    label = Config.OpenMenuText,
                    icon = "fas fa-message",
                    action = function()
                        OpenItemSell(k, v.CategoryLabel)
                    end
                }},
                distance = v.Ped.interactionRange
            })
            
        end
    end
    if not Config.UseTarget then
        while true do
            Citizen.Wait(0)
            sleep = false
            for k, v in pairs(Config.Category) do
                if #(GetEntityCoords(PlayerPedId()) - v.Ped.location) < v.Ped.interactionRange then
                    sleep = true
                    ShowHelpNotification(Config.ShowHelpNotification)
                    if IsControlJustPressed(0, 38) then
                        OpenItemSell(k, v.CategoryLabel)
                    end
                end    
            end
            if not sleep then
                Citizen.Wait(1000)
            end
        end
    end
end)
RegisterCommand(Config.CheckPriceCommand, function()
    opencheckpricemenu()
end)
function PlayGiveAnim(tped)
    local pid = PlayerPedId()
    TaskPlayAnim(pid, "mp_common", "givetake2_a", 8.0, -8, -1, 1, 0, 0, 0, 0)
    TaskPlayAnim(tped, "mp_common", "givetake2_a", 8.0, -8, -1, 1, 0, 0, 0, 0)
    Citizen.Wait(2000)
    ClearPedTasksImmediately(PlayerPedId())
    ClearPedTasksImmediately(tped)
end
function ShowHelpNotification(text)
    AddTextEntry('helpNotification', text)
    DisplayHelpTextThisFrame('helpNotification', false)
end