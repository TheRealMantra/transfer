_GetAnimDuration = GetAnimDuration
---@param anim {dict: string, clip: string}
---@param skipError? boolean
---@return number @0.0 default
function GetAnimDuration(anim, skipError)
    if (not anim or not anim.dict or not anim.clip) then return 0.0 end
    if (not Z.loadDict(anim.dict, skipError)) then return 0.0 end

    return math.floor(_GetAnimDuration(anim.dict, anim.clip) * 10) / 10
end

---@param itemId ItemId
function EnsureProps(itemId)
    CleanCachedProps()

    local itemSettings = Cache.itemSettings[itemId]
    for i = 1, #itemSettings.props do
        local propSettings = itemSettings.props[i]

        local ply = PlayerPedId()
        local spawnPos = GetEntityCoords(ply) - vector3(0, 0, 20.0)

        if (not Z.loadModel(propSettings.model)) then return error(("Model could not be found: %s."):format(propSettings.model)) end
        local prop = CreateObject(propSettings.model, spawnPos.x + 0.0, spawnPos.y + 0.0, spawnPos.z + 0.0, true, true, false)

        local boneIdx = GetPedBoneIndex(ply, math.floor(propSettings.bone))
        AttachEntityToEntity(prop, ply, boneIdx,
            propSettings.offset.x + 0.0,
            propSettings.offset.y + 0.0,
            propSettings.offset.z + 0.0,
            propSettings.rotation.x + 0.0,
            propSettings.rotation.y + 0.0,
            propSettings.rotation.z + 0.0,
            true, true, false, true, 1, true
        )

        Cache.props[i] = prop
    end
end

-- Cleans props and resets the table
function CleanCachedProps()
    if (not Cache.props) then return end

    for i = 1, #Cache.props do
        if (DoesEntityExist(Cache.props[i])) then
            DeleteEntity(Cache.props[i])
        end
    end

    Cache.props = {}
end

---@param itemId ItemId
---@return number? @Bone id or nil
function GetPrimaryBoneId(itemId)
    local settings = Cache.itemSettings[itemId]
    if (not settings) then return end

    return #settings.props > 0 and settings.props[1].bone or nil
end

-- This is purely a visual function, inteded to provide an animation when taking the prop out of your inventory.
-- & responsible for spawning props
---@param itemSettings ItemSettings
function GetItemFromInventory(itemSettings)
    local boneId = GetPrimaryBoneId(itemSettings.id)
    if (boneId) then
        local boneAnim = GetBoneAnimation(boneId, "fromInventory")
        if (boneAnim) then
            if (not Z.loadDict(boneAnim.dict)) then return end

            TaskPlayAnim({
                dict = boneAnim.dict,
                clip = boneAnim.clip,
                blendInSpeed = 2.0,
                blendOutSpeed = 1.0,
                duration = boneAnim.duration,
                flag = 51,
                forceAnim = true,
            })

            Wait(boneAnim.despawnProps)
        end
    end

    EnsureProps(itemSettings.id)
end

---@param itemSettings ItemSettings
function PutItemInInventory(itemSettings)
    local boneId = GetPrimaryBoneId(itemSettings.id)
    if (boneId) then
        local boneAnim = GetBoneAnimation(boneId, "toInventory")
        if (boneAnim) then
            if (not Z.loadDict(boneAnim.dict)) then return end

            TaskPlayAnim({
                dict = boneAnim.dict,
                clip = boneAnim.clip,
                blendInSpeed = 2.0,
                blendOutSpeed = 1.0,
                duration = boneAnim.duration,
                flag = 51,
                forceAnim = true,
            })

            Wait(boneAnim.despawnProps)
        end
    end

    CleanCachedProps()
end

---@param itemSettings ItemSettings
function PlaceItemInWorld(itemSettings)
    local boneId = GetPrimaryBoneId(itemSettings.id)
    if (boneId) then
        local boneAnim = GetBoneAnimation(boneId, "toGround")

        if (boneAnim) then
            if (not Z.loadDict(boneAnim.dict)) then return end

            TaskPlayAnim({
                dict = boneAnim.dict,
                clip = boneAnim.clip,
                blendInSpeed = 2.0,
                blendOutSpeed = 1.0,
                duration = boneAnim.duration,
                flag = 51,
                forceAnim = true,
            })

            Wait(boneAnim.despawnProps)
        end
    end

    FadeItem(100)

    CleanCachedProps()
