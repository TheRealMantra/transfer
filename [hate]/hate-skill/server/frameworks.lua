if Config.Framework == 'QB' then
    QBCore = exports["qb-core"]:GetCoreObject()

    function GetPlayers()
        return QBCore.Functions.GetPlayers()
    end
    
    function GetPlayerFromId(playerId)
        return QBCore.Functions.GetPlayers(playerId)
    end

    -- AddXP Komutu
    QBCore.Commands.Add(Config.Commands.AddXP, 'Add XP to player', {{name='id', help='Player ID'}, {name='amount', help='XP Amount'}}, true, function(source, args)
        local src = source
        local targetId = tonumber(args[1])
        local xpAmount = tonumber(args[2])
        
        if not targetId or not xpAmount then
            TriggerClientEvent('QBCore:Notify', src, Config.Locale.UsageAddXP, 'error')
            return
        end

        if Config.Debug then print("Adding XP:", targetId, xpAmount) end
        TriggerEvent('skill:addXP', targetId, xpAmount)
        TriggerClientEvent('QBCore:Notify', src, Config.Locale.XPAddedMessage .. xpAmount .. ' - ' .. Config.Locale.Player .. ': ' .. GetPlayerName(targetId), 'success')
    end, 'admin')
    
    -- AddSkillPoints Komutu
    QBCore.Commands.Add(Config.Commands.AddSkillPoints, 'Add Skill Points', {{name='id', help='PlayerID'}, {name='amount', help='Point amount'}}, true, function(source, args)
        local src = source
        local targetId = tonumber(args[1])
        local pointsAmount = tonumber(args[2])
        
        if not targetId or not pointsAmount then
            TriggerClientEvent('QBCore:Notify', src, Config.Locale.UsageAddSkillPoints, 'error')
            return
        end

        if Config.Debug then print("Adding skill points:", targetId, pointsAmount) end
        TriggerEvent('skill:addSkillPoints', targetId, pointsAmount)
    end, 'admin')
    
    -- ResetSkills Komutu
    QBCore.Commands.Add(Config.Commands.ResetSkills, 'Reset Skills', {{name='id', help='Player ID'}}, true, function(source, args)
        local src = source
        local targetId = tonumber(args[1]) or src
        local identifier = GetCharacterIdentifier(targetId)
        
        if not identifier then
            TriggerClientEvent('QBCore:Notify', src, Config.Locale.PlayerNotFound, 'error')
            return
        end

        local defaultData = {
            level = 1,
            xp = 0,
            points = 0,
            skills = {
                health = 0,
                regen = 0,
                stamina = 0,
                stamina_regen = 0,
                speed = 0,
                swim = 0,
                car_speed = 0,
                boat_speed = 0
            }
        }
        
        MySQL.update('UPDATE player_skills SET level = ?, xp = ?, points = ?, skills = ? WHERE identifier = ?', {
            defaultData.level,
            defaultData.xp,
            defaultData.points,
            json.encode(defaultData.skills),
            identifier
        })
        
        TriggerClientEvent('skill:sendData', targetId, defaultData)
        TriggerClientEvent('QBCore:Notify', targetId, Config.Locale.SkillsReset, 'success')
        TriggerClientEvent('QBCore:Notify', src, Config.Locale.SkillsResetSuccess .. GetPlayerName(targetId), 'success')
    end, 'admin')

elseif Config.Framework == 'ESX' then
    ESX = exports['es_extended']:getSharedObject()
    
    function GetPlayers()
        return ESX.GetPlayers()
    end
    
    function GetPlayerFromId(playerId)
        return ESX.GetPlayerFromId(playerId)
    end

    function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
        if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument
    
        local playerGroup = xPlayer.getGroup()
        for k,v in pairs(Config.adminRanks) do
            if v == playerGroup then
                if not exclude then
                    return true
                else
                    for a,b in pairs(exclude) do
                        if b == v then
                            return false
                        end
                    end
                    return true
                end
            end
        end
        return false
    end

    -- AddXP Komutu
    RegisterCommand(Config.Commands.AddXP, function(source, args)
        local targetId = tonumber(args[1])
        local xpAmount = tonumber(args[2])
       
        local xPlayer = ESX.GetPlayerFromId(source)
        if not havePermission(xPlayer) then
            TriggerClientEvent('esx:showNotification', source, Config.Locale.NoPermission)
            return
        end

            if not targetId or not xpAmount then
                TriggerClientEvent('esx:showNotification', source, Config.Locale.UsageAddXP)
                return
            end

            if Config.Debug then print("Adding XP:", targetId, xpAmount) end
            TriggerEvent('skill:addXP', targetId, xpAmount)
            TriggerClientEvent('esx:showNotification', source, Config.Locale.XPAddedMessage .. xpAmount .. ' - ' .. Config.Locale.Player .. ': ' .. GetPlayerName(targetId))
        
    end)

    -- AddSkillPoints Komutu
    RegisterCommand(Config.Commands.AddSkillPoints, function(source, args)
        local targetId = tonumber(args[1])
        local pointsAmount = tonumber(args[2])
        local xPlayer = ESX.GetPlayerFromId(source)
                if not havePermission(xPlayer) then
                    TriggerClientEvent('esx:showNotification', source, Config.Locale.NoPermission)
                    return
                end
        if not targetId or not pointsAmount then
            TriggerClientEvent('esx:showNotification', source, Config.Locale.UsageAddSkillPoints)
            return
        end

        if Config.Debug then print("Adding skill points:", targetId, pointsAmount) end
        TriggerEvent('skill:addSkillPoints', targetId, pointsAmount)
    end)

    -- ResetSkills Komutu
    RegisterCommand(Config.Commands.ResetSkills, function(source, args)
        local targetId = args[1] and tonumber(args[1]) or source
        local identifier = GetCharacterIdentifier(targetId)
        local xPlayer = ESX.GetPlayerFromId(source)
                if not havePermission(xPlayer) then
                    TriggerClientEvent('esx:showNotification', source, Config.Locale.NoPermission)
                    return
                end
        if not identifier then
            TriggerClientEvent('esx:showNotification', source, Config.Locale.PlayerNotFound)
            return
        end
        
        local defaultData = {
            level = 1,
            xp = 0,
            points = 0,
            skills = {
                health = 0,
                regen = 0,
                stamina = 0,
                stamina_regen = 0,
                speed = 0,
                swim = 0,
                car_speed = 0,
                boat_speed = 0
            }
        }
        
        MySQL.update('UPDATE player_skills SET level = ?, xp = ?, points = ?, skills = ? WHERE identifier = ?', {
            defaultData.level,
            defaultData.xp,
            defaultData.points,
            json.encode(defaultData.skills),
            identifier
        })
        
        TriggerClientEvent('skill:sendData', targetId, defaultData)
        TriggerClientEvent('esx:showNotification', targetId, Config.Locale.SkillsReset)
        TriggerClientEvent('esx:showNotification', source, Config.Locale.SkillsResetSuccess .. GetPlayerName(targetId))
    end)
end