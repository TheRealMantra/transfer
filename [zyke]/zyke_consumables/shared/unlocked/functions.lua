-- Checks if your position is valid compared to the position you want to place it as
-- We want to have less effect on Z value, since we can reach further up and down
---@param plyPos vector3
---@param placementPos vector3
---@return number
function GetPlayerReachToPosition(plyPos, placementPos)
    local rangeDiff = #(vector2(plyPos.x, plyPos.y) - vector2(placementPos.x, placementPos.y))
    -- local heightDiff = (#(vector3(0, 0, plyPos.z) - vector3(0, 0, placementPos.z))) / 2
    local totalDiff = rangeDiff

    return totalDiff
end

---@class AvailableItem
---@field id string
---@field label string
---@field type string
---@field name string

-- Returns an array of all available items, so you can grab the id of custom ones primarily
---@return AvailableItem[]
function GetAvailableItems()
    ---@type AvailableItem[]
    local items = {}

    for id, item in pairs(Cache.itemSettings) do
        items[#items+1] = {
            id = id,
            label = item.label,
            type = item.type,
            name = item.name
        }
    end

    return items
end

-- Technically only client-side, but put in here for convenience
---@class MenuItem
---@field title string
---@field onSelect fun(id: string): nil

---@param onSelect fun(id: string): nil
---@param job string
---@return MenuItem[]
function GetMenuItems(onSelect, job)
    ---@type MenuItem[]
    local items = {}

    for id, item in pairs(Cache.itemSettings) do
        if (item.rewardType ~= "ingredients") then goto continue end
        if (item.job  ~= job) then goto continue end

        items[#items+1] = {
            title = item.label .. " (" .. item.name .. ")",
            onSelect = function()
                onSelect(id)
            end,
            action = function()
                onSelect(id)
            end
        }

        ::continue::
    end

    return items
end

exports("GetAvailableItems", GetAvailableItems)
exports("GetItems", GetAvailableItems)
exports("GetMenuItems", GetMenuItems)

---@param job string
---@return nil | {name: string, minGrade: number}
function GetAllowedJobSettings(job)
    for i = 1, #Config.Settings.allowedJobs do
        if (Config.Settings.allowedJobs[i].name == job) then
            return Config.Settings.allowedJobs[i]
        end
    end

    return nil
end

---@param rewards table<ConsumptionRewardName, any>
function ValidateConsumptionRewards(rewards)
    for name in pairs(rewards) do
        if (not ConsumptionRewards[name]) then
            rewards[name] = nil
            Z.debug("^1Invalid consumption reward \"" .. tostring(name) .. "\" has been temporarily removed. Will be permanently removed from item on next save.^7")
        end
    end
end