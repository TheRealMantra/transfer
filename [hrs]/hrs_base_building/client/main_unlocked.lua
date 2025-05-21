itemLabels = {}
hideCables = false

myCrew = nil
invitesCrew = nil
identifier = nil

RegisterNetEvent('hrs_base_building:setCrewC')
AddEventHandler('hrs_base_building:setCrewC', function(crew)
    myCrew = crew
end)

RegisterNetEvent('hrs_base_building:setInvitesC')
AddEventHandler('hrs_base_building:setInvitesC', function(invites)
    invitesCrew = invites
end)

function getLabel(item)
    if itemLabels[item] then
        return itemLabels[item]
    else
        if Config.itemLabels[item] then
            return Config.itemLabels[item]
        else
            print("item "..item.." does not exist")
            return item.."-ERROR"
        end
    end
end

function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

function hasPermissionVeh(identifier,identifier2)

    if identifier == identifier2 then
        return true
    end

    if myCrew and myCrew.data[identifier2] then
        return true		
    end

	return false
end

exports("hasPermissionVeh", hasPermissionVeh)

function hasCrewPermission(myIdentifier, otherIdentifier, permissionType)

   -- debug(myIdentifier, otherIdentifier, permissionType)

    if myIdentifier == otherIdentifier then
        return true
    end

    if not myCrew then 
        return false 
    end

    if otherIdentifier then
        if not myCrew.data[otherIdentifier] then 
            return false 
        end
    end

    if myCrew.owner == myIdentifier then 
        return true 
    end
    
    if not permissionType then 
        return true
    end

    local permissionTypeKey = Config.crewPermissionsById[permissionType]

    if not myCrew.data[myIdentifier].permissions then
        return false
    end

    if myCrew.data[myIdentifier].permissions[permissionTypeKey] then 
        return true 
    end

    return false
end

exports("hasCrewPermission", hasCrewPermission)


----------- ESX RELATED

if Config.Framework == "ESX" then

    ESX = exports['es_extended']:getSharedObject()

    -- ESX = nil
    -- CreateThread(function()
	--     while ESX == nil do
	-- 	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	    Wait(0)
	--     end
    -- end)

    function loadLabels()
        if Config.inventory == 'ox_inventory' then
            for k,v in pairs(exports.ox_inventory:Items()) do
                itemLabels[k] = v.label
            end
        else
            itemLabels = Config.itemLabels
        end
    end

    function loadEverything()
        FreezeEntityPosition(PlayerPedId(),true)
        BeginBasesLoad()

        loadLabels()
        loadTarget()

        TriggerServerEvent('hrs_base_building:getCrewS')     
    end

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function()
        loadEverything()
    end)

    function ShowNotification(text)
        ESX.ShowNotification(text)
    end

elseif Config.Framework == "QB" then
   
    QBCore = exports['qb-core']:GetCoreObject()

    function ShowNotification(text)
        QBCore.Functions.Notify(text)
    end

    -- CreateThread(function()
    --     Wait(500)
    --     BeginBasesLoad()
    -- end)

    function loadLabels()
        for k,v in pairs(QBCore.Shared.Items) do
            
            itemLabels[k] = v.label
            
        end
    end

    function loadEverything()
        FreezeEntityPosition(PlayerPedId(),true)
        BeginBasesLoad()

        loadLabels()
        loadTarget()

        TriggerServerEvent('hrs_base_building:getCrewS')
    end

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() 
        loadEverything()       
    end)

end

------------------ Crew Menu --------------------------------
-------------------------------------------------------------

AddEventHandler('hrs_base_building:crew:playerList', function()
    local elements = {}

    if myCrew then
        local players = GetActivePlayers()
        local player = PlayerId()

        local myCoords = GetEntityCoords(PlayerPedId())
        for k,v in ipairs(players) do
            if player ~= v then
                local entCoords = GetEntityCoords(GetPlayerPed(v))
                if #(myCoords - entCoords) < 3.0 then
                    table.insert(elements,{
                        title = GetPlayerName(v),
                        serverEvent = 'hrs_base_building:addToCrew',
                        args = GetPlayerServerId(v),
                        description = Config.Locales["crew_invite_player"]
                    })
                end
            end
        end

        if #elements > 0 then
            exports.ox_lib:registerContext({
                id = 'crew_playerList',
                title = Config.Locales["crew_playerList"],
                options = elements
            })
    
            exports.ox_lib:showContext('crew_playerList')
        else
            ShowNotification(Config.Locales["crew_no_players"])
        end
        
    end
end)

AddEventHandler('hrs_base_building:crew:managePlayer', function(identifier2)
    --debug(player)




    local elements = {}

    if hasCrewPermission(identifier,nil,"canRemoveMembers") then
        table.insert(elements,{
            title = "Remove From Crew",
            description  = Config.Locales["crew_remove_player"],
            onSelect = function()
                local check = exports.ox_lib:alertDialog({
                    header = "Remove "..myCrew.data[identifier2].name.." from Crew",
                    content = 'Are you sure you want to remove this person from your crew?',
                    centered = true,
                    cancel = true
                })

                if check == 'confirm' then
                    TriggerServerEvent('hrs_base_building:removeFromCrew', identifier2)
                end
            end
        })
    end

    table.insert(elements,{
        title = Config.Locales["crew_permissions"],
        description  = Config.Locales["crew_permissions_desc"],
        onSelect = function()
            if not myCrew.data[identifier2].permissions then
                myCrew.data[identifier2].permissions = {}
            end

            local tab = {}

            for k,v in ipairs(Config.crewPermissions) do
                table.insert(tab,{type = "checkbox", label = v.label, checked = myCrew.data[identifier2].permissions[k] or false})
            end

            local perms = exports.ox_lib:inputDialog(myCrew.data[identifier2].name.." "..Config.Locales["crew_permissions"],tab)

            if perms then
                TriggerServerEvent('hrs_base_building:updateCrewPerms', identifier2, perms)
            end
        end,
    })

    if identifier == myCrew.owner then
        table.insert(elements,{
            title = Config.Locales["give_crew_ownership"],
            description  = Config.Locales["give_crew_ownership_desc"],
            onSelect = function()

                TriggerServerEvent('hrs_base_building:updateCrewOwner', identifier2)
                
            end,
        })
    end


    exports.ox_lib:registerContext({
        id = 'crew_manage_player',
        title = myCrew.data[identifier].name,
        options = elements
    })

    exports.ox_lib:showContext('crew_manage_player')
end)


AddEventHandler('hrs_base_building:crew:manage', function()
    local elements = {}

    --debug(myCrew)

    if myCrew and myCrew.data then
        for k,v in pairs(myCrew.data) do

            local title = v.name

            if k == myCrew.owner then
                title = v.name.." (OWNER)"
            end

            if k ~= identifier then
                if k == myCrew.owner then
                    table.insert(elements,{
                        title = title,
                        disabled = true,
                        description = "You can't manage the crew owner"
                    })
                else
                    table.insert(elements,{
                        title = title,
                        event = 'hrs_base_building:crew:managePlayer',
                        args = k,
                        -- description  = Config.Locales["crew_remove_player"]
                        description = "Manage player"
                    })
                end
            else
                table.insert(elements,{
                    title = title,
                    disabled = true,
                    description = "You can't manage yourself"
                })
            end
        end

        exports.ox_lib:registerContext({
            id = 'crew_manage',
            title = Config.Locales["crew_manage"],
            options = elements
        })

        exports.ox_lib:showContext('crew_manage')
    end
end)


AddEventHandler('hrs_base_building:crew:invitesList', function()
    local elements = {}

    if not myCrew and invitesCrew then
        for k,v in pairs(invitesCrew) do
            table.insert(elements,{
                title = v,
                description = Config.Locales["crew_join"],
                onSelect = function()

                    -- local bool = getClaimArea()

                    -- if bool then
                    --     ShowNotification("You need to destroy your totem to join a crew")
                    --     return
                    -- end

                    TriggerServerEvent('hrs_base_building:acceptCrew', k)
                    
                end
            })
        end

        exports.ox_lib:registerContext({
            id = 'crew_invitesList',
            title = Config.Locales["crew_invitesList"],
            options = elements
        })

        exports.ox_lib:showContext('crew_invitesList')
    else
        ShowNotification(Config.Locales["crew_no_invites"])
    end
end)

