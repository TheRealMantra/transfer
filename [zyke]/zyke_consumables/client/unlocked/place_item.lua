local dummyProp

local placeKey = Z.keys.get("LEFTMOUSE")
local rotateKey = Z.keys.get({"SCROLLUP", "SCROLLDOWN"})

local lineColors = {
    {0, 255, 0, 255}, -- In range
    {255, 0, 0, 255}, -- Out of range
}

-- Alpha doesnt't work for outline
local outlineColors = {
    {0, 255, 0}, -- In range
    {255, 0, 0}, -- Out of range
}

-- 360 -> 36 -> 18 -> 9
local rotationSpeed = 18

---@param direction "UP" | "DOWN"
local function rotateProp(direction)
    local prev = GetEntityHeading(dummyProp)

    if (direction == "UP") then
        SetEntityHeading(dummyProp, prev + rotationSpeed)
    elseif (direction == "DOWN") then
        SetEntityHeading(dummyProp, prev - rotationSpeed)
    end
end

---@return Success, FailReason?
function PlaceItem()
    if (HoldingKeys["consumables:use"]) then Z.debug("Attempting to place item, but is busy using item.") return false, "selfOccupied" end
    if (Cache.item == nil) then Z.debug("Attempting to place nil item") return false, "noItemEquipped" end
    if (Cache.placing) then Cache.placing = false return false, "resetting" end

    Cache.placing = true

    local itemSettings = Cache.itemSettings[Cache.item.id]
    dummyProp = CreateObject(itemSettings.props[1].model, 0.0, 0.0, 0.0, false, false, false)
    local min, max = GetModelDimensions(itemSettings.props[1].model)
    local raise = (max - min).z / 2

    SetEntityCollision(dummyProp, false, false)
    FreezeEntityPosition(dummyProp, true)

    ToggleRaycastFromScreen(10.0) -- 0.02ms

    SetEntityDrawOutline(dummyProp, true)

    local lastPlacedTimer = 0
    local canPlace = false

    while (Cache.placing) do
        if (not Cache.item) then break end
        if (HoldingKeys["consumables:use"]) then break end

        local ply = PlayerPedId()
        local plyPos = GetEntityCoords(ply)
        local hasHit, x, y, z = Raycast?.hit == 1, Raycast?.endCoords?.x, Raycast?.endCoords?.y, Raycast?.endCoords?.z
        local currentItemPos = GetEntityCoords(Cache.props[1])

        if (hasHit) then
            -- 0.01ms
            SetEntityAlpha(dummyProp, 102, false)

            -- 0.04-0.06ms
            if (GetGameTimer() - lastPlacedTimer > 5) then
                SetEntityCoords(dummyProp, x, y, z + raise, false, false, false, false)
                canPlace = x ~= nil and (GetPlayerReachToPosition(plyPos, vector3(x, y, z)) < Config.Settings.placeDistance) or false
                lastPlacedTimer = GetGameTimer()
            end

            local outlineColor = canPlace and outlineColors[1] or outlineColors[2]
            SetEntityDrawOutlineColor(outlineColor[1], outlineColor[2], outlineColor[3], 255)

            -- 0.01ms
            local lineColor = canPlace and lineColors[1] or lineColors[2]
            DrawLine(currentItemPos.x, currentItemPos.y, currentItemPos.z, Raycast.endCoords.x, Raycast.endCoords.y, Raycast.endCoords.z + raise, lineColor[1], lineColor[2], lineColor[3], lineColor[4])
        end

        DisableControlAction(0, placeKey.keyCode, true)
        if (IsDisabledControlJustPressed(0, placeKey.keyCode)) then
            if (canPlace) then
                local res, reason = UnequipItem({type = 2, pos = vector4(x, y, z, GetEntityHeading(dummyProp))})
                if (reason) then Z.notify(reason) end

                break
            else
                Z.notify("tooFarToPlace")
            end
        end

        -- Handle rotation
        DisableControlAction(0, rotateKey[1].keyCode, true)
        DisableControlAction(0, rotateKey[2].keyCode, true)
        if (IsDisabledControlPressed(0, rotateKey[1].keyCode)) then
            rotateProp("DOWN")
        elseif (IsDisabledControlPressed(0, rotateKey[2].keyCode)) then
            rotateProp("UP")
        end

        Wait(1)
    end

    Cache.placing = false -- If cancelled due to item not existing
    ToggleRaycastFromScreen(0.0)
    DeleteEntity(dummyProp)

    return true
end

---@type RaycastProps
Raycast = {
    active = false,
    hit = false,
    entityHit = nil,
    endCoords = nil,
    surfaceNormal = nil,
    materialHash = nil,
}

function ToggleRaycastFromScreen(distance)
    local function rotationToDirection(rotation)
        local radiansX = math.rad(rotation.x)
        local radiansZ = math.rad(rotation.z)
        local num = math.abs(math.cos(radiansX))
        return vector3(-math.sin(radiansZ) * num, math.cos(radiansZ) * num, math.sin(radiansX))
    end

    Raycast.active = not Raycast.active

    if (not Raycast.active) then
        Raycast = {
            active = false,
            hit = false,
            entityHit = nil,
            endCoords = nil,
            surfaceNormal = nil,
            materialHash = nil,
        }

        return
    end

    CreateThread(function()
        while (Raycast.active == true) do
            local camera = GetGameplayCamCoord()
            local cameraRot = GetGameplayCamRot(2)
            local direction = rotationToDirection(cameraRot)
            local endPoint = camera + (direction * (distance or 10.0))
            local _, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResult(StartShapeTestRay(camera.x, camera.y, camera.z, endPoint.x, endPoint.y, endPoint.z, -1, PlayerPedId(), 0))

            Raycast.hit = hit
            Raycast.entityHit = entityHit
            Raycast.endCoords = endCoords
            Raycast.surfaceNormal = surfaceNormal
            Raycast.materialHash = materialHash

            Wait(25)
        end
    end)
end
