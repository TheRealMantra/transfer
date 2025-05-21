function isTabEmpty(tab)
	if #tab > 0 then
		return false
	end
	return true
end

function materialsPercentageFunc(items,percentage,mult,indexTable)
    local itemsList = {}

	local isFree = true

    for _,v in ipairs(items) do
		local count = 0
		if mult then
			count = Round(v.count * percentage * Config.upkeepMult)
			--table.insert(itemsList,{name = v.name,count = Round(v.count * percentage * Config.upkeepMult)}) 
		else
			count = Round(v.count * percentage)
			--table.insert(itemsList,{name = v.name,count = Round(v.count * percentage)}) 
		end

		if count > 0 then
			isFree = false
		end

		if indexTable then
			itemsList[v.name] = count
		else
			table.insert(itemsList,{name = v.name,count = count}) 
		end

		
    end

    return itemsList, isFree
end

function getReturnMaterials(k)
	local materialsList = Config.Models[props[k].hash].returnMaterials or Config.Models[props[k].hash].crafting or {}
	local materialsPercentage = (props[k].life / Config.Models[props[k].hash].life)

	if Config.Models[props[k].hash].item then
		if materialsPercentage > 0.95 then
			materialsList = {{name = Config.Models[props[k].hash].item,count = 1}}
			materialsPercentage = 1.0
		end
	end

	return materialsPercentageFunc(materialsList , materialsPercentage)
end

function getUpgradeMaterials(upgrade)
	local materialsList = Config.Models[upgrade].crafting
	
	return materialsList
end

function getRepairMaterialsList(list,indexTable)
	local listNew = {}
	for id,_ in pairs(list) do
		local materials = getRepairMaterials(id)
		for _,v in ipairs(materials) do
			if not listNew[v.name] then
				listNew[v.name] = v.count
			else
				listNew[v.name] = listNew[v.name] + v.count
			end
		end	
	end

	if indexTable then
		return listNew
	end

	local listNewFinal = {}

	for k,v in pairs(listNew) do
        table.insert(listNewFinal,{name = k,count = v}) 
    end

	return listNewFinal
end
  
function getRepairMaterials(k, indexTable)
	local materialsList = Config.Models[props[k].hash].repairMaterials or Config.Models[props[k].hash].crafting or {}
	local materialsPercentage = (1.0 - props[k].life / Config.Models[props[k].hash].life)


	return materialsPercentageFunc(materialsList , materialsPercentage, true, indexTable)
end

function getRepairMaterialsCheck24(hash)

	local refreshTimeLifeRemove = Config.Models[hash].refreshTimeLifeRemove or Config.refreshTimeLifeRemove

	local healthRemove = ((86400 * 1000) / Config.refreshTime) * Config.refreshTimeLifeRemove

	local materialsList = Config.Models[hash].repairMaterials or Config.Models[hash].crafting or {}
	local materialsPercentage = (1.0 - (Config.Models[hash].life - healthRemove) / Config.Models[hash].life)

	return materialsPercentageFunc(materialsList , materialsPercentage, true)
end

function getPropConfigDataById(propId, key)
	if not props[propId] then return nil end

	if key then
		return Config.Models[props[propId].hash][key]
	end

	return Config.Models[props[propId].hash]
end

function getPropConfigDataByHash(hash, key)
	if not Config.Models[hash] then return nil end

	if key then
		return Config.Models[hash][key]
	end

	return Config.Models[hash]
end

function getPropDataById(propId, key)
	if not props[propId] then return nil end

	if key then
		return props[propId][key]
	end

	return props[propId]
end

function isOnOffProp(textHash)
	if Config.Models[textHash].power then return true end
	if Config.Models[textHash].generatorPower then return true end
	return false
end

function isDoor(textHash)
	if Config.Models[textHash].subtype == "zrotate" then return true end
	if Config.Models[textHash].type == "gate" then return true end
	if Config.Models[textHash].type == "biggate" then return true end
	return false 
end


exports('getPropConfigDataById',getPropConfigDataById)
exports('getPropConfigDataByHash',getPropConfigDataByHash)
exports('getPropDataById',getPropDataById)


