local QBCore = exports['qb-core']:GetCoreObject()

-- Function to get text style based on size setting
local function getTextStyle()
    local size = Config.MenuSettings.TextSize
    if size == 'small' then
        return { scale = 0.8 }
    elseif size == 'medium' then
        return { scale = 1.0 }
    else -- large
        return { scale = 1.2 }
    end
end

-- Function to show guide content
local function showGuideContent(category, subcategory, content)
    local elements = {}
    local textStyle = getTextStyle()
    
    -- Add back button
    table.insert(elements, {
        header = '⬅️ Back',
        txt = 'Return to subcategories',
        params = {
            event = 'qm-guidebook:client:showSubcategories',
            args = {
                category = category
            }
        }
    })
    
    -- Add content
    for _, item in ipairs(content) do
        table.insert(elements, {
            header = item.title,
            txt = item.text,
            isMenuHeader = false,
            style = textStyle
        })
    end
    
    exports['qb-menu']:openMenu(elements)
end

-- Function to show subcategories
local function showSubcategories(category)
    local elements = {}
    local textStyle = getTextStyle()
    
    -- Add back button
    table.insert(elements, {
        header = '⬅️ Back',
        txt = 'Return to main menu',
        params = {
            event = 'qm-guidebook:client:showMainMenu'
        }
    })
    
    -- Add subcategories
    for subcat, data in pairs(Config.Categories[category].subcategories) do
        table.insert(elements, {
            header = data.label,
            txt = 'Click to view ' .. data.label,
            params = {
                event = 'qm-guidebook:client:showContent',
                args = {
                    category = category,
                    subcategory = subcat
                }
            },
            style = textStyle
        })
    end
    
    exports['qb-menu']:openMenu(elements)
end

-- Function to show main menu
local function showMainMenu()
    local elements = {}
    local textStyle = getTextStyle()
    
    -- Add header
    table.insert(elements, {
        header = '📚 QM Guidebook',
        txt = 'Welcome to the server guidebook',
        isMenuHeader = true,
        style = textStyle
    })
    
    -- Add categories
    for cat, data in pairs(Config.Categories) do
        if data.enabled then
            table.insert(elements, {
                header = data.label,
                txt = 'Click to view ' .. data.label,
                params = {
                    event = 'qm-guidebook:client:showSubcategories',
                    args = {
                        category = cat
                    }
                },
                style = textStyle
            })
        end
    end
    
    exports['qb-menu']:openMenu(elements)
end

-- Events
RegisterNetEvent('qm-guidebook:client:showMainMenu', function()
    showMainMenu()
end)

RegisterNetEvent('qm-guidebook:client:showSubcategories', function(data)
    showSubcategories(data.category)
end)

RegisterNetEvent('qm-guidebook:client:showContent', function(data)
    showGuideContent(
        data.category,
        data.subcategory,
        Config.Categories[data.category].subcategories[data.subcategory].content
    )
end)

-- Command
RegisterCommand(Config.Command, function()
    TriggerEvent('qm-guidebook:client:showMainMenu')
end)

-- Keybind
if Config.Keybind then
    RegisterKeyMapping(Config.Command, 'Guidebook', 'keyboard', Config.Keybind)
end 