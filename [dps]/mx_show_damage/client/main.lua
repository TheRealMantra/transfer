
local positionMessages = {}
local tempX, tempY = nil, nil
local indiceM = 0

CreateThread(function()
    while true do
        Wait(250)
        pedsLife()

        for i, k in pairs(positionMessages) do
            if k.time > 0 then
                k.time = k.time - 1;
            else
                table.remove(positionMessages, i) 

                SendNUIMessage({
                    ui = 'remove',
                    indice = k.indice,
                })
            end
        end
    end
end)

CreateThread(function()	
    while true do
		Wait(0)

        if #positionMessages > 0 then
            SendNUIMessage({
                ui = 'update',
                positionMessages = positionMessages,
            })

            for i, k in pairs(positionMessages) do
                local x, y, size = getCoordsDisplay(k.victim, k.attacker, -1)
                k.top = (y * 100) + k.numRandomTop
                k.left = (x * 100)
                k.size = size
            end
        end
	end
end)

AddEventHandler('gameEventTriggered', function (name, args)
    if name == "CEventNetworkEntityDamage" then
        local victim = tonumber(args[1])
        local attacker = tonumber(args[2])
        local ped = PlayerPedId()
        local pDead = false

        if attacker == ped and IsEntityAPed(victim) then
            local dmg = lostLife(victim)
        
            if dmg.health <= 0 and dmg.armor <= 0 then
                return
            end
        
            local msg = ""
        
            if IsEntityDead(victim) and Config.SHOW_DEAD then
                msg = "💀 DEAD"
                pDead = Config.USE_IMG_GIF
            else
                if Config.HUD_MESSAGE_TYPE == 1 then
                    msg = "❤️ " .. dmg.health
                elseif Config.HUD_MESSAGE_TYPE == 2 then
                    msg = dmg.health
                elseif Config.HUD_MESSAGE_TYPE == 3 then
                    msg = "❤️ " .. dmg.health
                    if dmg.armor > 0 then
                        msg = msg .. " / 🛡️ " .. dmg.armor
                    end
                elseif Config.HUD_MESSAGE_TYPE == 4 then
                    msg = dmg.armor > 0 and "🛡️" or ("❤️ " .. dmg.health)
                elseif Config.HUD_MESSAGE_TYPE == 5 then
                    msg = dmg.health
                    if dmg.armor > 0 then
                        msg = msg .. " / " .. dmg.armor
                    end
                end
            end
        
            if Config.DISPLAY_HUD == "GTA" then
                local _, bone = GetPedLastDamageBone(victim)
                local pos = GetPedBoneCoords(victim, bone)
                gtaDrawText(pos, msg)
            elseif Config.DISPLAY_HUD == "HTML" then
                local x, y, size = getCoordsDisplay(victim, ped, -1)
                local color = false
                if Config.COLOR then
                    color = {Config.COLOR[1], Config.COLOR[2], Config.COLOR[3], 1}
                end
                customHtmlDisplay(x, y, size, color, pDead, msg, victim, ped) 
            end
        end
    end
end)

function getCoordsDisplay(entity, ped, coords) 
    local _, bone = GetPedLastDamageBone(entity)
    local posEntiy = GetPedBoneCoords(entity, bone)
    coords = coords == -1 and posEntiy or coords
    
    local pos = GetEntityCoords(ped)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.0)

    local dist = #(pos - coords)
    local size = dist < 20.0 and Config.SIZE.NEAR or (dist < 50.0 and Config.SIZE.AVERAGE or Config.SIZE.FAR)

    tempX, tempY = x, y

    return x, y, size
end

function customHtmlDisplay(x, y, size, color, dead, message, victim, attacker) 
    if type(color) == "table" and #color == 4 then
        color = '('.. color[1] ..','.. color[2] ..','.. color[3] ..','.. color[4] ..')'
    else
        color = '('.. math.random(0,255) ..','.. math.random(0,255) ..','.. math.random(0,255) ..',255)'
    end
    
    local time = 2
    if dead then
        time = 11
    end

    local numRandomTop = math.random(-2, 2)

    local data = {
        indice = indiceM,
        top = (y * 100),
        left = (x * 100),
        numRandomTop = numRandomTop,
        size = size,
        color = color,
        img = Config.GIF,
        dead=dead,
        time=time,
        message = message,
        victim = victim, 
        attacker = attacker,
    }
    table.insert(positionMessages, data)

    SendNUIMessage({
        ui = 'display',
        dataDisplay = data,
        Config = Config,
    })
    indiceM = indiceM + 1
end