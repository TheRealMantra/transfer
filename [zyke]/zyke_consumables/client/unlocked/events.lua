RegisterNetEvent("zyke_consumables:EquipItem", function(itemData, prevCurrent)
    Cache.item = itemData
    EquipItem(prevCurrent)
    SyncUIData()
end)

---@param transferData PlayerToPlayerTransferData | PlayerToWorldTransferData | "self"
RegisterNetEvent("zyke_consumables:UnequipItem", function(transferData)
    UnequipItem(transferData)
end)

RegisterNetEvent("zyke_consumables:SyncItemData", function(itemData)
    Cache.item = itemData

    SyncUIData()
end)

-- Dedicated event only during consuming
-- Carries much lighter payload (1/20th during early testing), since we only need to update the amount this frequently
RegisterNetEvent("zyke_consumables:OnConsuming", function(amount)
    Cache.item.amount = amount

    SyncUIData()
end)

AddEventHandler("onResourceStop", function(resName)
    if (resName ~= GetCurrentResourceName()) then return end

    CleanCachedProps()
    StopCurrentAnim()
end)

---@param itemId ActiveItemId
---@param netId NetId
RegisterNetEvent("zyke_consumables:WorldItemCreated", function(itemId, netId)
    Cache.worldItems[itemId] = netId
end)

---@param itemId ActiveItemId
RegisterNetEvent("zyke_consumables:WorldItemRemoved", function(itemId)
    Cache.worldItems[itemId] = nil
end)

RegisterNetEvent("zyke_consumables:SyncItemSettings", function(items)
    Cache.itemSettings = items
end)

RegisterNetEvent("zyke_consumables:SyncIngredients", function(ingredients)
    Cache.ingredients = ingredients
end)