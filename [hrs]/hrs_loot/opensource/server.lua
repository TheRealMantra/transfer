function getMetadata(xPlayer,itemName,lootType,metadataInfo)
    if metadataInfo then
        local finalMetadata = {}
        for k,v in pairs(metadataInfo) do
            if type(v) == "table" then
                if v.mathRandom then
                    finalMetadata[k] = math.random(v.mathRandom.min, v.mathRandom.max)
                elseif v.listRandom then
                    finalMetadata[k] = v.listRandom[math.random(1, #v.listRandom)]
                elseif v.probabilityRandom then
                    finalMetadata[k] = checkProb(v.probabilityRandom)
                else
                    finalMetadata[k] = v
                end
            else
                finalMetadata[k] = v
            end
        end
        
        return finalMetadata
    end
    
    return nil
end

local customIdsList = {}
function getCustomId(checkId)
    if customIdsList[checkId] then return customIdsList[checkId] end
    return checkId
end

function isLootEmpty(checkId)
    if lootList[checkId] and next(lootList[checkId]) then

        if Config.UseInventoryUI then

            if Config.inventory == 'ox_inventory' then
                checkId = getCustomId(checkId)
                local inventory = exports.ox_inventory:GetInventory(checkId, false)
                if not inventory then return true end
                if not next(inventory.items) then return true end
            end

            if Config.inventory == 'core_inventory' then
                checkId = getCustomId(checkId)
                local inventory = exports.core_inventory:getInventory(checkId)
                if not inventory then return true end
                if not next(inventory) then return true end
            end

        end

        return false
    end

    return true
end

function createNewLoot(checkId,type,xPlayer,coords,extraInfo)
    local finalList = getItemsList(type,xPlayer,coords,extraInfo)

    if Config.UseInventoryUI then

        if Config.inventory == 'ox_inventory' then
            local invName = getCustomId(checkId)
            
            if exports.ox_inventory:GetInventory(invName, false) then
                exports.ox_inventory:ClearInventory(invName)
            end

            local mystash = exports.ox_inventory:CreateTemporaryStash({
                label = 'Loot',
                slots = 50,
                maxWeight = 50000,
                items = {}
            })

            customIdsList[checkId] = mystash
            checkId = mystash

            for k,v in pairs(finalList) do
                exports.ox_inventory:AddItem(checkId, v.item, v.count, v.metadata)	
            end

            return finalList
        end

        if Config.inventory == 'core_inventory' then

            customIdsList[checkId] = string.gsub(checkId, "-", "n")
            customIdsList[checkId] = "loot-"..string.gsub(customIdsList[checkId], "%.", "dot")
            checkId = customIdsList[checkId]

            if exports.core_inventory:getInventory(checkId) then
                exports.core_inventory:clearInventory(checkId)
            end

            for k,v in pairs(finalList) do
                exports['core_inventory']:addItem(checkId, v.item, v.count, v.metadata, "hrs_loot")
            end

           -- exports.core_inventory:removeItem(checkId, 'bandage', 1, 'hrs_loot')

            return finalList
        end

    end
    
    return finalList
end

function clearLootInventory(checkId)
    lootList[checkId] = nil
    lootListByTime[checkId] = nil
    lootListByType[checkId] = nil
 
    if Config.UseInventoryUI then

        if Config.inventory == 'core_inventory' then
            checkIdNew = getCustomId(checkId)
            exports.core_inventory:clearInventory(checkIdNew)
            customIdsList[checkId] = nil
            return
        end

        if Config.inventory == 'ox_inventory' then
            checkIdNew = getCustomId(checkId)
            exports.ox_inventory:ClearInventory(checkIdNew)
            customIdsList[checkId] = nil
            return
        end

    end

end

function returnRandomNumber()
    local mult = 100
    return math.random(1,100*mult) , mult
end

function getRefreshTime(type, coords, extraInfo)
    return Config.types[type].lootRefreshTime or Config.lootRefreshTime
end -- only INT numbers














-------- IGNORE USED FOR EXPORT 'generateItemsList' -------------------------------------------------------------
function getMetadata2(itemName,metadataInfo)
    if metadataInfo then
        local finalMetadata = {}
        for k,v in pairs(metadataInfo) do
            if type(v) == "table" then
                if v.mathRandom then
                    finalMetadata[k] = math.random(v.mathRandom.min, v.mathRandom.max)
                elseif v.listRandom then
                    finalMetadata[k] = v.listRandom[math.random(1, #v.listRandom)]
                elseif v.probabilityRandom then
                    finalMetadata[k] = checkProb(v.probabilityRandom)
                else
                    finalMetadata[k] = v
                end
            else
                finalMetadata[k] = v
            end
        end
        
        return finalMetadata
    end
    
    return nil
end



-- MySQL.ready(function()
-- 	MySQL.Async.fetchAll("SELECT * FROM coreinventories", {}, function(result)		
--         for k, v in ipairs(result) do
-- 			local inventory = v.name
--             if v.type == "hrs_loot" then
--                 MySQL.Async.execute('DELETE FROM coreinventories WHERE name = @name', {
--                     ['@name'] = inventory
--                 })
--             end
-- 		end
-- 	end)
-- end)