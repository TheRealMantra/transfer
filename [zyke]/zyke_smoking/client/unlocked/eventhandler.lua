---@param multiplier number @0.0 - 1.0 of the effect, based on how much amount was used of the max use amount
RegisterNetEvent("zyke_smoking:ApplyEffect", function(multiplier)
    Z.debug(json.encode(Cache))

    if (not Cache.currentItem) then return end

    local itemSettings = GetItemSettings(Cache.currentItem)
    if (not itemSettings) then return end

    local ply = PlayerPedId()
    local maxUseAmount = Config.Settings.useMultiplier[itemSettings.type]

    -- Since we are receiving effects and benefits in small pieces, we need to format a value
    -- In order to give certain benefits like health and armor, it needs to be rounded to a whole value
    -- We take the whole numbers, then we gamble the decimals to round up or down
    -- Over time, it is the more fair way to give the benefits when the pieces are so small
    ---@param value number
    local function formatValue(value)
        local decimals = value - math.floor(value)
        local shouldRoundUp = math.random(0, 10) <= (decimals * 10)

        return shouldRoundUp and math.ceil(value) or math.floor(value)
    end

    ---@param maxValue number
    local function getValueToGive(maxValue)
        local baseValue = (maxValue / (100 / maxUseAmount)) * multiplier
        local formatted = formatValue(baseValue)

        return formatted
    end

    local effects
    local itemName

    if (Cache.itemType == "joint" or Cache.itemType == "cigarette" or Cache.itemType == "cigar") then
        itemName = Cache.currentItem
        effects = itemSettings.effects
    elseif (Cache.itemType == "vape") then
        itemName = Cache.itemData.item.name
        effects = Config.Settings.vapeExtras.items[itemName]?.effects
    elseif (Cache.itemType == "bong") then
        itemName = Cache.itemData.item.name
        effects = Config.Settings.bongExtras.items[itemName]?.effects
    end

    if (effects) then
        if (effects.health and effects.health > 0.0) then
            local toGive = getValueToGive(effects.health)
            local currHealth = GetEntityHealth(ply)
            local newHealth = math.floor(currHealth + toGive)

            SetEntityHealth(ply, newHealth)
        end

        if (effects.armor and effects.armor > 0.0) then
            local toGive = getValueToGive(effects.armor)
            local currArmor = GetPedArmour(ply)
            local newArmor = math.floor(currArmor + toGive)

            SetPedArmour(ply, newArmor)
        end

        if (effects.stamina and effects.stamina > 0.0) then
            local toGive = getValueToGive(effects.stamina) * 1.0
            local currStam = GetPlayerStamina(PlayerId())
            local newStamina = currStam + toGive

            SetPlayerStamina(PlayerId(), newStamina)
        end

        if (effects.clientFunc) then
            local totalValue = Config.Settings.useMultiplier[itemSettings.type] * multiplier

            effects.clientFunc(totalValue, itemName, Cache.itemData)
        end
    end
end)

RegisterNetEvent("zyke_smoking:SyncEffects", function(effects)
    Cache.effects = effects

    if (Cache.effects.totalDuration > Config.Settings.effects.minAmount) then
        EffectsLoop()
    end
end)

-- Catch routing bucket changes & respawn the smokeable prop
-- This is due to some side effect where values such as collision is reset for attached props when the player changes routing bucket
AddStateBagChangeHandler("routingBucket", nil, function(bagName)
    local plyIdx = PlayerId()
    local targetPlyIdx = GetPlayerFromStateBagName(bagName)
    if (plyIdx ~= targetPlyIdx) then return end

    EnsureSmokeableProp()
end)

AddEventHandler("onResourceStop", function(resName)
    if (resName ~= GetCurrentResourceName()) then return end

    ClearTimecycleModifier()
    ResetWalkStyle()
    CleanProps()
end)