RegisterNetEvent("zyke_consumables:StartConsuming", function()
    -- TODO: Start sound
    ConsumptionThread(source)
end)

---@param activeItemId ActiveItemId
RegisterNetEvent("zyke_consumables:ConsumeOneHit", function(activeItemId)
    ConsumeOneHit(source, activeItemId)
end)

RegisterNetEvent("zyke_consumables:StopConsuming", function()
    StopConsuming(source)
end)

RegisterNetEvent("zyke_lib:OnCharacterLogout", function()
    StopConsuming(source)
end)

RegisterNetEvent("zyke_consumables:Discard", function()
    local hasItem = Cache.playerItems[source] ~= nil

    if (hasItem) then
        -- Discard that one item
    else
        -- Discard all empty items in inventory
        -- TODO: Fix id & name
        local plyInventory = Z.getPlayerItems(source)
        for i = 1, #plyInventory do
            if (Cache.itemSettings[plyInventory[i].name] ~= nil) then
                if (plyInventory[i]?.metadata?.value and plyInventory[i].metadata.value < 1) then
                    Z.removeFromSlot(source, plyInventory[i].name, 1, plyInventory[i].slot)
                end
            end
        end
    end
end)

---@param plyId PlayerId
---@param activeItemId ActiveItemId
---@return ItemId?
Z.callback.register("zyke_consumables:GetItemIdFromActiveItemId", function(plyId, activeItemId)
    return Cache.items?[activeItemId]?.id
end)