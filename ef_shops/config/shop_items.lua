---@class ShopItem
---@field id? number internal id number, do not set
---@field name? string item name as referenced in ox_inventory
---@field price number base price of the item
---@field defaultStock? integer the amount of items available in the shop by default
---@field category? string the category of the item in the shop (e.g. 'Snacks', 'Tools', 'Firearms', 'Ammunition', 'Drinks')
---@field license? string the license required to purchase the item
---@field jobs? table<string, number> map of group names to min grade required to access the shop
---@field metadata? table | string metadata for item

---@type table<string, table<string | number, ShopItem>>
local ITEMS = {
	normal = {
		water = { price = 1, defaultStock = 50, category = 'Snacks' },
	},
	bar = {
		water = { price = 1, defaultStock = 50 },

	},
	hardware = {
		{ name = 'lockpick', price = 20, defaultStock = 50, category = 'Tools' },
	},
	weapons = {
		{ name = 'WEAPON_KNIFE',      price = 80,   defaultStock = 250,        category = 'Point Defense' },
		{ name = 'WEAPON_BAT',        price = 45,   defaultStock = 250,        category = 'Point Defense' },
		{ name = 'WEAPON_NIGHTSTICK', price = 500,  category = 'Point Defense' },
		{ name = 'WEAPON_KNUCKLE',    price = 950,  defaultStock = 250,        category = 'Point Defense' },
		{ name = 'WEAPON_PISTOL',     price = 2450, defaultStock = 5,          category = 'Firearms' },
		{ name = 'WEAPON_SNSPISTOL',  price = 1850, defaultStock = 5,          category = 'Firearms' },
		{ name = 'ammo-9',            price = 4,    defaultStock = 9500,       category = 'Ammunition' },
		{ name = 'ammo-45',           price = 7,    defaultStock = 5500,       category = 'Ammunition' },
	},
	electronics = {
		{ name = 'phone', price = 55 },
		{ name = 'radio', price = 85 },
	},
}

local newFormatItems = {}
for category, categoryItems in pairs(ITEMS) do
	local newCategoryItems = {}

	for item, data in pairs(categoryItems) do
		if not data.name then
			data.name = tostring(item)
		end

		newCategoryItems[#newCategoryItems + 1] = data
	end

	table.sort(newCategoryItems, function(a, b)
		return a.name < b.name
	end)

	newFormatItems[category] = newCategoryItems
end

return newFormatItems
