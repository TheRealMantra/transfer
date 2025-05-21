---@param plyId PlayerId
function IsOccupied(plyId)
    if (Cache.consuming[plyId]?.queueRemoval == true) then return true end -- To avoid timing issues, right when you stop consuming and until it has been processed
    if (Cache.playerItems[plyId] ~= nil) then return true end -- If you have an item
    if (Player(plyId).state["zyke_consumables:interacting"]) then return true end -- If you are interacting with an item

    return false
end

exports("IsOccupied", IsOccupied)

---@param tbl table @To check if it exists
function CreateItemId(tbl)
    while (1) do
        local id = Z.createUniqueId(20)

        if (not tbl[id]) then return id end
    end
end

---@param plyId PlayerId
---@param itemId ActiveItemId
---@return Success, FailReason?
function EquipItem(plyId, itemId)
    local itemData = Cache.items[itemId]

    Z.debug(plyId, "is attempting to equip", json.encode(itemData))
    if (not itemData) then return false, "noItemData" end

    local plyIdentifier = Z.getIdentifier(plyId)
    if (not plyIdentifier) then return false, "noIdentifier" end

    local prevCurr = itemData.current

    if (IsOccupied(plyId)) then return false, "selfOccupied" end

    -- Equipping first time, or re-equipping
    if (itemData.current == "NONE" or itemData.current == plyIdentifier) then
        Cache.playerItems[plyId] = itemId
    elseif (itemData.current == "WORLD") then
        local plyPos = GetEntityCoords(GetPlayerPed(plyId))
        local itemPos = vector3(itemData.position.x, itemData.position.y, itemData.position.z)

        if (GetPlayerReachToPosition(plyPos, itemPos) > Config.Settings.pickupDistance) then return false, "tooFarToPickup" end

        local status, err = AuthorizeRemovalFromWorld(itemId, plyId)
        if (err) then return status, err end

        RemoveWorldItem(itemId)

        Cache.playerItems[plyId] = itemId
    else
        -- If via player, don't accept, first make sure it is dequipped from the other player
        return false, "alreadyEquipped"
    end

    Cache.items[itemId].current = plyIdentifier
    Cache.authorizedWorldRemovals[itemId] = nil

    UpdateItemInDatabase(itemId)

    -- Send to the client to perform the equip, and include that it is a pickup from the world
    TriggerClientEvent("zyke_consumables:EquipItem", plyId, Cache.items[itemId], prevCurr)

    return true
end

-- Constructs the required metadata for a specific item
---@param itemId ItemId
---@param activeItemId? ActiveItemId
---@param metadataIngredients? MetadataIngredient[]
---@return table | nil
function ConstructItemMetadata(itemId, activeItemId, metadataIngredients)
    -- Configured item settings
    local itemSettings = Cache.itemSettings[itemId]

    -- Ensure metadata exists, and use the previous if one exists
    local prevMetadata = Cache.items[activeItemId]?.metadata
    local metadata = prevMetadata and Z.table.copy(prevMetadata) or {}

    local value = itemSettings.amount
    if (activeItemId) then
        value = Cache.items[activeItemId].amount
    end

    -- Static data we set no matter what
    metadata.description = T("itemDescription:" .. itemSettings.type, {math.floor(value)})
    metadata.value = value
    metadata.itemId = itemId

    -- Since the item is infinite, we need to modify the label & image
    if (itemSettings.infinite) then
        local label = itemSettings.label
        local image = itemSettings.image

        if (not image or image == "") then
            image = Config.Settings.infiniteItems.defaultImage
        end

        metadata.label = label
        metadata.imageurl = image
    end

    -- If we are using ingredients, cache the used ones in the metadata
    if (itemSettings.rewardType == "ingredients") then
        -- If we provide ingredients, we will use them first
        if (metadataIngredients) then
            metadata.ingredients = metadataIngredients
        elseif (activeItemId) then
            -- If we didn't provide ingredients, use the cached ones
            metadata.ingredients = Cache.items[activeItemId].metadata.ingredients
        else
            -- If directly added without processing anything, we need to add all of the ingredients to it
            -- For example, running the AddItem export instantly, giving item via menu etc

            ---@type MetadataIngredient[]
            metadata.ingredients = {}
            for i = 1, #itemSettings.ingredients do
                local ingredient = itemSettings.ingredients[i]
                local name = ingredient.name
                local amount = ingredient.amount

                for _ = 1, amount do
                    metadata.ingredients[#metadata.ingredients+1] = {name = name, metadata = {quality = 100.0}}
                end
            end
        end
    elseif (itemSettings.rewardType == "consumptionRewards") then
        -- Ensure we have quality metadata for the item, for raw consumption rewards we use one quality
        if (not metadata.quality) then metadata.quality = 100.0 end
    end

    -- Ensure timestamps exist so we can handle quality
    -- If they already exist, don't overwrite them
    if (not metadata.created) then metadata.created = os.time() end
    if (not metadata.lastDecay) then metadata.lastDecay = os.time() end

    return metadata
end

---@param plyId PlayerId
---@param activeItemId ActiveItemId
---@param transferData PlayerToPlayerTransferData | PlayerToWorldTransferData | "self"
---@return Success, FailReason?
function UnequipItem(plyId, activeItemId, transferData)
    local itemData = Cache.items[activeItemId]
    if (not itemData) then return false, "noItemData" end

    local plyIdentifier = Z.getIdentifier(plyId)
    if (not plyIdentifier) then return false, "noIdentifier" end

    local isOwner = itemData.current == plyIdentifier
    if (not isOwner) then return false, "notAuthorized" end

    if (transferData == "self") then
        local itemSettings = Cache.itemSettings[itemData.id]

        if (itemSettings) then
            local shouldGiveItem = itemSettings.discard ~= true or (itemSettings.discard == true and itemData.amount >= 1)
            if (shouldGiveItem) then
                -- Put back into inventory
                AddItem(plyId, itemSettings.id, 1, activeItemId)
            end
        end

        RemoveItemFromDatabase(activeItemId)

        Cache.items[activeItemId] = nil
        Cache.playerItems[plyId] = nil
    elseif (transferData.type == 1) then
        -- Player to player
        local newOwner = Z.getIdentifier(transferData.newOwner)
        if (not newOwner) then return false, "noIdentifier2" end

        -- UpdateItemInDatabase(itemId)

        itemData.current = newOwner
    else
        local pos = vector4(transferData.pos.x, transferData.pos.y, transferData.pos.z, transferData.pos.w)
        local plyPos = GetEntityCoords(GetPlayerPed(plyId))
        local placementPos = vector3(pos.x, pos.y, pos.z)
        if (GetPlayerReachToPosition(plyPos, placementPos) > Config.Settings.placeDistance) then return false, "tooFarToPlace" end

        -- Player to world
        Cache.playerItems[plyId] = nil

        Cache.items[activeItemId].current = "WORLD"
        Cache.items[activeItemId].position = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
            w = pos.w,
            bucketId = GetPlayerRoutingBucket(tostring(plyId))
        }

        EnsureWorldItem(activeItemId)
        UpdateItemInDatabase(activeItemId)
    end

    return true