function OpenCrewMenu()
    local elements = {}
    if myCrew then



        if myCrew.owner == identifier then

            table.insert(elements,{
                title = Config.Locales["crew_delete_header"], 
                onSelect = function()
                    local check = exports.ox_lib:alertDialog({
                        header = "Delete Crew",
                        content = 'Are you sure you want to delete the crew?',
                        centered = true,
                        cancel = true
                    })
        
                    if check == 'confirm' then
                        TriggerServerEvent('hrs_base_building:deleteCrew')
                    end
                end,
                description = Config.Locales["crew_delete_desc"],
            })






            table.insert(elements,{
                title = Config.Locales["change_crew_name"],
                onSelect = function()
                    local input = exports.ox_lib:inputDialog(Config.Locales["change_crew_name"], {Config.Locales["new_name"]})
                    
                    if input and input[1] then
                        TriggerServerEvent('hrs_base_building:updateCrewName', tostring(input[1]))
                    end
                end,
                arrow = true,
                description = Config.Locales["change_crew_name_click"]
            })

        else
            table.insert(elements,{
                title = Config.Locales["crew_leave_header"],
                serverEvent = 'hrs_base_building:leaveCrew',
                description = Config.Locales["crew_leave_desc"]
            })
        end

        if hasCrewPermission(identifier,nil,"canInviteMembers") then
            table.insert(elements,{
                title = Config.Locales["crew_invite_header"],
                event = 'hrs_base_building:crew:playerList',
                description = Config.Locales["crew_invite_desc"],
                arrow = true
            })
        end

        if hasCrewPermission(identifier,nil,"canManageMembers") then
            table.insert(elements,{
                title = Config.Locales["crew_manage_header"],
                event = 'hrs_base_building:crew:manage',
                description = Config.Locales["crew_manage_desc"],
                arrow = true
            })
        end

    else
        table.insert(elements,{
            title = Config.Locales["crew_invites_header"],
            event = 'hrs_base_building:crew:invitesList',
            description = Config.Locales["crew_invites_desc"],
            arrow = true
        })

        table.insert(elements,{
            title = Config.Locales["crew_create_header"],
            serverEvent = 'hrs_base_building:createCrew',
            description = Config.Locales["crew_create_desc"]
        })
    end

    exports.ox_lib:registerContext({
        id = 'OpenCrewMenu',
        title = Config.Locales["crew_menu"],
        options = elements
    })

    exports.ox_lib:showContext('OpenCrewMenu')
end

---------------------------------------------------------------
---------------------------------------------------------------



RegisterNetEvent("hrs_base_building:juststarted")
AddEventHandler("hrs_base_building:juststarted", function()
    loadEverything()
end)










------------------ Command to open Crew Menu ----------------
RegisterCommand("crew", function()
    OpenCrewMenu()
end)






------------ PROP POSITIONING ---------

CreateThread(function()	
	while true do
		Wait(0)
				
		if prop then
            DisableControlAction(0,22,true)
            DisableControlAction(0,21,true)

            DisableControlAction(0,14,true)
            DisableControlAction(0,15,true)

            DisableControlAction(0,24,true)


            local needWait = false

            if not Config.disableZChange then
                
                if IsControlPressed(0,172) then
                    increzeZ()	
                    needWait = true
                elseif IsControlPressed(0,173) then
                    decreaseZ()	
                    needWait = true
                end

            end

			if IsControlPressed(0,175) then
                rotatePositive()
                needWait = true
			elseif IsControlPressed(0,174) then
                rotateNegative()
                needWait = true
            end

            if IsDisabledControlPressed(0,14) then               
				forwardChange(-0.1)
                needWait = true
            elseif IsDisabledControlPressed(0,15) then               
				forwardChange(0.1)
                needWait = true
			end	

            if IsDisabledControlPressed(0,21) then
                setDirectConnect(true)
            else
                setDirectConnect(false)
            end

            if needWait then
                Wait(50)
            else
			    if IsControlJustReleased(0,215) or IsDisabledControlJustReleased(0,24) then               
				    applyFinalPos()
                end
            end
            
            
            --print(GetPedConfigFlag(PlayerPedId(),388))

            if IsControlJustReleased(0,177) or IsDisabledControlJustPressed(0,22) or IsDisabledControlPressed(0,22) then
                cancelPos()
            end	


		end
	end
end)


--- Disable climbing ladders while positioning props to prevent bugs
CreateThread(function()	
	while true do
		Wait(100)
		if prop then
            SetPedConfigFlag(PlayerPedId(),146,true)
            while prop do
                Wait(100)
            end
            SetPedConfigFlag(PlayerPedId(),146,false)
		end
	end
end)



----------------------------------------------------------------------------

function progressBar(index)
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

-------------------------- prop interaction




function OnStorageOpen(id,hash,owner,date) 
    local text = 'HRS'..hash..""..id..""..date
    text = string.gsub(text, "-", "n")
    text = string.gsub(text, ":", "")
    text = string.gsub(text, "_", "")
    text = string.gsub(text, "/", "")



    if Config.inventory == 'ox_inventory' then
        if Config.usingOldInventoryMethod then
            text = tostring('HRS_'..hash.."_"..id.."_"..date)
        end

        local bool = exports.ox_inventory:openInventory('stash', text)
        if not bool then
            TriggerServerEvent('hrs_base_building:oxLoad',id,hash)
            exports.ox_inventory:openInventory('stash', text)
        end
    elseif Config.inventory == 'qb-inventory' then   
        if Config.usingOldInventoryMethod then
            text = 'HRS'..hash..""..id..""..date
            text = string.gsub(text, "-", "_")
        end
        
        TriggerServerEvent("inventory:server:OpenInventory", "stash", text, {
            maxweight = Config.Models[hash].weight,
            slots = Config.Models[hash].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", text)

        TriggerServerEvent("qb-inventory:server:stashNew",text, {
            maxweight = Config.Models[hash].weight,
            slots = Config.Models[hash].slots
        })
    elseif Config.inventory == 'chezza_inventory' then 

        --text = tonumber(string.gsub(text, "HRS", ""))

        TriggerEvent('inventory:openInventory', {
            type = "stash",
            id = text,
            title = getLabel(Config.Models[hash].item),
            weight = Config.Models[hash].weight,
            delay = 0, 
            save = true 
        })        
    elseif Config.inventory == 'core_inventory' then 
        local coreStash = Config.Models[hash].coreStashName

        if not coreStash then
            coreStash = "stash"
        end

        TriggerServerEvent('core_inventory:server:openInventory', text, coreStash)

        --TriggerServerEvent('core_inventory:server:openInventory', text, "stash")
    elseif Config.inventory == 'qs-inventory' then 
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..text)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..text)
    elseif Config.inventory == 'tp_inventory_hud' then 
        exports.tp_inventory_hud:registerStashInventory(text,{})
        Wait(200)
        exports.tp_inventory_hud:openInventory('stash', text)

    elseif Config.inventory == 'axfw-inventory' then 

        TriggerServerEvent('ax-inv:Server:OpenInventory','Stash-'..text,{slots = Config.Models[hash].slots})
    elseif Config.inventory == 'origen_inventory' then 

        TriggerServerEvent("origen_inventory:server:stashNew",text, {
            weight = Config.Models[hash].weight,
            slots = Config.Models[hash].slots,
            label = getLabel(Config.Models[hash].item)
        })

    else
        print("PLEASE SETUP YOUR INVENTORY SYSTEM")
    end
end

function objectExplode(Object)
    if propsalreadyspowned[Object] then
        local UsedId = propsalreadyspowned[Object].id
        TriggerEvent('hrs_base_building:advancedInteractClient',"c4",UsedId)
    else
       
        ShowNotification(Config.Locales["no_interactions"])
    end
end

function discordPropDebug(Object)
    if propsalreadyspowned[Object] then
        local UsedId = propsalreadyspowned[Object].id
        TriggerServerEvent('hrs_base_building:getPropData',UsedId)
    else
       
        ShowNotification(Config.Locales["no_interactions"])
    end
end

function propRaidCheck(Object)
    if propsalreadyspowned[Object] then
        local UsedId = propsalreadyspowned[Object].id
        TriggerServerEvent('hrs_base_building:canRaid',UsedId)
    else
        ShowNotification(Config.Locales["no_interactions"])
    end
end

function getOwnedProps()
    local ownedProps = {}
    for k,v in pairs(props) do
        if hasPermissionVeh(identifier,v.identifier) then
            table.insert(ownedProps,k)
        end
    end
    return ownedProps
end

function getPropsAroundUpkeep(upkeepId, objects, repair)
    local radius =  Config.Models[props[upkeepId].hash].upkeepRadius or Config.upkeepRadius
    local ownedProps = {}
    for k,v in pairs(props) do
        if #(props[upkeepId].coords - v.coords) <= radius then
            if hasPermissionVeh(identifier,v.identifier) then
                if repair then
                    ownedProps[k] = {[upkeepId] = true}
                else

                    if objects then
                        if props[k].object then
                            table.insert(ownedProps,props[k].object)
                        end
                    else
                        table.insert(ownedProps,k)
                    end

                end
            end
        end
    end
    return ownedProps
end

