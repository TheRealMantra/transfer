---@param plyId integer
---@param slot integer
---@return Item | nil
function Functions.getInventorySlot(plyId, slot)
    if (Inventory == "OX") then
        return Formatting.formatItem(exports["ox_inventory"]:GetSlot(plyId, slot))
    elseif (Inventory == "TGIANN") then
        return Formatting.formatItem(exports["tgiann-inventory"]:GetItemBySlot(plyId, slot, nil))
    elseif (Inventory == "CODEM") then
        return Formatting.formatItem(exports["codem-inventory"]:GetItemBySlot(plyId, slot))
    end

    -- QB & Any
    -- ESX & qs-inventory
    if ((Framework == "QB") or (Framework == "ESX" and Inventory == "QS")) then
        local playerItems = Functions.getPlayerItems(plyId)
        for i = 1, #playerItems do
            if (playerItems[i].slot == slot) then
                return playerItems[i]
            end
        end

        return nil
   end

   error("Your inventory does not support this function.")
end

return Functions.getInventorySlot