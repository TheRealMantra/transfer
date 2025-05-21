local QBCore = exports['qb-core']:GetCoreObject()
local blips = {}
local currentRental = nil
local rentalPeds = {}
local inRentalZone = false
local currentLocation = nil

-- Function to get ground Z coordinate
local function GetGroundZ(x, y, z)
    local ground, groundZ = GetGroundZFor_3dCoord(x, y, z + 0.5, false)
    if ground then
        return groundZ
    end
    return z
end

-- Create blips and peds
CreateThread(function()
    for _, location in pairs(Config.RentalLocations) do
        -- Create blip
        if location.blip then
            local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
            SetBlipSprite(blip, location.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, location.blip.scale)
            SetBlipColour(blip, location.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(location.blip.label)
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)
        end

        -- Create ped
        if location.ped then
            local model = GetHashKey(location.ped.model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(1)
            end

            local groundZ = GetGroundZ(location.coords.x, location.coords.y, location.coords.z)
            local ped = CreatePed(4, model, location.coords.x, location.coords.y, groundZ, location.ped.heading, false, true)
            SetEntityHeading(ped, location.ped.heading)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedCanRagdoll(ped, false)
            SetPedCanBeTargetted(ped, false)
            SetPedCanBeDraggedOut(ped, false)
            SetPedCanRagdollFromPlayerImpact(ped, false)
            SetPedRagdollOnCollision(ped, false)
            TaskStartScenarioInPlace(ped, location.ped.scenario, 0, true)
            table.insert(rentalPeds, ped)
        end
    end
end)

-- Check distance to rental locations
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)
        local inZone = false
        local location = nil

        for i, rentalLocation in pairs(Config.RentalLocations) do
            local distance = #(pos - vector3(rentalLocation.coords.x, rentalLocation.coords.y, rentalLocation.coords.z))
            if distance < 2.0 then
                sleep = 0
                inZone = true
                location = i
                break
            end
        end

        if inZone ~= inRentalZone or location ~= currentLocation then
            inRentalZone = inZone
            currentLocation = location
        end

        Wait(sleep)
    end
end)

-- Display prompt and handle key press
CreateThread(function()
    while true do
        local sleep = 1000
        if inRentalZone and currentLocation then
            sleep = 0
            if currentRental then
                DrawText3D(Config.RentalLocations[currentLocation].coords.x, Config.RentalLocations[currentLocation].coords.y, Config.RentalLocations[currentLocation].coords.z + 1.0, "Press [E] to return bike")
            else
                DrawText3D(Config.RentalLocations[currentLocation].coords.x, Config.RentalLocations[currentLocation].coords.y, Config.RentalLocations[currentLocation].coords.z + 1.0, "Press [E] to rent a bike")
            end
            
            if IsControlJustPressed(0, 38) then -- E key
                if currentRental then
                    TriggerEvent('qm-bikerental:client:returnVehicle')
                else
                    OpenRentalMenu(currentLocation)
                end
            end
        end
        Wait(sleep)
    end
end)

-- Function to draw 3D text
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35
    
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
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

-- Open rental menu
function OpenRentalMenu(location)
    local menu = {
        {
            header = "Bike Rental",
            isMenuHeader = true
        }
    }

    for _, vehicle in pairs(Config.RentalLocations[location].vehicles) do
        menu[#menu + 1] = {
            header = vehicle.label,
            txt = string.format("Price: $%d for %d minutes", vehicle.price, vehicle.time),
            params = {
                event = "qm-bikerental:client:rentVehicle",
                args = {
                    model = vehicle.model,
                    price = vehicle.price,
                    time = vehicle.time,
                    location = location
                }
            }
        }
    end

    menu[#menu + 1] = {
        header = "⬅ Close",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }

    exports['qb-menu']:openMenu(menu)
end

-- Rent vehicle
RegisterNetEvent('qm-bikerental:client:rentVehicle', function(data)
    local location = Config.RentalLocations[data.location]
    local groundZ = GetGroundZ(location.coords.x + 2.0, location.coords.y, location.coords.z)
    local spawnPoint = vector4(location.coords.x + 2.0, location.coords.y, groundZ, location.coords.w)
    
    if IsAnyVehicleNearPoint(spawnPoint.x, spawnPoint.y, spawnPoint.z, 2.0) then
        QBCore.Functions.Notify(Config.Messages.error.blocked_spawn, 'error')
        return
    end

    QBCore.Functions.TriggerCallback('qm-bikerental:server:rentVehicle', function(success, netId)
        if success then
            local vehicle = NetToVeh(netId)
            
            if not DoesEntityExist(vehicle) then
                return
            end
            
            -- Set up vehicle
            local plate = "RENT"..math.random(1000, 9999)
            SetVehicleNumberPlateText(vehicle, plate)
            
            -- Set fuel using native function as fallback
            SetVehicleFuelLevel(vehicle, 100.0)
            
            -- Set vehicle ownership and keys
            local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicle)
            if vehicleProps then
                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
                TriggerEvent('vehiclekeys:client:SetOwner', plate)
                SetVehicleEngineOn(vehicle, true, true, false)
                
                -- Ensure vehicle ownership
                local playerId = PlayerId()
                local serverId = GetPlayerServerId(playerId)
                TriggerServerEvent('qb-vehiclekeys:server:GiveVehicleKeys', plate, serverId)
                
                -- Put player in vehicle
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                
                -- Set current rental
                currentRental = {
                    vehicle = vehicle,
                    time = data.time,
                    price = data.price
                }
                
                QBCore.Functions.Notify(string.format(Config.Messages.success.vehicle_rented, data.time), 'success')
            else
                QBCore.Functions.Notify('Failed to get vehicle properties', 'error')
                DeleteEntity(vehicle)
            end
        end
    end, data.model, data.price, data.time, spawnPoint)
end)

-- Return vehicle
RegisterNetEvent('qm-bikerental:client:returnVehicle', function()
    if not currentRental then
        QBCore.Functions.Notify(Config.Messages.error.no_vehicle, 'error')
        return
    end

    local vehicle = currentRental.vehicle
    if not DoesEntityExist(vehicle) then
        QBCore.Functions.Notify(Config.Messages.error.missing_vehicle, 'error')
        currentRental = nil
        return
    end

    local ped = PlayerPedId()
    if not IsPedInVehicle(ped, vehicle, false) then
        QBCore.Functions.Notify(Config.Messages.error.not_in_vehicle, 'error')
        return
    end

    QBCore.Functions.TriggerCallback('qm-bikerental:server:returnVehicle', function(success, refund)
        if success then
            -- Remove vehicle keys
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('qb-vehiclekeys:server:RemoveVehicleKey', plate)
            
            -- Delete vehicle
            DeleteEntity(vehicle)
            currentRental = nil
            QBCore.Functions.Notify(string.format(Config.Messages.success.vehicle_returned, refund), 'success')
        end
    end, currentRental.price, currentRental.time)
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    for _, ped in pairs(rentalPeds) do
        DeleteEntity(ped)
    end
    if currentRental and DoesEntityExist(currentRental.vehicle) then
        DeleteEntity(currentRental.vehicle)
    end
end) 