function objectInteractFunction(Object,isAdvanced,ignoreOnOff)

    if not propsalreadyspowned[Object] then
        local model = GetEntityModel(Object)
       -- print("model "..type(model))
        if Config.Models[model] and Config.Models[model].mapProp and Config.Models[model].TriggerEvent then
            TriggerEvent('hrs_base_building:triggerfinal',model,Object)
        else
            ShowNotification(Config.Locales["no_interactions"])
        end

        return
    end

    if isAdvanced then  
        local list = nil

        if Config.Models[propsalreadyspowned[Object].hash].type == 'upkeep' then
            list = getPropsAroundUpkeep(propsalreadyspowned[Object].id)
        end

        if Config.Models[propsalreadyspowned[Object].hash].type == "windTurbine" then
            list = Round(GetWindSpeed())
        end

        local UsedId = propsalreadyspowned[Object].id
        TriggerServerEvent("hrs_base_building:advancedInteractServer",UsedId,nil,list)

        return
    end

    local typeEntity = getEntityModelInfo(Object,"type")
    local subtypeEntity = getEntityModelInfo(Object,"subtype")
    local entityId = getEntityId(Object)
    local trigger = getEntityModelInfo(Object,"TriggerEvent")
    local ent = propsalreadyspowned[Object]

    if propsalreadyspowned[Object].dooropen ~= nil then    
        TriggerServerEvent('hrs_base_building:doorstatus',entityId)	
    elseif typeEntity == "need_stand_weapon" and not ignoreOnOff then
        TriggerServerEvent('hrs_base_building:onstatusTurret',entityId)	
    elseif propsalreadyspowned[Object].on ~= nil and not ignoreOnOff then  
                
        local extraData = nil
        if Config.Models[propsalreadyspowned[Object].hash].type == "windTurbine" then
            extraData = Round(GetWindSpeed())
        end

        TriggerServerEvent('hrs_base_building:onstatus',entityId,extraData)	
    elseif typeEntity == "storages" then
        if Config.Models[props[entityId].dead] and Config.Models[props[entityId].dead].itemStock then
            TriggerServerEvent('hrs_base_building:openstock',entityId, "Dead Stock")
        else
            TriggerServerEvent('hrs_base_building:canopenstorage',entityId)
        end
    elseif subtypeEntity == "biggateway" then
        local gate = GetBigGate(ent.coords)
        if gate then
            local newId = getEntityId(gate)
            TriggerServerEvent('hrs_base_building:doorstatus',newId)	
        else
            ShowNotification(Config.Locales["no_gate"])
        end
    elseif subtypeEntity == "doorway" then
        local door = GetDoor(ent.coords)
        if door then
            local newId = getEntityId(door)
            TriggerServerEvent('hrs_base_building:doorstatus',newId)	
        else
            ShowNotification(Config.Locales["no_door"])
        end
    elseif trigger then
        if getEntityModelInfo(Object,"power") then
            if not propsalreadyspowned[Object].on then
                ShowNotification(Config.Locales["need_on_machine"])
            else 
                if hasEnergy(entityId) then
                    TriggerServerEvent('hrs_base_building:trigger',entityId,Object)
                else
                    ShowNotification(Config.Locales["no_electricity"])
                end
            end
        else
            TriggerServerEvent('hrs_base_building:trigger',entityId,Object)
        end            
    end
end

RegisterNetEvent('building:interact', function(Object,isAdvanced,ignoreOnOff)
    objectInteractFunction(Object,isAdvanced,ignoreOnOff)
end)

electricConnectionAdd = nil

------------------------ interaction sys



function registerTarget(k,v)
    if not v.item then 
        return 
    end

    local models = {}
    table.insert(models,v.modelName)

    local options = {}

    if isOnOffProp(k) then
        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-toggle-on",
                label = Config.Locales["turn_off"] .. getLabel(v.item),
                action = function(entity)
                    TriggerEvent('building:interact',entity,false)
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] then
                        if propsalreadyspowned[entity].on then
                            return true
                        end
                    end
                    return false
                end
            }
        )

        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-toggle-off",
                label = Config.Locales["turn_on"] .. getLabel(v.item),
                action = function(entity)
                    TriggerEvent('building:interact',entity,false)
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] then
                        if not propsalreadyspowned[entity].on then
                            return true
                        end
                    end
                    return false
                end
            }
        )
    end

    if not v.disableIteract then
        if v.mapProp then
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fa-solid fa-hand",
                    label = Config.Locales["interact_with"] .. getLabel(v.item),
                    action = function(entity)
                        TriggerEvent('building:interact',entity,false,true)
                    end,
                    canInteract = function(entity)
                        return true
                    end
                }
            )
        else
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fa-solid fa-hand",
                    label = Config.Locales["interact_with"] .. getLabel(v.item),
                    action = function(entity)
                        TriggerEvent('building:interact',entity,false,true)
                    end,
                    canInteract = function(entity)
                        if propsalreadyspowned[entity] then
                            return true
                        end
                        return false
                    end
                }
            )
        end
    end

    if not v.disableIteractAdvanced then
        if v.subtype == "deadStorage" then
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fas fa-gear",
                    label = Config.Locales["delete"] .. getLabel(v.item),
                    action = function(entity)
                        TriggerEvent('building:interact',entity,true)
                    end,
                    canInteract = function(entity)
                        if propsalreadyspowned[entity] then
                            return true
                        end
                        return false
                    end
                }
            )
        else
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fas fa-gear",
                    label = Config.Locales["open"] .. getLabel(v.item) .. Config.Locales["settings"],
                    action = function(entity)
                        TriggerEvent('building:interact',entity,true)
                    end,
                    canInteract = function(entity)
                        if propsalreadyspowned[entity] then
                            return true
                        end
                        return false
                    end
                }
            )
        end
    end

    table.insert(
        options,
        {
            num= #options + 1,
            type = 'client',
            icon = "fa-solid fa-explosion",
            label = Config.Locales["use_c4"] .. getLabel(v.item),
            action = function(entity)
                objectExplode(entity)
            end,
            canInteract = function(entity)
                if propsalreadyspowned[entity] then
                    if Config.disableExplosiveOptionOnOwnedProp then
                        if (myCrew and myCrew.data[propsalreadyspowned[entity].identifier]) or propsalreadyspowned[entity].identifier == identifier then
                            return false
                        end
                    end
                    return true
                end
                return false
            end
        }
    )

    if Config.disableOfflineRaiding or Config.raidSchedule then
        --print(Config.Locales["inspect_raid"])
        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-explosion",
                --label = Config.Locales["inspect_raid"] .. getLabel(v.item),
                label = Config.Locales["inspect_raid"] .. getLabel(v.item),
                action = function(entity)
                    propRaidCheck(entity)
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] then
                        if Config.disableExplosiveOptionOnOwnedProp then
                            if (myCrew and myCrew.data[propsalreadyspowned[entity].identifier]) or propsalreadyspowned[entity].identifier == identifier then
                                return false
                            end
                        end
                        return true
                    end
                    return false
                end
            }
        )

    end

    table.insert(
        options,
        {
            num= #options + 1,
            type = 'client',
            icon = "fa-solid fa-explosion",
            label = "inspect" .. getLabel(v.item),
            action = function(entity)
                --objectExplode(entity)

                discordPropDebug(entity)

            end,
            canInteract = function(entity)
                if propsalreadyspowned[entity] and discordDebugState then
                    return true
                end
                return false
            end
        }
    )

    if v.generatorPower or v.energyCapacity or v.power or v.type == "powerComb" or v.type == "powerDist" then

        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-plug-circle-bolt",
                label = "Add Eletric Connection",
                action = function(entity)
                    --objectExplode(entity)
                    electricConnectionAdd = entity
                    --discordPropDebug(entity)

                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] then
                        if not electricConnectionAdd then
                            return true
                        end
                    end
                    return false
                end
            }
        )

        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-plug-circle-bolt",
                label = "Connect",
                action = function(entity)
                    addElectricConnection(electricConnectionAdd,entity)
                    electricConnectionAdd = nil  
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] and electricConnectionAdd and electricConnectionAdd ~= entity and not areConnectedCheck(electricConnectionAdd,entity) then
                        return true
                    end
                    return false
                end
            }
        )

        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-plug-circle-bolt",
                label = "Cancel Connection",
                action = function(entity)
                    electricConnectionAdd = nil
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] and electricConnectionAdd then
                        return true
                    end
                    return false
                end
            }
        )

        table.insert(
            options,
            {
                num= #options + 1,
                type = 'client',
                icon = "fa-solid fa-plug-circle-bolt",
                label = "Disconnect",
                action = function(entity)
                    addElectricConnection(electricConnectionAdd,entity)
                    electricConnectionAdd = nil   
                end,
                canInteract = function(entity)
                    if propsalreadyspowned[entity] and electricConnectionAdd and electricConnectionAdd ~= entity and areConnectedCheck(electricConnectionAdd,entity) then
                        return true
                    end
                    return false
                end
            }
        )

        if v.isSwitch then
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fa-solid fa-toggle-on",
                    label = Config.Locales["turn_off"] .. "circuit",
                    action = function(entity)
                        local connected = getCleanOutputsList(propsalreadyspowned[entity].id)
                        TriggerServerEvent('hrs_base_building:onstatusList', propsalreadyspowned[entity].id, connected, false)
                        debug(connected)
                    end,
                    canInteract = function(entity)
                        if propsalreadyspowned[entity] then                           
                            return true                     
                        end
                        return false
                    end
                }
            )
    
            table.insert(
                options,
                {
                    num= #options + 1,
                    type = 'client',
                    icon = "fa-solid fa-toggle-off",
                    label = Config.Locales["turn_on"] .. "circuit",
                    action = function(entity)
            
                        local connected = getCleanOutputsList(propsalreadyspowned[entity].id)
                        TriggerServerEvent('hrs_base_building:onstatusList', propsalreadyspowned[entity].id, connected, true)
                        --debug(connected)

                    end,
                    canInteract = function(entity)
                        if propsalreadyspowned[entity] then      
                            return true         
                        end
                        return false
                    end
                }
            )
        end

    end

    exports[Config.UseTargetExport]:AddTargetModel(models, {
        options = options,
        distance = 4.0
    })

    