end

-- When finishing an item, but it is set to discard, we fade it instead of putting it in our inventory
---@param time? integer @Default 500
function FadeItem(time)
    local totalWaitTime = time
    if (totalWaitTime == nil or totalWaitTime == false) then
        time = 500
    end

    local toHit = GetGameTimer() + totalWaitTime

    while (1) do
        local timeLeft = (toHit - GetGameTimer())
        local maxAlpha = 255
        local multiplier = (timeLeft / totalWaitTime)
        local currAlpha = math.floor(multiplier * maxAlpha)

        for _, prop in pairs(Cache.props) do
            SetEntityAlpha(prop, currAlpha, false)
        end

        if (currAlpha < 1) then break end

        Wait(0)
    end

    CleanCachedProps()
end

function SyncUIData()
    local itemData = Cache.item

    SendNUIMessage({
        event = "SetItemData",
        data = {
            id = itemData.id,
            name = itemData.name,
            amount = itemData.amount,
            maxAmount = Cache.itemSettings[itemData.id].amount,
            current = itemData.current
        }
    })
end

---@param itemId ItemId
function GrabItemFromWorld(itemId)
    local boneId = GetPrimaryBoneId(itemId)
    if (boneId) then
        local boneAnim = GetBoneAnimation(boneId, "fromGround")
        if (boneAnim) then
            if (not Z.loadDict(boneAnim.dict)) then return end

            TaskPlayAnim({
                dict = boneAnim.dict,
                clip = boneAnim.clip,
                blendInSpeed = 8.0,
                blendOutSpeed = 8.0,
                duration = boneAnim.duration,
                flag = 51,
                forceAnim = true,
            })

            Wait(boneAnim.despawnProps)
        end
    end

    EnsureProps(itemId)
end

-- TODO: Replace Cache.item.id with inputs to make it more dynamic
-- Actual item data is set in the event that was caught
---@param prevCurrent string
function EquipItem(prevCurrent)
    SetInteracting("equippingItem")

    local itemId = Cache?.item?.id
    if (not itemId) then return end

    local itemSettings = Cache.itemSettings[itemId]

    -- Equipping first time, or re-equipping
    if (prevCurrent == "NONE" or prevCurrent == Z.getIdentifier()) then
        -- From inventory
        GetItemFromInventory(itemSettings)

    elseif (prevCurrent == "WORLD") then
        -- Grab from world
        -- TODO: Temp, fix actual animation
        GrabItemFromWorld(itemSettings.id)
    else
        -- From player
    end

    if (HasIdleStage(itemId)) then
        EnsureIdleStage(itemId)
    end

    SetInteracting(nil)
end

---@param transferData PlayerToPlayerTransferData | PlayerToWorldTransferData | "self"
---@return Success, FailReason?
function UnequipItem(transferData)
    if (Cache.item == nil) then Z.debug("Attempting to unequip nil item") return false, "noItemEquipped" end

    local itemId = Cache?.item?.id
    if (not itemId) then return false, "noItemEquipped" end

    local itemSettings = Cache.itemSettings[itemId]

    Z.debug("Attempting to unequip", json.encode(Cache.item))

    SetInteracting("unEquippingItem")

    local res, reason = Z.callback.await("zyke_consumables:UnequipItem", Cache.item.activeItemId, transferData)
    if (not res) then SetInteracting(nil) return false, reason end

    if (transferData == "self") then
        if (Cache.item.amount < 1 and itemSettings.discard == true) then
            FadeItem(100)
        else
            PutItemInInventory(itemSettings)
        end
    elseif (transferData.type == 1) then
        PlaceItemInWorld(itemSettings)
    else
        PlaceItemInWorld(itemSettings)
    end

    SendNUIMessage({event = "UnequipItem"})
    Cache.item = nil

    StopCurrentAnim()

    SetInteracting(nil)
    return true
end

function RefreshItemSettings()
    Cache.itemSettings, Cache.itemSettingsIdx = Z.callback.await("zyke_consumables:GetItemSettings")
end

function RefreshConsumptionRewards()
    Cache.consumptionRewards = Z.callback.await("zyke_consumables:GetConsumptionRewards")
end

function RefreshIngredients()
    Cache.ingredients, Cache.ingredientsIdx = Z.callback.await("zyke_consumables:GetIngredients")
end