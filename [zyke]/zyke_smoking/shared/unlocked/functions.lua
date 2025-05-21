---@param item string
---@return CigaretteSettings | RefillableSettings | nil
function GetItemSettings(item)
    if (Config.Cigarettes[item]) then return Config.Cigarettes[item] end
    if (Config.Refillables[item]) then return Config.Refillables[item] end

    return nil
end

---@param value number | integer
---@param numDecimalPlaces integer
function Round(value, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(value * mult + 0.5) / mult
end