end

function loadTarget()
    if Config.UseTargetExport then
        
        for k,v in pairs(Config.Models) do
            registerTarget(k,v)
        end 

        if Config.showTutorial then
            CreateThread(function()	
                while true do
                    sleep = 0

                    if prop then                       
                        AddTextEntry('esxHelpNotification2', Config.Locales["tutorial_text"])
                        BeginTextCommandDisplayHelp('esxHelpNotification2')
                        EndTextCommandDisplayHelp(0, false, false, 0)
                    else
                        sleep = 500
                    end

                    Wait(sleep)   
                end
            end)
        end

    else

        myobject = nil

        local info = nil

        function getText(myobject)
            local type = getEntityModelInfo(myobject,"type")
            
            infoTextTest = Config.Locales["notarget_"..type]
            
            local subtype = getEntityModelInfo(myobject,"subtype")

            if subtype then
                local newInfo = Config.Locales["notarget_"..subtype]
                if newInfo then
                    infoTextTest = newInfo
                end
            end

            return infoTextTest
        end

        CreateThread(function()
            while true do
                Wait(200)
            
                local infoText = info
                
                if canInteractConditions() then
                    local myobjectTest = RayCastGamePlayCamera(20.0,5.0)


                    if myobjectTest ~= myobject then            
                        myobject = myobjectTest
                    
                        if myobject then
                            if propsalreadyspowned[myobject] then
                                infoText = getText(myobject) 
                            end
                        end
                    else
                        if myobjectTest == nil then
                            myobject = nil
                            infoText = nil
                        end
                    end
                else
                    myobject = nil
                    infoText = nil
                end

                info = infoText
            end
        end)

        function canInteractConditions()
            if IsNuiFocused() or IsPauseMenuActive() or IsEntityDead(PlayerPedId()) or not IsPedOnFoot(PlayerPedId()) or prop or progressBarActive then
                return false
            else
                return true
            end
        end

        CreateThread(function()	
            while true do
                sleep = 0

                local text = nil
                if (info and myobject) then
                    text = info
                elseif Config.showTutorial and prop then
                    text = Config.Locales["tutorial_text"]
                else
                    sleep = 100
                end

                if text then
                    AddTextEntry('esxHelpNotification2', text)
                    BeginTextCommandDisplayHelp('esxHelpNotification2')
                    EndTextCommandDisplayHelp(0, false, false, 0)
                end

                Wait(sleep)
            end
        end)

        CreateThread(function()	
            while true do
                sleep = 0
                if myobject and propsalreadyspowned[myobject] then
                    local timerObject = myobject

                    if IsControlJustPressed(0,38) then
                        local timer = 0
                        while IsControlPressed(0,38) and timer < 100 do
                            Wait(50)
                            timer = timer + 4

                            if timer > 4 then
                                info = Config.Locales["notarget_pressingText"]..timer.."%"
                            end
                        end

                        local isAdvanced = false

                        if timer >= 100 then
                            isAdvanced = true
                        end

                        if myobject == timerObject then
                            info = getText(timerObject) 
                            objectInteractFunction(timerObject,isAdvanced)    
                        end

                        
                    end
                else
                    sleep = 100
                end
                Wait(sleep)
            end
        end)


    end
end

---------------- effects 
function Draw3DText(x, y, z, scl_factor, text,isRed)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        if isRed then
            SetTextColour(255, 0, 0, 215)
        else
            SetTextColour(255, 255, 255, 215)
        end
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent('hrs_base_building:explosionEffect')
AddEventHandler('hrs_base_building:explosionEffect', function(coords,weakerItem)
    ClearPedTasks(PlayerPedId())
    
    if Config.explosionItems[weakerItem].delay then
        local waitTime = Config.explosionItems[weakerItem].delay

        CreateThread(function()
            while waitTime > 0 do
                Wait(0)
                Draw3DText(coords.x,coords.y,coords.z + 1.0,0.6,"💣 ["..waitTime.."]",true)
            end
        end)

        while waitTime > 0 do
            Wait(1000)
            waitTime = waitTime - 1
        end
    end
 
    AddExplosion(coords.x,coords.y,coords.z, 2, 0.0, true, false, true, 0.0)
    showNonLoopParticle("veh_xs_vehicle_mods", "exp_xs_mine_emp", 2.0, coords.x, coords.y, coords.z, false)
end)

function drawLightFunc(coords,hash,forward,lightEntity,id)
    local id = tonumber(id)
    
    if Config.Models[hash].pointGround then 
        forward = vector3(0.0,0.0,-1.0)
    end

    local color = {r = 255,g = 223, b = 127}
    local distance = 12.0
    local intensity = 1.0
    local roundness = 0.0
    local radius = 80.0
    local falloff = 10.0

    if Config.Models[hash].lightData then 
        color = Config.Models[hash].lightData.color or color
        intensity = Config.Models[hash].lightData.intensity or intensity
        roundness = Config.Models[hash].lightData.roundness or roundness
        radius = Config.Models[hash].lightData.radius or radius
        falloff = Config.Models[hash].lightData.falloff or falloff
        distance = Config.Models[hash].lightData.distance or distance
    end

    DrawSpotLightWithShadow(coords.x,coords.y,coords.z,forward.x,forward.y,forward.z,color.r,color.g,color.b,distance,intensity,roundness,radius,falloff,id)
    DrawLightWithRange(coords.x,coords.y,coords.z,color.r,color.g,color.b,0.6,25.0)
end



function showNonLoopParticle(dict, particleName, size, coordx, coordy, coordz, offset)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Citizen.Wait(0)
    end
    local ped = PlayerPedId()
    local x,y,z = coordx, coordy, coordz

    local a = 0
    while a < 1 do
        UseParticleFxAssetNextCall(dict)
        SetParticleFxNonLoopedColour(255,255,255)
        if offset then
            StartNetworkedParticleFxNonLoopedAtCoord(particleName, x+math.random(-2,2), y+math.random(-1,2), z, 0.0, 0.0, 0.0, size, false, false, false)
        else
            -- print(x)
            -- print(y)
            -- print(z)
            StartNetworkedParticleFxNonLoopedAtCoord(particleName, x, y, z, 0.0, 0.0, 0.0, size, false, false, false)
        end
        a = a + 1
        Citizen.Wait(500)
    end
end

RegisterNetEvent('hrs_base_building:triggerfinal')
AddEventHandler('hrs_base_building:triggerfinal', function(hash,Object)


    

    local args = {}

    if Config.Models[hash].TriggerEvent.args then
        if Config.Models[hash].TriggerEvent.entityAsArg then
            for k,v in ipairs(Config.Models[hash].TriggerEvent.args) do          
                if v == Config.Models[hash].TriggerEvent.entityAsArg then
                    args[k] = Object
                else
                    args[k] = v
                end
            end
        else
            for k,v in ipairs(Config.Models[hash].TriggerEvent.args) do          
                args[k] = v               
            end
        end
    end

    

    if Config.Models[hash].TriggerEvent.type == "client" then
        TriggerEvent(Config.Models[hash].TriggerEvent.event,table.unpack(args))
    else
        TriggerServerEvent(Config.Models[hash].TriggerEvent.event,table.unpack(args))
    end
end)

------------------------- Blips

function createBlips()
    if Config.disableBuildingBlips then
        for k,v in ipairs(Config.disableBuilding) do
            local x,y,z = table.unpack(v.coords)
            local blip = AddBlipForRadius(x,y,z, v.radius)
            SetBlipHighDetail(blip, true)
            SetBlipColour(blip, Config.disableBuildingBlips.color)
            SetBlipAlpha (blip, Config.disableBuildingBlips.alpha)
            SetBlipAsShortRange(blip, Config.disableBuildingBlips.shortRange)
            local blip2 = AddBlipForCoord(x,y,z) 
            SetBlipSprite(blip2, Config.disableBuildingBlips.sprite)
            SetBlipScale(blip2, Config.disableBuildingBlips.scale)
            SetBlipAsShortRange(blip2, Config.disableBuildingBlips.shortRange)
            SetBlipColour(blip2,Config.disableBuildingBlips.color)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.disableBuildingBlips.label)
            EndTextCommandSetBlipName(blip2)
        end
    end
end



-------------------------- CAN SPAWN PROP FUNCTION (if you want to add more conditions to spawning)

