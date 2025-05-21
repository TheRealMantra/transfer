---@param player Character | CharacterIdentifier | PlayerId
---@param permission string @Usually "command"
---@return boolean
---@diagnostic disable-next-line: duplicate-set-field
function Functions.hasPermission(player, permission)
    if (player == 0) then return true end -- Server request

    local plyId = Functions.getPlayerId(player)
    if (not plyId) then return false end

    return IsPlayerAceAllowed(tostring(plyId), permission)
end

Z.callback.register(ResName .. ":HasPermission", function(plyId, permission)
    return Functions.hasPermission(plyId, permission)
end)

return Functions.hasPermission