-- Managing the target menu for props

local lastGatheredNearby = 0
local registeredTarget = {}
---@param itemId ActiveItemId
---@param prop Prop
local function addToTarget(itemId, prop)
    if (not registeredTarget[itemId]) then
        local options = {
            {
                label = T("pickupItem"),
                icon = "fa-solid fa-arrow-up",
                canInteract = function()
                    return GetPlayerReachToPosition(GetEntityCoords(PlayerPedId()), GetEntityCoords(prop)) < Config.Settings.pickupDistance
                end,
                onSelect = function()
                    local res, reason = PickupItem(itemId)
                    if (reason) then Z.notify(reason) end
                end
            },
        }

        if (Config.Settings.debug == true) then
            options[#options+1] = {
                label = "Debug Info",
                icon = "fa-solid fa-flask-vial",
                onSelect = function ()
                    local itemData = Z.callback.await("zyke_consumables:GetItemData", itemId)
                    Z.debug(json.encode(itemData))
                end
            }
        end

        registeredTarget[itemId] = Z.target.addEntity(prop, {
            options = options
        })
    end
end

local nearby = {}
local function gatherNearby()
    nearby = {}

    local plyPos = GetEntityCoords(PlayerPedId())

    for itemId, netId in pairs(Cache.worldItems) do
        local doesExist = NetworkDoesNetworkIdExist(netId)
        if (not doesExist) then goto continue end

        local prop = NetworkGetEntityFromNetworkId(netId)
        if (not prop or not DoesEntityExist(prop)) then goto continue end

        local propPos = GetEntityCoords(prop)
        local dst = #(plyPos - propPos)

        if (dst < 50) then
            local min, max = GetModelDimensions(GetEntityModel(prop))
            local raise = ((max - min).z / 2) + 0.15

            nearby[itemId] = {
                prop = prop,
                raise = raise
            }

            if (Target) then
                addToTarget(itemId, prop)
            end
        end

        ::continue::
    end
end

-- TODO: Remove/add to the list instead of total refresh for performance
RegisterNetEvent("zyke_consumables:WorldItemRemoved", function(activeItemId)
    lastGatheredNearby = 0
end)

RegisterNetEvent("zyke_consumables:WorldItemCreated", function(activeItemId)
    lastGatheredNearby = 0
end)

if (Target) then
    Z.debug("Running taget world_item_interaction loop")

    CreateThread(function()

        local colors = {
            {255, 255, 255, 255}, -- In vicinity
            {76, 175, 80, 255}, -- Can reach
        }

        while (1) do
            local ply = PlayerPedId()
            local plyPos = GetEntityCoords(ply)
            local sleep = 100

            if (GetGameTimer() - lastGatheredNearby > 3000) then
                gatherNearby()
                lastGatheredNearby = GetGameTimer()
            end

            if (Z.target.isTargeting()) then
                sleep = 1

                for itemId, details in pairs(nearby) do
                    local prop = details.prop
                    -- Z.draw3dText(pos, itemId, 0.3)
                    local propPos = GetEntityCoords(prop)

                    -- Targeting stuff
                    local dst = GetPlayerReachToPosition(plyPos, GetEntityCoords(prop))
                    local isInVicinity = dst < Config.Settings.pickupDistance * 5
                    local isWithinReach = dst < Config.Settings.pickupDistance

                    if (isInVicinity) then
                        local color = isWithinReach and colors[2] or colors[1]
                        local size = 0.08

                        ---@diagnostic disable-next-line: param-type-mismatch
                        DrawMarker(2, propPos.x, propPos.y, propPos.z + details.raise, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, size, size, size, color[1], color[2], color[3], color[4], false, false, false, true, nil, nil, nil)
                    end
                end
            end

            for itemId, targetId in pairs(registeredTarget) do
                if (not nearby[itemId]) then
                    Z.target.remove(targetId)
                    registeredTarget[itemId] = nil
                end
            end

            Wait(sleep)
        end
    end)
else
    -- Non-target version
    Z.debug("Running non-taget world_item_interaction loop")

    CreateThread(function()
        local tblCount = 0
        local scrollIdx = 1
        local activationButton = Z.keys.get(Config.Settings.interactActivationButton)
        local confirmButton = Z.keys.get("LEFTMOUSE")

        while (1) do
            local ply = PlayerPedId()
            local plyPos = GetEntityCoords(ply)
            local sleep = tblCount > 0 and 1 or 1000
            local shouldDisplay = IsControlPressed(0, activationButton.keyCode) or IsDisabledControlPressed(0, activationButton.keyCode)

            if (GetGameTimer() - lastGatheredNearby > 3000) then
                gatherNearby()
                lastGatheredNearby = GetGameTimer()
                tblCount = Z.table.count(nearby)
            end

            local inReach = {}
            if (shouldDisplay) then
                for itemId, details in pairs(nearby) do
                    local prop = details.prop
                    local propPos = GetEntityCoords(prop)
                    local dst = GetPlayerReachToPosition(plyPos, propPos)

                    if (dst < Config.Settings.pickupDistance) then
                        inReach[#inReach+1] = {itemId = itemId, prop = prop}

                        local color = scrollIdx == #inReach and {76, 175, 80, 255} or {255, 255, 255, 255}
                        local size = 0.08

                        ---@diagnostic disable-next-line: param-type-mismatch
                        DrawMarker(2, propPos.x, propPos.y, propPos.z + details.raise, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, size, size, size, color[1], color[2], color[3], color[4], false, false, false, true, nil, nil, nil)
                    end
                end
            end

            local totalInReach = #inReach
            if (scrollIdx > totalInReach) then scrollIdx = totalInReach end
            if (scrollIdx <= 0) then scrollIdx = 1 end

            if (shouldDisplay) then
                -- Disabling scoll keys
                DisableControlAction(0, 15, true) -- Scroll up
                DisableControlAction(0, 14, true) -- Scroll down

                if (totalInReach > 0) then
                    if (IsDisabledControlJustPressed(0, 15)) then
                        scrollIdx -= 1

                        if (scrollIdx <= 0) then scrollIdx = totalInReach end
                    elseif (IsDisabledControlJustPressed(0, 14)) then
                        scrollIdx += 1

                        if (scrollIdx > totalInReach) then scrollIdx = 1 end
                    end
                end

                DisableControlAction(0, confirmButton.keyCode, true)
                if (IsDisabledControlJustPressed(0, confirmButton.keyCode)) then
                    local res, reason = PickupItem(inReach[scrollIdx].itemId)
                    if (reason) then Z.notify(reason) end
                end
            end

            Wait(sleep)
        end
    end)
end

---@param activeItemId ActiveItemId
function PickupItem(activeItemId)
    local netId = Cache.worldItems[activeItemId]
    local prop = netId and NetworkDoesNetworkIdExist(netId) and NetworkGetEntityFromNetworkId(netId)
    if (not prop or not DoesEntityExist(prop)) then return false, "noWorldItemLoaded" end

    local res, reason = Z.callback.await("zyke_consumables:PickupItem", activeItemId)
    if (reason) then return res, reason end

    -- Finished it all

    print("Picked up")
end