-- CreateThread(function()
--     while true do
--         Wait(500)
--         print(#GetGamePool('CObject'))
--     end
-- end)

function getBeds()
    local beds = nil
    for k,v in pairs(props) do
        if Config.Models[v.hash].type == "beds" then 
            if v.identifier == identifier then 
                if not beds then
                    beds = {}
                end
                beds[v.id..'_'..v.hash] = {
                    coords = v.coords,
                    heading = v.heading,
                    bedKey = v.id..'_'..v.hash
                }
            end
        end
    end
    return beds
end

function getPropTypeCount(propType)
    local count = 0
    for k,v in pairs(props) do
        if Config.Models[v.hash].type == propType then 
            if v.identifier == identifier then 
                count = count + 1
            end
        end
    end
    return count
end

function getBed(byDistance)

    if byDistance then
        local myPedCoords = GetEntityCoords(PlayerPedId())

        local distance = 1000000000.0
        local propId = nil

        for k,v in pairs(props) do
            if Config.Models[v.hash].type == "beds" then 
                
                if v.identifier == identifier then 

                    local currentDistance = #(myPedCoords - v.coords)

                    if currentDistance < distance then
                        propId = k
                        distance = currentDistance
                    end
                end
            end
        end

        if propId then
            return props[propId].coords
        end

    else
        for k,v in pairs(props) do
            if Config.Models[v.hash].type == "beds" then 
                if v.identifier == identifier then 
                    return v.coords
                end
            end
        end
    end


    return nil
end

exports('getBeds',getBeds)
exports('getBed',getBed)


function canSpawnPropSecond(hash,coords,enableMessage)

    if Config.buildFlag then

        if not canBuildPropHere(hash, coords, enableMessage) then
            return false
        end

    end

    if Config.propLimitPerType then
        if Config.propLimitPerType[Config.Models[hash].type] then
            if getPropTypeCount(Config.Models[hash].type) >= Config.propLimitPerType[Config.Models[hash].type] then
                if enableMessage then
                    ShowNotification(Config.Locales["prop_type_limit"])
                end

                return false
            end
        end
    end



    -- if Config.onlyBuildOnClaimZones then
    --     if not Config.claimPropType[Config.Models[hash].type] then
    --         local inClaimZone = false
    --         for k,v in pairs(propsalreadyspowned) do
    --             if v.identifier == identifier and Config.claimPropType[Config.Models[v.hash].type] then
    --                 if GetDistanceXY(coords,v.coords) < (Config.claimPropType[Config.Models[v.hash].type].radius * 0.9) then
    --                     inClaimZone = true
    --                     break
    --                 end
    --             end
    --         end

    --         if not inClaimZone then
    --             if enableMessage then
    --                 ShowNotification("You can only build in a claim zone")
    --             end
    
    --             return false
    --         end
    --     else
    --         for k,v in pairs(propsalreadyspowned) do
    --             if v.identifier == identifier and Config.claimPropType[Config.Models[hash].type] then
    --                 if enableMessage then
    --                     ShowNotification("You can only have one territory")
    --                 end
        
    --                 return false
    --             end
    --         end
    --     end
    -- end

   
    if Config.poolSizeProtection then

        local poolSize = #GetGamePool('CObject')
        
        
        if poolSize > Config.poolSizeProtection then

            if enableMessage then
                ShowNotification(Config.Locales["to_much_props"])
            end

            return false
        end

    end
    
    if Config.disableBuilding then
        for k,v in ipairs(Config.disableBuilding) do
            if GetDistanceXY(coords,v.coords) < v.radius then
                
                if enableMessage then
                    ShowNotification(Config.Locales["no_build_zone"])
                end

                return false
            end
        end
    end

    if Config.maxPropsPerIdentifier then
        local myPropsCount = 0
        for k,v in pairs(props) do
            if v.identifier == identifier then
                myPropsCount = myPropsCount + 1
            end

            if myPropsCount >= Config.maxPropsPerIdentifier then
                if enableMessage then
                    ShowNotification(Config.Locales["build_limit_1"])
                end
                return false
            end
        end
    end


    local radiusInfo = 0
    if Config.claimPropType[Config.Models[hash].type] then
        radiusInfo = Config.claimPropType[Config.Models[hash].type].radius
    end

    if myCrew and hasCrewPermission(identifier,nil,"canBuild") then
        for k,v in pairs(propsalreadyspowned) do
            if Config.claimPropType[Config.Models[v.hash].type] then
                if not myCrew.data[v.identifier]  then
                    if GetDistanceXY(coords,v.coords) < (Config.claimPropType[Config.Models[v.hash].type].radius + radiusInfo) then
                        if enableMessage then
                            ShowNotification(Config.Locales["you_claim_zone"])
                        end

                        return false
                    end
                end
            end
        end
    else
        for k,v in pairs(propsalreadyspowned) do
        
            if Config.claimPropType[Config.Models[v.hash].type] then

                if v.identifier ~= identifier then
                    
                    if GetDistanceXY(coords,v.coords) < (Config.claimPropType[Config.Models[v.hash].type].radius + radiusInfo) then
                        if enableMessage then
                            ShowNotification(Config.Locales["you_claim_zone"])
                        end

                        return false
                    end
                end
            end
        end
    end



    return true
end

---------------------------------- BLACK SCREEN AND LOADING BASES --------------------------------------

function generateLoadingMessage()
    local loadingMessage = "Loading Base Building Models"

    if fade.currentModel and fade.maxModel then
        if fade.currentModel == fade.maxModel then
            loadingMessage = "Loading Bases Around You"
        else
            loadingMessage = loadingMessage .. " "..fade.currentModel.."/"..fade.maxModel
        end
    end
    return loadingMessage
end

function fadeSystem()

    local loadingMessage = "Loading Base Building Models"

    SendNUIMessage({loading = "show", message = generateLoadingMessage()})

    FreezeEntityPosition(PlayerPedId(),true)
    -- AddTextEntry("CUSTOMLOADSTR", "Bases Loading...")
    -- BeginTextCommandBusyspinnerOn("CUSTOMLOADSTR")
    -- EndTextCommandBusyspinnerOn(4)
    -- Wait(1000)
    
    CreateThread(function()
        while fade do
            SendNUIMessage({loading = "show", message = generateLoadingMessage()})
            Wait(100)
           
        --     if not IsScreenFadedOut() then
        --         DoScreenFadeOut(0)
        --     end
        end
        FreezeEntityPosition(PlayerPedId(),false)  
        --BusyspinnerOff()
        -- DoScreenFadeIn(1000)
        TriggerEvent('hrs_base_building:allLoaded')

        SendNUIMessage({loading = "hide"})
    end)
end


local outlineBool = true

function canSpawnOutline(ent,bool)
    if bool then
        SetEntityDrawOutline(ent,true)
        SetEntityDrawOutlineColor(0, 128, 0, 50)
    else
        SetEntityDrawOutline(ent,true)
        SetEntityDrawOutlineColor(255, 0, 0, 50)
    end

    outlineBool = bool
end

------------------------------------- TEST EVENTS ---------------------------------------
AddEventHandler('example:event', function(arg1,arg2,arg3,arg4)
    print(arg1,arg2,arg3,arg4)
end)

AddEventHandler('hrs_base_building:Regen', function(testEnt,type,anim,headingchange)
    local testEntcoords = GetEntityCoords(testEnt)
    local heading = GetEntityHeading(testEnt)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local myPed = PlayerPedId()

    local isEmpty = true

    for k,v in ipairs(GetActivePlayers()) do
        if myPed ~= GetPlayerPed(v) then
            if #(testEntcoords - GetEntityCoords(GetPlayerPed(v))) < 1.2 then
                isEmpty = false
                break
            end
        end
    end

    if isEmpty then
        FreezeEntityPosition(myPed,true)
        SetEntityCoords(myPed,testEntcoords.x,testEntcoords.y,testEntcoords.z)

        SetEntityHeading(myPed,heading + headingchange)

        if progressBar(anim) then
            SetEntityHealth(myPed,GetEntityMaxHealth(myPed))
            ShowNotification("Life Regenerated") 
        end

        SetEntityCoords(myPed,pedCoords.x,pedCoords.y,pedCoords.z)
        FreezeEntityPosition(myPed,false)
    else
        ShowNotification("There is someone else sleeping")
    end
end)

-------------HTML
local display = false

function DoorMenu(id,lifepercent,upgrade)
    display = true
	SetNuiFocus(true,true)
	SendNUIMessage(
		{
            display = display,
            type = "Interact",
            isdoor = true,
            PropId = id,
            life = lifepercent,
            upgrade = upgrade
		}
	)
end

function get24base()
    local itemsList = {}
    for k,v in pairs(propsalreadyspowned) do
        if hasPermissionVeh(identifier,v.identifier) then
            local testList = getRepairMaterialsCheck24(v.hash)
            for k2,v2 in pairs(testList) do
                if not itemsList[v2.name] then
                    itemsList[v2.name] = v2.count
                else
                    itemsList[v2.name] = itemsList[v2.name] + v2.count
                end
            end
        end
    end
    local itemsList2 = {}
    for k,v in pairs(itemsList) do
        table.insert(itemsList2,{name = k, count = v})
    end
    return itemsList2
end

function OtherPropMenu(id,data,metadata,list)
    props[id].life = data.life
    props[id].fuel = data.fuel

    if list then
        for k,v in pairs(list) do
            if props[k] then
                props[k].life = v
            end
        end
    end

    local itemsList = {}

    local bars = {}
    if props[id].life then
        table.insert(bars,{
            max = Config.Models[props[id].hash].life,
            val = props[id].life,
            labelLeft = "Health"
        })
    end

    if props[id].fuel then
        if Config.Models[props[id].hash].bulletItem then
            table.insert(bars,{
                max = Config.Models[props[id].hash].maxAmmo,
                val = props[id].fuel,
                labelLeft = "Ammo",
                color = "rgba(220, 131, 15, 0.447)"
            })

            table.insert(itemsList, {name = Config.Models[props[id].hash].bulletItem, count = props[id].fuel, limit = Config.Models[props[id].hash].maxAmmo})
        else
            table.insert(bars,{
                max = Config.Models[props[id].hash].fuelTank,
                val = props[id].fuel,
                labelLeft = "Fuel",
                color = "rgba(220, 131, 15, 0.447)"
            })

            local fuelItem = Config.Models[props[id].hash].fuelItem or Config.fuelItem

            table.insert(itemsList, {name = fuelItem, count = props[id].fuel, limit = Config.Models[props[id].hash].fuelTank})
        end
    end

    if Config.Models[props[id].hash].type == "battery" then
        table.insert(bars,{
            max = Config.Models[props[id].hash].energyCapacity,
            val = Round(metadata.energy or 0),
            labelLeft = "Energy (Wh)",
            color = "rgba(220, 131, 15, 0.447)"
        })
    end



    if Config.Models[props[id].hash]?.itemStock then
        for k,v in pairs(Config.Models[props[id].hash]?.itemStock) do
            table.insert(itemsList,{
                name = k,
                count = metadata?.items?[k] or 0,
                limit = v
            })
        end
    end

    local actions = {}

    table.insert(actions,{
        img = "repair_icon",
        action = "repairprop",
        description = {
            labelLeft = "Repair items needed",
            items = getRepairMaterials(id)
        }
    })

    table.insert(actions,{
        img = "delete_icon",
        action = "deleteprop",
        description = {
            labelLeft = "Return items",
            items = getReturnMaterials(id)
        }
    })
    
    if Config.Models[props[id].hash].upgrade then
        table.insert(actions,{
            img = "upgrade_icon",
            action = "upgradeprop",
            description = {
                labelLeft = "Upgrade items",
                items = getUpgradeMaterials(Config.Models[props[id].hash].upgrade)
            }
        })
    end

    if Config.Models[props[id].hash].generatorPower or Config.Models[props[id].hash].energyCapacity then

        if data.on then
            table.insert(bars,{
                max = Round(Config.Models[props[id].hash].generatorPower),
                val = Round(data.power or 0),
                labelLeft = "Power Output (W)",
                color = "rgba(220, 131, 15, 0.447)"
            })
        end

    end

    if Config.Models[props[id].hash].type == "powerComb" then

        debug(data)

        local connected_1, generators_1, energyUsers_1, batteries_1, powerDist_1, powerComb_1 = getConnectedObjects(id) 

        local maxPower = 0
        for _,v in ipairs(generators_1) do
            maxPower = maxPower + Config.Models[props[v].hash].generatorPower
        end

        local powerDemand = 0
        for _,v in ipairs(energyUsers_1) do
            if props[v].on then
                powerDemand = powerDemand + Config.Models[props[v].hash].power
            end
        end



        if maxPower > 0 then
            table.insert(bars,{
                max = Round(maxPower),
                val = Round(data.power or 0),
                labelLeft = "Power Output (W)",
                color = "rgba(220, 131, 15, 0.447)"
            })
        end

        if powerDemand > 0 then
            table.insert(bars,{
                max = Round(maxPower),
                val = Round(powerDemand or 0),
                labelLeft = "Power Demand (W)",
                color = "rgba(220, 131, 15, 0.447)"
            })

        end

    end

    if Config.Models[props[id].hash].type == "upkeep" then
        table.insert(actions,{
            img = "basefix_icon",
            action = "fixbase",
            description = {
                labelLeft = "Repair Base items",
                items = getRepairMaterialsList(list)
            }
        })

        table.insert(actions,{
            img = "radar_icon",
            action = "checkupkeepprops",
            description = {
                labelLeft = "Highlight base props in range",
                --items = getRepairMaterialsList(list)
            }
        })

      --  getPropsAroundUpkeep(upkeepId)
    end

    if Config.Models[props[id].hash].type == "buildFlag" then
        table.insert(actions,{
            img = "radar_icon",
            action = "checkBuildFlagProps",
            description = {
                labelLeft = "Check props in range",
            }
        })

        table.insert(actions,{
            img = "radar_icon",
            action = "reclaimBuildFlag",
            description = {
                labelLeft = "Claim props in range",
            }
        })
    end



    if Config.Models[props[id].hash]?.itemStock then
        table.insert(actions,{
            img = "boxes",
            action = "stock",
            description = {
                labelLeft = "Manage Stock",
                items = itemsList
            }
        })
    end

    if Config.Models[props[id].hash].bulletItem then
        table.insert(actions,{
            img = 'ammo_icon',
            action = "addammo",
            description = {
                labelLeft = "Manage Ammo",
                items = {
                    {name = Config.Models[props[id].hash].bulletItem, count = props[id].fuel}
                },
            }
        })
    else
        if props[id].fuel then

            local fuelItem = Config.Models[props[id].hash].fuelItem or Config.fuelItem

            table.insert(actions,{
                img = "fuel",
                action = "addfuel",
                description = {
                    labelLeft = "Manage Fuel",
                    items = {
                        {name = fuelItem, count = props[id].fuel}
                    },
                }
            })
        end
    end

    if props[id].dooropen ~= nil or Config.Models[props[id].hash].type == "storages" then
        table.insert(actions,{
            img = "code_icon",
            action = "setcodeprop",
            description = {
                labelLeft = "Set Code"
            }
        })
    end

	display = true

    TriggerScreenblurFadeIn(500)

	SetNuiFocus(true,true)
	SendNUIMessage(
		{
            display = display,
            type = "Interact",
            PropId = id,
            bars = bars,
            actions = actions,
            itemsList = itemsList
		}
	)
end

RegisterNUICallback("itemManagement", function(data)
   -- print(json.encode(data))
    local count = tonumber(data.count)
    if not count or count < 1 then count = 1 end

    if data.action == "add" then
        TriggerServerEvent('hrs_base_building:additemprop',data.id,data.item, count, data.labelLeft)
        return
    end

    if data.action == "remove" then
        TriggerServerEvent('hrs_base_building:removeitemprop',data.id,data.item, count, data.labelLeft)
        return
    end
end)


RegisterNUICallback("action", function(data)
   

    if data.action == "deleteprop" then
        CloseHtml()
        if progressBar('prop_remove') then
            TriggerServerEvent('hrs_base_building:remove',data.id)	
        end
        return
    end



    if data.action == "addfuel" then
        SendNUIMessage(
            {
                display = display,
                type = "Management",
                labelLeft = data.labelLeft,
                PropId = data.id,
                items = data.extra.itemsList
            }
        )
        return
    end

    if data.action == "stock" then
        local message = {
            display = display,
            type = "Management",
            labelLeft = data.labelLeft,
            PropId = data.id,
            items = data.extra.itemsList
        }

        if Config.Models[props[data.id].hash].type == "upkeep" then
            message.description = {
                labelLeft = "Average 24h Upkeep",
                items = get24base()
            }
        end

        SendNUIMessage(message)
        return
    end

    if data.action == "addammo" then
        SendNUIMessage(
            {
                display = display,
                type = "Management",
                labelLeft = data.labelLeft,
                PropId = data.id,
                items = data.extra.itemsList
            }
        )
        return
    end

    if data.action == "upgradeprop" then
        CloseHtml()
        if progressBar("prop_upgrade") then
            TriggerServerEvent('hrs_base_building:upgrade',data.id)	
        end
        return
    end

    if data.action == "connected" then
        CloseHtml()
        local objects = getConnectedObjects(data.id,true)

       -- debug(objects)

        for _,v in ipairs(objects) do
          --  debug(v)
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,true)
                SetEntityDrawOutlineColor(0, 128, 0, 50)
            end
        end
        Wait(5000)
        for _,v in ipairs(objects) do
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,false)
            end
           -- SetEntityDrawOutlineColor(0, 128, 0, 50)
        end

        return
    end

    if data.action == 'checkBuildFlagProps' then
        CloseHtml()
        local ownedProps, ownedIds, notOwnedProps, notOwnedIds, id = getPropsInClaimArea()

        if not id then
            return
        end

        for _,v in ipairs(ownedProps) do
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,true)
                SetEntityDrawOutlineColor(0, 128, 0, 50)
            end
        end

        ShowNotification("There are "..#notOwnedProps.." objects to claim")

        Wait(10000)
        for _,v in ipairs(ownedProps) do
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,false)
            end
        end

        return
    end

    if data.action == 'reclaimBuildFlag' then
        CloseHtml()
        local ownedProps, ownedIds, notOwnedProps, notOwnedIds, id = getPropsInClaimArea()

        if not id then
            return
        end

        if #notOwnedIds < 1 then
            ShowNotification("There are no objects to claim")
        else
            print(id, json.encode(notOwnedIds))
            TriggerServerEvent('hrs_base_building:reclaimObjects', id, notOwnedIds)
        end
    end

    if data.action == "checkupkeepprops" then
        CloseHtml()
        local objects = getPropsAroundUpkeep(data.id,true)

       -- debug(objects)

        for _,v in ipairs(objects) do
          --  debug(v)
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,true)
                SetEntityDrawOutlineColor(0, 128, 0, 50)
            end
        end
        Wait(10000)
        for _,v in ipairs(objects) do
            if DoesEntityExist(v) then
                SetEntityDrawOutline(v,false)
            end
           -- SetEntityDrawOutlineColor(0, 128, 0, 50)
        end

        return
    end


    

    if data.action == "repairprop" then
        CloseHtml()
        if progressBar("prop_repair") then
            local toRepair = data.id
            --local toRepairList = GetPropsRepair(data.id)
            TriggerServerEvent('hrs_base_building:proplifereset',toRepair,toRepairList)
        end
        return
    end

    if data.action == "fixbase" then
        CloseHtml()
        if progressBar("prop_repair") then
            --local toRepair = data.id
            --local toRepairList = getOwnedProps()
            local propsUpkeep = getPropsAroundUpkeep(data.id,false,true)
            TriggerServerEvent('hrs_base_building:propliferesetnew',propsUpkeep)
        end
        return
    end

    

    if data.action == "setcodeprop" then
        SendNUIMessage(
            {
                display = display,
                type = "Code",
                action = "SetCode",
                PropId = data.id
            }
        )
        return
    end

