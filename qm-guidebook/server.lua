local QBCore = exports['qb-core']:GetCoreObject()

-- Add any server-side functionality here
-- For example, logging guidebook usage, permissions, etc.

-- Example: Log when players open the guidebook
RegisterNetEvent('qm-guidebook:server:logUsage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        -- Add logging functionality here if needed
    end
end) 