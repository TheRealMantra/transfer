
if Config.Framework == "ESX" then

    ESX = exports["es_extended"]:getSharedObject()

    function ShowNotification(text)
        ESX.ShowNotification(text)
    end

elseif Config.Framework == "QB" then 

    QBCore = exports['qb-core']:GetCoreObject()

    function ShowNotification(text)
        QBCore.Functions.Notify(text)
    end

end


function ProgressBar(index)
    if not Config.UseProgressBar then
        return true
    end

    local ped = PlayerPedId()
 
    local statusValue = nil

    local animType = Config.ProgressBars[index]

    progressBarActive = true

    if GetResourceState('ox_lib') ~= 'missing' then
        if not animType.animation.flags then
            animType.animation.flags = 1
        end

        statusValue = exports.ox_lib:progressCircle({
            duration = animType.duration,
            position = 'middle',
            useWhileDead = false,
            canCancel = true,
            label = animType.label,
            disable = {
                car = true,
                combat = true,
                move = true,
            },
            anim = {
                dict = animType.animation.animDict,
                clip = animType.animation.anim,
                scenario = animType.animation.task,
                flag = animType.animation.flags
            },
            prop = animType.prop
        })

    elseif GetResourceState('mythic_progbar') ~= 'missing' then

        TriggerEvent("mythic_progbar:client:progress", {
            name = type,
            duration = animType.duration,
            label = animType.label,
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = animType.animation.animDict,
                anim = animType.animation.anim,
                task = animType.animation.task,
                flags = animType.animation.flags
            },
            prop = animType.prop
        }, function(status)
            statusValue = not status 
        end) 

        while statusValue == nil do
            Wait(10)
        end

    elseif GetResourceState('esx_progressbar') ~= 'missing' then
        
        if animType.animation.task then
            TaskStartScenarioInPlace(ped, animType.animation.task, 0, true)
        elseif animType.animation.animDict then
            RequestAnimDict(animType.animation.animDict)
            while not HasAnimDictLoaded(animType.animation.animDict) do 
                Wait(10)
            end

            TaskPlayAnim(ped, animType.animation.animDict, animType.animation.anim, 1.0, 1.0, -1, 1, 1.0, false,false,false)
            RemoveAnimDict(animType.animation.animDict)       
        end

        ESX.Progressbar(animType.label, animType.duration,{
            FreezePlayer = true, 
            animation ={},
            onFinish = function()
                statusValue = true
        end, onCancel = function()
                statusValue = false
        end})

        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
        if animType.animation.animDict then
            StopAnimTask(ped, animType.animation.animDict, animType.animation.anim, 1.0)
        end

    elseif GetResourceState('qb-core') ~= 'missing' then

        if animType.animation.task then
            TaskStartScenarioInPlace(ped, animType.animation.task, 0, true)
        elseif animType.animation.animDict then
            RequestAnimDict(animType.animation.animDict)
            while not HasAnimDictLoaded(animType.animation.animDict) do 
                Wait(10)
            end

            TaskPlayAnim(ped, animType.animation.animDict, animType.animation.anim, 1.0, 1.0, -1, 1, 1.0, false,false,false)
            RemoveAnimDict(animType.animation.animDict)       
        end

        QBCore.Functions.Progressbar(index, animType.label,animType.duration, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done   
            statusValue = true 
        end, function() -- Cancel
            statusValue = false
        end)

        while statusValue == nil do
            Wait(10)
        end
    
        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
        if animType.animation.animDict then
            StopAnimTask(ped, animType.animation.animDict, animType.animation.anim, 1.0)
        end

    end

    progressBarActive = false

    return statusValue
end


RegisterNetEvent("esx_loot:water")
AddEventHandler("esx_loot:water",function(item)
    local ped = PlayerPedId()
    
    if IsEntityInWater(ped) then
        if ProgressBar("get_water") then
            TriggerServerEvent('hrs_gather:waters',item)
        end
    else
        ShowNotification("There is no water here.")
    end
end)

function GatheringFun(weapon)
   
end

function CanGather(weapon)
   return true
end

function getAmmo(ped, weapon)
    local ammoTotal = GetAmmoInPedWeapon(ped, weapon)
    local bool, ammoClip = GetAmmoInClip(ped, weapon)

    return bool, ammoClip, ammoTotal
end

function setAmmo(ped, weapon, ammoClip, ammoTotal)
    SetPedAmmo(ped,weapon, ammoTotal)
    SetAmmoInClip(ped, weapon, ammoClip)
end

RegisterNetEvent("hrs_gather:customWeaponImpactPed")
AddEventHandler("hrs_gather:customWeaponImpactPed",function(weaponHash, entity, impactCoords)

    if IsPedAPlayer(entity) then
        if Config.customWeapons[weaponHash].damagePlayer then
            local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            TriggerServerEvent("hrs_gather:customWeaponImpactMyPed_s", playerId, weaponHash)
        end
    else
        if Config.customWeapons[weaponHash].damagePed then
            ApplyDamageToPed(entity, Config.customWeapons[weaponHash].damagePed, true)
        end
    end
 
end)

RegisterNetEvent("hrs_gather:customWeaponImpactVehicle")
AddEventHandler("hrs_gather:customWeaponImpactVehicle",function(weaponHash, entity, impactCoords)

end)

RegisterNetEvent("hrs_gather:customWeaponImpactObject")
AddEventHandler("hrs_gather:customWeaponImpactObject",function(weaponHash, entity, impactCoords)

end)

RegisterNetEvent("hrs_gather:customWeaponImpactMyPed_c")
AddEventHandler("hrs_gather:customWeaponImpactMyPed_c",function(sourceOfDamage, weaponHash)
    
    if Config.customWeapons[weaponHash].damagePlayer then

     --   print("suffer damage ", sourceOfDamage, weaponHash)

        ApplyDamageToPed(entity, Config.customWeapons[weaponHash].damagePlayer, true)
    end
end)