end)

RegisterNUICallback("setcodeprop", function(data)
    CloseHtml()
    Wait(150)
	display = true
	SetNuiFocus(true,true)
	SendNUIMessage(
		{
            display = display,
            type = "Code",
            action = "SetCode",
            PropId = data.id
		}
	)
end)

RegisterNetEvent('hrs_base_building:refreshItems')
AddEventHandler('hrs_base_building:refreshItems', function(data,meta,labelLeft) 
    local itemsList = {}

    local propHashUse = props[data.id].hash
    if props[data.id].dead then
        propHashUse = props[data.id].dead
    end

    if data.fuel then
        if Config.Models[propHashUse].bulletItem then
            table.insert(itemsList, {name = Config.Models[propHashUse].bulletItem, count = data.fuel, limit = Config.Models[propHashUse].maxAmmo})
        else

            local fuelItem = Config.Models[propHashUse].fuelItem or Config.fuelItem

            table.insert(itemsList, {name = fuelItem, count = data.fuel, limit = Config.Models[propHashUse].fuelTank or 10.0})
        end
    end

    if Config.Models[propHashUse]?.itemStock or data.dead then
        for k,v in pairs(Config.Models[propHashUse]?.itemStock) do
            table.insert(itemsList,{
                name = k,
                count = meta?.items?[k] or 0,
                limit = v
            })
        end
    end

    if not display then
        SetNuiFocus(true,true)
        display = true
    end
    
    local message = {
        display = true,
        type = "Management",
        labelLeft = labelLeft,
        PropId = data.id,
        items = itemsList
    }

    if Config.Models[propHashUse].type == "upkeep" and not data.dead then
        message.description = {
            labelLeft = "Average 24h Upkeep",
            items = get24base()
        }
    end

    SendNUIMessage(message)

end)


