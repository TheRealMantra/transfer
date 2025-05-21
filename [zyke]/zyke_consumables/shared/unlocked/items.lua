-- List of allowed and usable items to configure
-- This list exists as a static here in the config as it is not meant to be modified other than when you add/remove items from your server

-- If you remove an item from here, that item will become unusable and unavailable to be configured
-- This list is still relevant if you are using our base item for unlimited customizable food
Config.Items = {
	["coffee"] = true,
	["burger"] = true,
	["fish"] = true,
	["hotdog"] = true,
	["kira_kira_currye"] = true,
	["nicotine_pouch"] = true,

	-- Testing stuff
	["water_1000cl"] = true,
	["water_100cl"] = true,
	["water_1050cl"] = true,
	["water_1100cl"] = true,
	["water_1150cl"] = true,
	["water_150cl"] = true,
	["water_200cl"] = true,
	["water_250cl"] = true,
	["water_300cl"] = true,
	["water_350cl"] = true,
	["water_400cl"] = true,
	["water_450cl"] = true,
	["water_500cl"] = true,
	["water_50cl"] = true,
	["water_550cl"] = true,
	["water_600cl"] = true,
	["water_650cl"] = true,
	["water_700cl"] = true,
	["water_750cl"] = true,
	["water_800cl"] = true,
	["water_850cl"] = true,
	["water_900cl"] = true,
	["water_950cl"] = true,
}

-- Base names are automatically inserted, based on "base_" .. itemType
if (Config.Settings.infiniteItems.enabled) then
	for k in pairs(Config.Settings.itemTypes) do
		Config.Items[Config.Settings.infiniteItems.baseItemPrefix:format(k)] = true
	end
end

---@return {label: string, name: string, value: string}[]
function GetUnusedItems()
	---@type {label: string, name: string, value: string}[]
	local items = {}

	---@type table<string, boolean>
	local usedItems = {}
	for _, item in pairs(Cache.itemSettings) do
		if (item.infinite ~= true) then
			usedItems[item.name] = true
		end
	end

	for item, enabled in pairs(Config.Items) do
		if (enabled and not usedItems[item]) then
			local label = (Items[item]?.label or "MISSING LABEL")

			-- value for UI compatibility
			items[#items+1] = {label = label, name = item, value = item}
		end
	end

	return items
end