end

-- Run when the item should be removed from the world, to grant permission
-- Also verifies if it is already authorized, to block duplicate requests
---@param itemId ActiveItemId
---@param plyId PlayerId
---@return Success, FailReason?
function AuthorizeRemovalFromWorld(itemId, plyId)
    local prevData = Cache.authorizedWorldRemovals[itemId]
    if (prevData) then
        -- If there is a previous request, check if it is an old one

        local isOld = os.time() - prevData.time > 10
        if (not isOld) then return false, "alreadyBeingInteracted" end
    end

    Cache.authorizedWorldRemovals[itemId] = {
        plyId = plyId,
        time = os.time()
    }

    return true
end

---@param itemId ActiveItemId
---@return Success
function InsertItemToDatabase(itemId)
    Z.debug("Attempting to insert", itemId, "from database...")

    local itemData = Cache.items[itemId]
    if (not itemData) then return false end

    MySQL.insert.await("INSERT INTO zyke_consumables (itemId, data) VALUES (?, ?)", {itemId, json.encode(itemData)}) -- Returns 0 at all times

    return true
end

---@param itemId ActiveItemId
---@return Success
function UpdateItemInDatabase(itemId)
    Z.debug("Attempt to update", itemId, "from database...")

    local itemData = Cache.items[itemId]
    if (not itemData) then return false end

    return MySQL.update.await("UPDATE zyke_consumables SET data = ? WHERE itemId = ?", {json.encode(itemData), itemId}) == 1
end

---@param itemId ActiveItemId
---@return Success
function RemoveItemFromDatabase(itemId)
    Z.debug("Attempt to remove", itemId, "from database...")

    return MySQL.query.await("DELETE FROM zyke_consumables WHERE itemId = ?", {itemId}).affectedRows == 1
end

---@param plyId PlayerId
function StopConsuming(plyId)
    -- TODO: Stop sound

    if (Cache.consuming[plyId]) then
        Cache.consuming[plyId].queueRemoval = true
        InConsumptionThread -= 1
    end
end

---@param plyId PlayerId
---@return table | nil
function GetConsumableMetadata(plyId)
    if (not Cache.playerItems[plyId]) then return nil end

    return Cache.items[Cache.playerItems[plyId]].metadata
end

---@param plyId PlayerId
---@param name string
---@param amount? integer @Defaults 1
---@param quality? number @Defaults 100.0
function GiveIngredient(plyId, name, amount, quality)
    amount = amount or 1
    quality = quality == nil and 100.0 or (quality + 0.0)

    for _ = 1, amount do
        Z.addItem(plyId, name, 1, {
            quality = quality,
            description = T("itemDescription:ingredient:quality"):format(math.floor(quality)),
        })
    end
end

exports("GiveIngredient", GiveIngredient)