RegisterNetEvent('hrs_base_building:insertcode')
AddEventHandler('hrs_base_building:insertcode', function(propid,adv)   
    if props[propid] then
        display = true
        SetNuiFocus(true,true)
        SendNUIMessage(
            {
                display = display,
                type = "Code",
                action = "OpenCode",
                PropId = propid,
                adv = adv
            }
        )
    end
end)

RegisterNUICallback("number", function(data)
    CodeNumber = tostring(data.number)

    if data.situation == "SetCode" then
        TriggerServerEvent('hrs_base_building:setcode',data.id,CodeNumber)	
    elseif data.situation == "OpenCode" then
        if data.adv then
            local list = nil

            if Config.Models[props[data.id].hash].type == 'upkeep' then
                list = getOwnedProps()
            end

            TriggerServerEvent('hrs_base_building:advancedInteractServer',data.id,CodeNumber,list)
        else
            local propHash = props[data.id].hash
            if Config.Models[propHash].type == "storages" then
                TriggerServerEvent('hrs_base_building:canopenstorage',data.id,CodeNumber)
            else
                TriggerServerEvent('hrs_base_building:doorstatus',data.id,CodeNumber)
            end
        end
    end

    CloseHtml()
end)

RegisterNUICallback("exit", function(data)
    CloseHtml()
end)

CreateThread(function()
    while true do 
        Wait(100)
        if display and IsEntityDead(PlayerPedId()) then
            CloseHtml()
        end
    end
end)

function CloseHtml()
    TriggerScreenblurFadeOut(500)
	display = false
	SetNuiFocus(false,false)
	SendNUIMessage(
		{
            display = display
		}
	)
end



-- CreateThread(function()
--     while display do
--         Wait(0)
--         DisableControlAction(0, 1, display) -- LookLeftRight
--         DisableControlAction(0, 2, display) -- LookUpDown
--         DisableControlAction(0, 142, display) -- MeleeAttackAlternate
--         DisableControlAction(0, 18, display) -- Enter
--         DisableControlAction(0, 322, display) -- ESC
--         DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
--     end
-- end)


--------------------- TEST STUFF ------------------
-- AddEventHandler('ox_inventory:craftingEvent', function(id)
--     exports.ox_inventory:openInventory('crafting', { id = id, index = id})
-- end)


---- test code -------------------------------------------------------------------------------------------------------------------------


-- CreateThread(function()
--     while true do
--         Wait(0)
        --SetWeaponExplosionRadiusMultiplier(`weapon_stickybomb`,1.0)
        --SetWeaponExplosionRadiusMultiplier(`weapon_rpg`,1.0)
        --SetWeaponDamageModifier(`weapon_stickybomb`,0.01)
        --SetWeaponDamageModifier(`weapon_rpg`,0.01)
--     end
-- end)


--------------------------- DEFENSE UPGRADES --------------
function effectHandlerEntity(asset,name,entity,time,rgba,scale,offset)

    debug("Debug_1",asset,name,entity,time,rgba,scale,offset)

    if not offset then
        offset = vector3(0.0,0.0,0.0)
    end

    if not rgba then
        rgba = {r = 0.0,g = 0.0,b = 0.0,a = 1.0}
    end

    debug("Debug_1",asset,name,entity,time,rgba,scale,offset)

    CreateThread(function()
        local waitTime = 0
        if not HasNamedPtfxAssetLoaded(asset) then

            RequestNamedPtfxAsset(asset)
            while not HasNamedPtfxAssetLoaded(asset) do
                Wait(100)
                waitTime = waitTime + 1
            end
        end
    
        if waitTime <= 5 then

            SetPtfxAssetNextCall(asset)
        
            local fx = StartParticleFxLoopedOnEntity(name,entity, offset.x,offset.y, offset.z, 0.0, 0.0, 0.0,scale, false, false, false, false)
            SetParticleFxLoopedColour(fx, rgba.r, rgba.g, rgba.b, 0)
            SetParticleFxLoopedAlpha(fx, rgba.a)
            
            if time then
                Wait(time)
                StopParticleFxLooped(fx, 0)
            else
                ptfxIds[entity] = fx
            end

        end
    
    end)
end

function damageOnCollision(model,entity)
    local damageOnCollisionSpecs = Config.Models[model].damageOnCollision
    if damageOnCollisionSpecs.damage then
        ApplyDamageToPed(entity,damageOnCollisionSpecs.damage)
    end
    if damageOnCollisionSpecs.ptfx then
        effectHandlerEntity(damageOnCollisionSpecs.ptfx.asset,damageOnCollisionSpecs.ptfx.name,entity,1000,damageOnCollisionSpecs.ptfx.rgba,damageOnCollisionSpecs.ptfx.scale)
    end
end



function damageOnShot(model,entity)
    local weaponDamage = Config.Models[model].bulletDamage or 0
    ApplyDamageToPed(entity,weaponDamage)
end

function isEntityDead(entity)
    return IsEntityDead(entity)
end


------------------------- Solar panel

local weatherConditions = {
    hour = GetClockHours(),
    minutes = GetClockMinutes(),
    weather = 'EXTRASUNNY',
    rain = GetRainLevel(),
    windSpeed = GetWindSpeed()
}

function getWeatherConditions()
    weatherConditions.hour = GetClockHours()
    weatherConditions.minutes = GetClockMinutes()
    weatherConditions.rain = GetRainLevel()
    weatherConditions.windSpeed = GetWindSpeed()

    return weatherConditions
