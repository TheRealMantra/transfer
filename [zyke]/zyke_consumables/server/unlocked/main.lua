while (not Cache.hasInit) do Wait(10) end
while (not ConstructItemMetadata) do Wait(10) end

AddEventHandler("onResourceStop", function(resName)
    if (resName ~= ResName) then return end

    for _, netId in pairs(Cache.worldItems) do
        local prop = NetworkGetEntityFromNetworkId(netId)
        if (DoesEntityExist(prop)) then
            DeleteEntity(prop)
        end
    end
end)

-- This wait is required for some reason, because otherwise it will never load the props spawned in EnsureWorldItem, and it appears that the coordinates are in the millions
-- Even though we are waiting for the prop to fully load in the function, it will never be registered as such
-- ~25 should be fine to run on most servers, set to 250 to not have any issues, 1000 for NO issues
-- Because of this wait, the client will have time to load, which means we run the equipping in here
-- -> Due to other loading this wait is no longer needed, but I keep the comment for avoiding possible confusion in the future
local saved = MySQL.query.await("SELECT * FROM zyke_consumables")
for i = 1, #saved do
    CreateThread(function()
        local id = saved[i].itemId

        ---@type ActiveItemData
        local savedData = json.decode(saved[i].data)

        Cache.items[id] = savedData

        if (savedData.current == "NONE") then
            -- We remove if set as "NONE", this state should only be a temporary stage between creating an item and equipping it
            -- If an item is in this state during a save, it should be marked as not valid and be removed
            RemoveItemFromDatabase(id)
        elseif (savedData.current == "WORLD") then
            if (not Cache.itemSettings[savedData.id]) then
                error(("Consumable placed in world is missing item settings data linked to name: %s"):format(savedData.name))
            end

            EnsureWorldItem(id)
        else
            local plyId = Z.getPlayerId(savedData.current)
            if (plyId) then
                OnCharacterSelected(plyId)
            end
        end
    end)
end

-- Fetch and apply your old session
---@param plyId PlayerId
function OnCharacterSelected(plyId)
    local identifier = Z.getIdentifier(plyId)

    for itemId, itemData in pairs(Cache.items) do
        if (Cache.itemSettings[itemData.id]) then
            if (itemData.current == identifier) then
                EquipItem(plyId, itemId)
                break
            end
        else
            -- Remove items that no longer exist
            Cache.items[itemId] = nil
        end
    end
end

AddEventHandler("zyke_lib:OnCharacterSelect", function(plyId)
    OnCharacterSelected(plyId)
end)

local players = Z.getPlayers()
for i = 1, #players do
    OnCharacterSelected(players[i])
end