---@type table<string, {name: string, label: string, globalMultiplier: number, fn: fun(cData: ConsumptionData)}>
ConsumptionRewards = {}

---@return {name: string, label: string}[]
Z.callback.register("zyke_consumables:GetConsumptionRewards", function()
    ---@type table<ConsumptionRewardName, ConsumptionRewardDetails>
    local minimized = {}

    for name, values in pairs(ConsumptionRewards) do
        minimized[name] = {name = name, label = values.label, globalMultiplier = values.globalMultiplier}
    end

    return minimized
end)

---@param details ConsumptionRewardDetails
---@param fn fun(plyId: PlayerId, name: string, amount: number)
function RegisterConsumptionReward(details, fn)
    ConsumptionRewards[details.name] = {
        name = details.name,
        label = details.label,
        -- This is a global multiplier to change the amount each consumption reward does, to easily maintain a balance on your server for all items
        -- For example, a 500ml bottle will contain 500ml of liquid, setting drink to 0.1 in here will make it give you 50.0 to your status
        -- Additionally you can adjust the multiplier per item, which will stack with this one
        -- Keep in mind that your status has a cap of 100.0, which one 500ml water bottle will fill 5 times over if not adjusted
        globalMultiplier = details.globalMultiplier,
        fn = fn
    }
end

---@param plyId PlayerId
---@param itemId ItemId
---@param consumName ConsumptionRewardName
---@param amount number
---@param quality number @Quality of the item
---@param qualityThreshold number
---@param qualityThresholdReversed boolean
---@param qualityType QualityType
---@param ingName? string @Ingredient name, if using ingredients, to grab the multiplier
function UseConsumptionRewards(plyId, itemId, consumName, amount, quality, qualityThreshold, qualityThresholdReversed, qualityType, ingName)
    if (qualityThresholdReversed) then
        -- If quality is above, and we have it reversed, stop the effect
        if (quality >= qualityThreshold) then return end
    else
        -- If quality is below, and we have it not reversed, stop the effect
        if (quality < qualityThreshold) then return end
    end

    local rewardAmount, rewardAmountNoQuality = CalculateConsumptionRewardAmount(itemId, amount, consumName, quality, ingName)

    ConsumptionRewards[consumName].fn({
        plyId = plyId,
        id = itemId,
        amount = amount,
        consumName = consumName,
        itemMetadata = GetConsumableMetadata(plyId) or {},
        rewardAmount = rewardAmount,
        rewardAmountNoQuality = rewardAmountNoQuality, -- Not modified by quality, in case you need to perform some other math on it
        quality = quality,
        qualityThreshold = qualityThreshold,
        qualityType = qualityType
    })
end

---@param itemId ItemId
---@param amount number
---@param consumName string
---@param quality number @Quality of the item
---@param ingName? string @Ingredient name, if using ingredients, to grab the multiplier
---@return number, number
function CalculateConsumptionRewardAmount(itemId, amount, consumName, quality, ingName)
    local gMulti = ConsumptionRewards[consumName].globalMultiplier

    local rewardType = Cache.itemSettings[itemId].rewardType
    local consumeMultiplier = 1.0
    if (rewardType == "consumptionRewards") then
        consumeMultiplier = Cache.itemSettings[itemId].consumptionRewards[consumName].multiplier
    elseif (rewardType == "ingredients") then
        consumeMultiplier = Cache.ingredients[ingName].consumptionRewards[consumName].multiplier
    end

    local rewardAmountNoQuality = amount * gMulti * consumeMultiplier

    return rewardAmountNoQuality * (quality / 100.0), rewardAmountNoQuality
end

-- ~1/6 (500ml -> 75)
---@param cData ConsumptionData
RegisterConsumptionReward({name = "drink", label = "Drink", globalMultiplier = 0.15}, function(cData)
    -- print("Adding drink to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:AddToStatus(cData.plyId, {"thirst"}, cData.rewardAmount)
end)

-- 1/4 (500g -> 125)
---@param cData ConsumptionData
RegisterConsumptionReward({name = "food", label = "Food", globalMultiplier = 0.25}, function(cData)
    -- print("Adding food to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:AddToStatus(cData.plyId, {"hunger"}, cData.rewardAmount)
end)

-- 1/20 (500g/ml -> 25)
---@param cData ConsumptionData
RegisterConsumptionReward({name = "stress", label = "Stress", globalMultiplier = 0.05}, function(cData)
    -- print("Adding stress to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:RemoveFromStatus(cData.plyId, {"stress"}, cData.rewardAmount)
end)

---@param cData ConsumptionData
RegisterConsumptionReward({name = "nicotine", label = "Nicotine", globalMultiplier = 1.0}, function(cData)
    -- print("Adding nicotine to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:BulkAction(cData.plyId, {
        {"add", {"addiction", "nicotine"}, cData.rewardAmount / 7}, -- Character creates & manages a nicotine addiction if used enough
        {"add", {"high", "nicotine"}, cData.rewardAmount}, -- High on nicotine as soon as it hits treshold
    })
end)

---@param cData ConsumptionData
RegisterConsumptionReward({name = "cocaine", label = "Cocaine", globalMultiplier = 1.0}, function(cData)
    -- print("Adding cocaine to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:BulkAction(cData.plyId, {
        {"add", {"addiction", "cocaine"}, cData.rewardAmount / 7}, -- Character creates & manages a nicotine addiction if used enough
        {"add", {"high", "cocaine"}, cData.rewardAmount}, -- High on nicotine as soon as it hits treshold
    })
end)

---@param cData ConsumptionData
RegisterConsumptionReward({name = "lsd", label = "LSD", globalMultiplier = 1.0}, function(cData)
    -- print("Adding lsd to status:", cData.plyId, cData.rewardAmount, cData.rewardAmountNoQuality)
    exports["zyke_status"]:BulkAction(cData.plyId, {
        {"add", {"addiction", "lsd"}, cData.rewardAmount / 7}, -- Character creates & manages a nicotine addiction if used enough
        {"add", {"high", "lsd"}, cData.rewardAmount}, -- High on nicotine as soon as it hits treshold
    })
end)

---@param cData ConsumptionData
RegisterConsumptionReward({name = "custom_example", label = "Custom Example", globalMultiplier = 1.0}, function(cData)
    print("Executing custom effect:", json.encode(cData, {indent = true}))

    -- If consuming 10.0, and the quality is 90.0, this calculation will be 1.0 * 10.0
    -- Can be used as chance or direct status change
    local testAmount = (cData.rewardAmountNoQuality - cData.rewardAmountNoQuality * 0.9) * 10.0

    -- Example of a dice roll to apply some effect
    local decimals = 5
    local roll = math.random(0, math.floor(100 * 10^decimals)) / 10^decimals
    if (roll <= testAmount) then
        print("Applying effect to player:", cData.plyId, roll, testAmount)
    end

    print(roll, testAmount)

    print("testAmount", testAmount, cData.rewardAmountNoQuality)
end)

-- exports["zyke_status"]:RemoveFromStatus(plyId, {"stress"}, amount / 120) -- Thirst
-- exports["zyke_status"]:RemoveFromStatus(plyId, {"stress"}, amount / 80) -- Hunger
-- local metadata = Cache.items[Cache.playerItems[plyId]].metadata