end

-- CreateThread(function()
--     while true do
--         Wait(1000)
--         debug(getWeatherConditions())
--     end
-- end)

RegisterNetEvent('hrs_base_building:getWeather')
AddEventHandler('hrs_base_building:getWeather', function()   
    TriggerServerEvent('hrs_base_building:setWeather', getWeatherConditions())
end)

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    weatherConditions.weather = NewWeather
end)

RegisterNetEvent('qb-weathersync:client:SyncWeather', function(NewWeather, newblackout)
    weatherConditions.weather = NewWeather
end)


-- local debugText = ""
-- CreateThread(function()
--     while true do
--     Wait(0)

--     SetTextFont(0)
--     SetTextProportional(1)
--     SetTextScale(0.0, 0.3)
--     SetTextColour(128, 128, 128, 255)
--     SetTextDropshadow(0, 0, 0, 0, 255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(debugText)
--     DrawText(0.005, 0.005)
--     end
-- end)

-- CreateThread(function()
--     while true do
--         Wait(1000)
--         local CVehicle = GetGamePool('CVehicle')
--         local CPed = GetGamePool('CPed')
--         local CObject = GetGamePool('CObject')
--         local CPickup = GetGamePool('CPickup')

--         local CVehicleN = 0
--         local CPedN = 0
--         local CObjectN = 0
--         local CPickupN = 0

--         for k,v in ipairs(CVehicle) do
--             if NetworkGetEntityIsNetworked(v) then
--                 CVehicleN = CVehicleN + 1
--             end
--         end

--         for k,v in ipairs(CPed) do
--             if NetworkGetEntityIsNetworked(v) then
--                 CPedN = CPedN + 1
--             end
--         end

--         for k,v in ipairs(CObject) do
--             if NetworkGetEntityIsNetworked(v) then
--                 CObjectN = CObjectN + 1
--             end
--         end

--         for k,v in ipairs(CPickup) do
--             if NetworkGetEntityIsNetworked(v) then
--                 CPickupN = CPickupN + 1
--             end
--         end

--         debugText = "CVehicle - "..(#CVehicle)..","..CVehicleN.." ".."CPed - "..(#CPed)..","..CPedN.." ".."CObject - "..(#CObject)..","..CObjectN.." ".."CPickup - "..(#CPickup)..","..CPickupN.." "

--         --print("CVehicle - "..(#CVehicle)..","..CVehicleN.." ".."CPed - "..(#CPed)..","..CPedN.." ".."CObject - "..(#CObject)..","..CObjectN.." ".."CPickup - "..(#CPickup)..","..CPickupN.." ")
--     end
-- end)

-- local blipsList = {}
-- RegisterCommand("testnetobj",function()
--     for k,v in ipairs(blipsList) do
--         RemoveBlip(v)
--     end

--     local CObject = GetGamePool('CObject')
--     for k,v in ipairs(CObject) do
--         if NetworkGetEntityIsNetworked(v) then
--             table.insert(blipsList,AddBlipForEntity(v))
--             print(GetEntityCoords(v))
--         end
--     end
-- end)




function isBaseBuildingEntity(entity)
    if propsalreadyspowned[entity] then return true end
    return false
end

function getPropDataByEntity(entity, key)
	if not propsalreadyspowned[entity] then return nil end

	if key then
		return propsalreadyspowned[entity][key]
	end

	return propsalreadyspowned[entity]
end

function getPropConfigDataByEntity(entity, key)
	if not propsalreadyspowned[entity] then return nil end

	if key then
		return Config.Models[propsalreadyspowned[entity].hash][key]
	end

	return Config.Models[propsalreadyspowned[entity].hash]
end

exports('getPropDataByEntity',getPropDataByEntity)
exports('isBaseBuildingEntity',isBaseBuildingEntity)



RegisterCommand("hidecables", function()
    hideCables = not hideCables
end)



















--------- claim flags -------------

function canBuidFlag(showMessage)
    --for k,v in pairs(props) do
        --if Config.Models[v.hash].type == "buildFlag" then
            --if v.identifier == identifier then
                --if showMessage then
                    --ShowNotification("You Already own a Building Totem")
                --end
                --return false
            -- else
            --     if hasCrewPermission(identifier, v.identifier) then
            --         if showMessage then
            --             ShowNotification("Your  Crew Already owns a Building Totem")
            --         end
            --         return false
            --     end
            --end
        --end
    --end
    return true
end

function getClaimArea(propId)
    local area = {}

    if propId then
        local v = props[propId]
        --area[v.identifier] = {coords = v.coords, radius =  Config.Models[v.hash].buildRadius or 25.0}
        return v.coords, Config.Models[v.hash].buildRadius or 25.0, propId
    else
        for k,v in pairs(props) do
            if Config.Models[v.hash].type == "buildFlag" then
                if v.identifier == identifier or hasCrewPermission(identifier, v.identifier) then
                    area[v.identifier] = {coords = v.coords, radius =  Config.Models[v.hash].buildRadius or 25.0}
                end
            end
        end
    end

    if next(area) then
        return area
    else
        return nil
    end

end

function getPropsInClaimArea(propId)
    local coords, radius, id = getClaimArea(propId)
    --print( coords, radius, id)

    if not coords then
        return nil, nil, nil, nil, nil
    end

    local ownedProps = {}
    local ownedIds = {}
    local notOwnedProps = {}
    local notOwnedIds = {}

    for k,v in pairs(propsalreadyspowned) do
        if v.id ~= id then
            if GetDistanceXY(v.coords,coords) < radius then
                if hasCrewPermission(identifier, v.identifier) then
                    table.insert(ownedProps,k)
                    table.insert(ownedIds,v.id)
                else
                    table.insert(notOwnedProps,k)
                    table.insert(notOwnedIds,v.id)
                end
            end
        end
    end

    return ownedProps, ownedIds, notOwnedProps, notOwnedIds, id
end

function canBuildPropHere(model, coords, showMessage)
    if Config.Models[model].type == "buildFlag" then

        if not canBuidFlag(showMessage) then
            return false
        end

        --local buildRadius = Config.Models[model].buildRadius or 25.0
        -- local buildRadius = 50.0 + 10.0

        -- for k,v in pairs(propsalreadyspowned) do
        --     local propType = Config.Models[v.hash].type

        --     if propType == "buildFlag" then
        --         --local claimRadius = Config.Models[model].buildRadius or 25.0

        --         local claimRadius = 50.0 + 10.0

        --         if GetDistanceXY(v.coords, coords) < buildRadius + claimRadius then
        --             if showMessage then
        --                 ShowNotification("Your are trying to build to close to another claim Totem")
        --             end
        --             return false
        --         end

        --     elseif Config.claimPropType[propType] then
        --         local claimRadius = Config.Models[v.hash].customClaim or Config.claimPropType[propType].radius

        --         if GetDistanceXY(v.coords, coords) < buildRadius + claimRadius then
        --             if showMessage then
        --                 ShowNotification("Your are trying to build to close to a claimed area")
        --             end
        --             return false
        --         end 
        --     end
        -- end
        
        return true
    end

    local area = getClaimArea()

    if not area then
        if showMessage then
            ShowNotification("You need a build Totem to build")
        end
        return false
    end

    for k,v in pairs(area) do
        if GetDistanceXY(coords, v.coords) < v.radius then
            return true
        end
    end

    if showMessage then
        ShowNotification("You can only build inside your build Totem claim radius")
    end
    
    return false

    -- if not claimCoords then
    --     if showMessage then
    --         ShowNotification("You need a build Totem to build")
    --     end
    --     return false
    -- end

    -- if GetDistanceXY(coords, claimCoords) > claimRadius then
    --     if showMessage then
    --         ShowNotification("You can only build inside your build Totem claim radius")
    --     end
    --     return false
    -- else
    --     return true
    -- end

    -- for k,v in pairs(propsalreadyspowned) do
    --     for k,v in pairs(propsalreadyspowned) do
    --         local propType = Config.Models[v.hash].type

    --         if propType == "buildFlag" then

    --             if not hasCrewPermission(identifier, v.identifier) then

    --                 local claimRadius = Config.Models[model].buildRadius or 25.0

    --                 if GetDistanceXY(v.coords, coords) < claimRadius then
    --                     if showMessage then
    --                         ShowNotification("Your are trying to build to close to another claim Totem")
    --                     end
    --                     return false
    --                 end

    --             end

    --         elseif Config.claimPropType[propType] then

    --             if not hasCrewPermission(identifier, v.identifier) then

    --                 local claimRadius = Config.Models[v.hash].customClaim or Config.claimPropType[propType].radius

    --                 if GetDistanceXY(v.coords, coords) < claimRadius then
    --                     if showMessage then
    --                         ShowNotification("Your are trying to build to close to a claimed area")
    --                     end
    --                     return false
    --                 end 
                
    --             end
    --         end
    --     end
    -- end

    --return true
end







function getBaseBuildingProps()
    return props
end

exports("getBaseBuildingProps",getBaseBuildingProps)