---@param player Character | CharacterIdentifier | PlayerId
---@param itemName string
---@param itemAmount integer
---@return boolean
function Functions.canCarryItem(player, itemName, itemAmount)
    local plyId = Functions.getPlayerId(player)
    if (not plyId) then return false end

    itemAmount = itemAmount or 1

    if (Inventory == "OX") then return exports["ox_inventory"]:CanCarryItem(plyId, itemName, itemAmount) and true or false end
    if (Inventory == "TGIANN") then return exports["tgiann-inventory"]:CanCarryItem(plyId, itemName, itemAmount) and true or false end

    return true
end

return Functions.canCarryItem