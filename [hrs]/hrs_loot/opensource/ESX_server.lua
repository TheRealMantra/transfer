if Config.Framework == "ESX" then

	ESX = exports["es_extended"]:getSharedObject()

	function GetItemLabel(name)
		local label = ""

		if name == "money" then
			label = Config.moneyLabel
		elseif ESX.GetItemLabel(name) then
			label = ESX.GetItemLabel(name)
		else
			label = name.." (no-label)"
		end

		-- if string.match(name,"WEAPON") then
		-- 	label = ESX.GetWeaponLabel(name)
		-- end

        return label
    end

    function GetPlayerFromId(source)
		return ESX.GetPlayerFromId(source)
	end

	function ShowNotification(source,text)
		TriggerClientEvent('esx:showNotification', source, text)
	end

	function HasEnoughtInventoryItem(xPlayer,item,count)
		local itemAmount = xPlayer.getInventoryItem(item)

		if not itemAmount then
			print("ITEM "..item.." IS NOT REGISTERED IN YOUR SERVER")
			return false
		end

		if itemAmount and itemAmount.count and itemAmount.count >= count then
			return true
		end

		return false
	end

	function AddInventoryItem(xPlayer,item,count,metadata)
		if item == "money" then
			xPlayer.addAccountMoney("money", count)
			TriggerEvent('hrs_loot:log','loot',xPlayer.source,'Situation: **Add Item** \n Item Added: **"'..item..'"**\n Count: **'..count.."**")
			return true
		else
			if xPlayer.canCarryItem(item,count) then
				xPlayer.addInventoryItem(item,count,metadata)
				TriggerEvent('hrs_loot:log','loot',xPlayer.source,'Situation: **Add Item** \n Item Added: **"'..item..'"**\n Count: **'..count.."**")
				return true
			else
				return false
			end
		end
	end

	-- function AddInventoryItem(xPlayer,item,count)
	-- 	if item == "money" then
	-- 		xPlayer.addAccountMoney("money", count)
	-- 		TriggerEvent('hrs_loot:log','loot',xPlayer.source,'Situation: **Add Item** \n Item Added: **"'..item..'"**\n Count: **'..count.."**")
	-- 		return true
	-- 	else
	-- 		if xPlayer.addInventoryItem(item,count) then
	-- 			TriggerEvent('hrs_loot:log','loot',xPlayer.source,'Situation: **Add Item** \n Item Added: **"'..item..'"**\n Count: **'..count.."**")
	-- 			return true
	-- 		else
	-- 			return false
	-- 		end
	-- 	end
	-- end

	function RemoveInventoryItem(xPlayer,item,count) 
		xPlayer.removeInventoryItem(item,count)
	end

	function GetLoopAdd(xPlayer,type,coords,extraInfo)
		--print(extraInfo)

		local loopIncrease = 0

		for k,v in ipairs(Config.lootIncreaseZones) do
			if #(v.coords - coords) < (v.radious or v.radius) then
				if Config.types[type].probabilityLoots.loopIncrease then
					loopIncrease = Config.types[type].probabilityLoots.loopIncrease
				else
					loopIncrease = v.loopIncrease
				end
				
				break
			end
		end
    
		return loopIncrease
	end

end
