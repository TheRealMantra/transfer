dataPeds = {}

function pedsLife()
    local actives = GetActivePlayers()
    for k, v in ipairs(GetGamePool('CPed')) do
        table.insert(actives, v)
    end
    for i, j in ipairs(actives) do
        if IsEntityAPed(j) then
            dataPeds[j] = {health = GetEntityHealth(j), armor = GetPedArmour(j)}
        end
    end
    for i, j in ipairs(dataPeds) do
        if actives[j] == nil and dataPeds[j] then
            table.remove(dataPeds, IndexOf(dataPeds, j))
        end
    end
end

function lostLife(entity)
    if entity ~= nil and entity > 0 then
        local health = 0
        local armor = 0
        if IsEntityAPed(entity) then
            health = dataPeds[entity].health - GetEntityHealth(entity)
            dataPeds[entity].health = GetEntityHealth(entity)
            armor = dataPeds[entity].armor - GetPedArmour(entity)
            dataPeds[entity].armor = GetPedArmour(entity)
        else
            health = 0
        end
        return {health = health, armor = armor}
    end
    return {health = 0, armor = 0}
end

function gtaDrawText(coords, message)
    CreateThread(function()
        local offset = {x=0, y=0}
        if math.random(2) == 1 then 
            offset.x = -math.random() / 50 
        else 
            offset.x = math.random() / 50 
        end

        if math.random(2) == 1 then 
            offset.y = -math.random() / 50 
        else 
            offset.y = math.random() / 50 
        end

        local alpha = 255
        local color = { math.random(0,255), math.random(0,255), math.random(0,255) }
        while alpha > 0 do
            Wait(0)
            local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
            local p = GetGameplayCamCoords()
            local dist = GetDistanceBetweenCoords(p.x, p.y, p.z, coords.x, coords.y, coords.xyz.z, 1)
            local scale = (1 / dist) * 5
            local fov = (1 / GetGameplayCamFov()) * 75
            scale = scale * fov
            if onScreen then
                SetTextScale(tonumber(1 * 0.0), tonumber(0.35 * 1))
                SetTextFont(0)
                SetTextProportional(true)

                if not Config.COLOR then
                    SetTextColour(color[1], color[2], color[3], alpha)
                else
                    SetTextColour(Config.COLOR[1], Config.COLOR[2], Config.COLOR[3], alpha)
                end
 
                SetTextOutline()
                SetTextEntry("STRING")
                SetTextCentre(true)
                AddTextComponentString(message)
                DrawText(x + offset.x, y + offset.y)
            end
            alpha = alpha - 5 
        end
    end)
end
