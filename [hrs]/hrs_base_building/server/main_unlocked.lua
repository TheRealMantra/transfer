itemLabels = {}

function getLabel(item)
    if itemLabels[item] then
        return itemLabels[item]
    else
        if Config.itemLabels[item] then
            return Config.itemLabels[item]
        else
            print("item "..item.." does not exist")
            return item.."-ERROR"
        end
    end
end
---------- ESX RELATED

if Config.Framework == "ESX" then

	ESX = exports['es_extended']:getSharedObject()

	-- ESX = nil  
	-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    function loadLabels()
        if Config.inventory == 'ox_inventory' then
            for k,v in pairs(exports.ox_inventory:Items()) do
                itemLabels[k] = v.label
            end
        else
            itemLabels = Config.itemLabels
        end
    end



    CreateThread(function()
		Wait(1000)
		loadLabels()
    end)

	function GetPlayerFromId(source)
		return ESX.GetPlayerFromId(source)
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

	function GetItemCount(xPlayer,item)
		--print(item)
		return xPlayer.getInventoryItem(item).count
	end

	function RemoveInventoryItem(xPlayer,item,count) 
		xPlayer.removeInventoryItem(item,count)
	end


	function GetFailedAdd(xPlayer,list)
		for k,v in ipairs(list) do
			--print(v.name,v.count)
			if xPlayer.canCarryItem(v.name,v.count) then
				xPlayer.addInventoryItem(v.name,v.count)
			else
				return k - 1
			end
		end

		return nil
	end

	function AddItemList(xPlayer,list)
		local failedAdd = GetFailedAdd(xPlayer,list)

		if failedAdd then
			for i = 1, failedAdd do
				local item = list[i]
				xPlayer.removeInventoryItem(item.name,item.count)
			end
		else
			return true
		end
	end

	function AddInventoryItem(xPlayer,item,count)
		if xPlayer.canCarryItem(item,count) then
			xPlayer.addInventoryItem(item,count)
			return true
		else
			return false
		end	
	end

	function GetIdentifier(xPlayer)
		return xPlayer.getIdentifier()
	end

	function ShowNotification(source,text)
		
		TriggerClientEvent('esx:showNotification', source, text)
		
	end

	for k,v in pairs(Config.Models) do
		if v.item and not v.notUseable then
    		ESX.RegisterUsableItem(v.item, function(source)
        		local item = v.item
				local hash = k
        		UseItem(item,hash,source)
    		end)
		end
	end

	function UseItem(item,hash,source)
    	TriggerClientEvent('hrs_base_building:UseItem', source,item,hash)
	end

	function CanCreateProp(xPlayer, hash, coords)
		local item = Config.Models[hash].item
		--local ignoreItem = 

		if item then 
			if HasEnoughtInventoryItem(xPlayer,item,1) then
				RemoveInventoryItem(xPlayer,item,1) 
				return true
			end
			return false
		end

		local crafting = Config.Models[hash].crafting

		if crafting then
			for _,v in ipairs(crafting) do
				if not HasEnoughtInventoryItem(xPlayer,v.name,v.count) then
					return false
				end
			end

			for _,v in ipairs(crafting) do
				RemoveInventoryItem(xPlayer,v.name,v.count) 
			end

			return true
		end

		return false
	end

	ESX.RegisterCommand({'clearbase'}, 'admin', function(xPlayer, args, showError)
		if not args.radius then args.radius = 4 end
		
		local coords = xPlayer.getCoords()
		local pedCoords = vector3(coords.x,coords.y,coords.z)
		for k,v in pairs(props) do
			
			if GetDistanceXY(pedCoords,v.coords) < tonumber(args.radius) then
				DeleteProp(k)
			end
		end
	
		TriggerEvent('esx:admincommandlog',xPlayer.source,args,'clearbase')
	end, false, {help = 'clear base', validate = false, arguments = {
		{name = 'radius', help = "radius", type = 'any'}
	}})

	ESX.RegisterCommand({'openbasestash'}, 'admin', function(xPlayer, args, showError)
		if not args.stashId then return end
		if not props[args.stashId] then return end
		local model = props[args.stashId].hash 

		if not Config.Models[model].type == "storages" then return end
		
		TriggerClientEvent('hrs_base_building:openStorage', xPlayer.source, args.stashId)

	end, false, {help = 'Open a base building stash', validate = false, arguments = {
		{name = 'stashId', help = "prop id", type = 'any'}
	}})

	ESX.RegisterCommand({'debugbaseprops'}, 'admin', function(xPlayer, args, showError)

		TriggerClientEvent('hrs_base_building:propDiscordDebugTool', xPlayer.source)

	end, false, {help = 'Activate/Deactivate prop discord debug', validate = false, arguments = {}})

	function getName(xPlayer)

		if Config.usePlayerFrameworkName then
			if type(xPlayer) == 'number' then
				xPlayer = GetPlayerFromId(xPlayer)
			end
			return xPlayer.getName()
		end

		if type(xPlayer) == 'number' then
			return GetPlayerName(xPlayer)
		else
			--xPlayer = GetPlayerFromId(xPlayer)
			return GetPlayerName(xPlayer.source)
		end

	end

elseif Config.Framework == "QB" then
	
	QBCore = exports['qb-core']:GetCoreObject()

	function loadLabels()
        for k,v in pairs(QBCore.Shared.Items) do
            itemLabels[k] = v.label
        end
    end

	CreateThread(function()
		Wait(1000)
		loadLabels()
    end)

	function GetPlayerFromId(source)
		return QBCore.Functions.GetPlayer(source)
	end

	function HasEnoughtInventoryItem(xPlayer,item,count)
		local itemAmount = xPlayer.Functions.GetItemByName(item)
		if itemAmount and itemAmount.amount >= count then
			return true
		else
			return false
		end
	end

	function GetItemCount(xPlayer,item)
		local itemAmount = xPlayer.Functions.GetItemByName(item)
		if itemAmount and itemAmount.amount then
			return itemAmount.amount
		else
			return 0
		end
	end

	function RemoveInventoryItem(xPlayer,item,count) 
		xPlayer.Functions.RemoveItem(item,count)
	end

	function GetFailedAdd(xPlayer,list)
		for k,v in ipairs(list) do	
			local bool = xPlayer.Functions.AddItem(v.name,v.count)
			if not bool then
				return k
			end
		end

		return nil
	end

	function AddItemList(xPlayer,list)
		local failedAdd = GetFailedAdd(xPlayer,list)

		if failedAdd then
			for i = 1, failedAdd do
				local item = list[i]
				xPlayer.Functions.RemoveItem(item.name,item.count)
			end
		else
			return true
		end
	end

	function AddInventoryItem(xPlayer,item,count) 
		return xPlayer.Functions.AddItem(item,count)
	end


	function GetIdentifier(xPlayer)
		local license = QBCore.Functions.GetIdentifier(xPlayer.PlayerData.source, 'license')
		return license
	end

	function ShowNotification(source,text)
		TriggerClientEvent('QBCore:Notify', source, text)
	end

	for k,v in pairs(Config.Models) do
		if v.item then
			QBCore.Functions.CreateUseableItem(v.item, function(source)
				local src = source
				local item = v.item
				local hash = k
				TriggerClientEvent('hrs_base_building:UseItem', src,item,hash)
    		end)
		end
	end

	function UseItem(item,hash,source)
    	TriggerClientEvent('hrs_base_building:UseItem', source,item,hash)
	end

	function CanCreateProp(xPlayer, hash, coords)
		local item = Config.Models[hash].item

		if item then 
			if HasEnoughtInventoryItem(xPlayer,item,1) then
				RemoveInventoryItem(xPlayer,item,1) 
				return true
			end
			return false
		end

		local crafting = Config.Models[hash].crafting

		if crafting then
			for _,v in ipairs(crafting) do
				if not HasEnoughtInventoryItem(xPlayer,v.name,v.count) then
					return false
				end
			end

			for _,v in ipairs(crafting) do
				RemoveInventoryItem(xPlayer,v.name,v.count) 
			end

			return true
		end

		return false
	end

	QBCore.Commands.Add('clearbase', 'Clears nearby structures (admin)', {}, false, function(xPlayer, args)
        if not args[1] then args[1] = 4 end
        local ped = GetPlayerPed(xPlayer)
        local coords = GetEntityCoords(ped)
        local pedCoords = vector3(coords.x,coords.y,coords.z)
        for k,v in pairs(props) do
            
            if GetDistanceXY(pedCoords,v.coords) < tonumber(args[1]) then
                DeleteProp(k)
            end
        end
    end, 'admin')

	QBCore.Commands.Add('openbasestash', 'Open a base building stash (admin)', {}, false, function(xPlayer, args)
		if not args[1] then return end
		if not props[args[1]] then return end
		local model = props[args[1]].hash 

		if not Config.Models[model].type == "storages" then return end
		
		TriggerClientEvent('hrs_base_building:openStorage', xPlayer, args[1])
    end, 'admin')

	QBCore.Commands.Add('debugbaseprops', 'Activate prop inspect mode (admin)', {}, false, function(xPlayer, args)
		TriggerClientEvent('hrs_base_building:propDiscordDebugTool', xPlayer)
    end, 'admin')

	function getName(xPlayer)

		if Config.usePlayerFrameworkName then
			if type(xPlayer) == 'number' then
				xPlayer = GetPlayerFromId(xPlayer)
			end
			return xPlayer.PlayerData.name
		end

		if type(xPlayer) == 'number' then
			return GetPlayerName(xPlayer)
		else
			--xPlayer = GetPlayerFromId(xPlayer)
			return GetPlayerName(xPlayer.PlayerData.source)
		end

	end

end

--------- CREATING PROPS and DELETE -------------
if Config.inventory == 'qb-inventory' then 

	RegisterNetEvent('qb-inventory:server:stashNew', function(stashName,data)
		local src = source
		exports['qb-inventory']:OpenInventory(src, stashName, data)
	end)

end

if Config.inventory == 'origen_inventory' then 

	RegisterNetEvent('origen_inventory:server:stashNew', function(stashName,data)
		if not exports.origen_inventory:GetStash(stashName) then
			exports.origen_inventory:RegisterStash(stashName, data)
		end

		exports.origen_inventory:OpenInventory(source, 'stash', stashName)
	end)

end

if Config.inventory == 'ox_inventory' then
	RegisterNetEvent('hrs_base_building:oxLoad', function(id,hash)
		if props[id] then
			local date = props[id].date

			local text = 'HRS'..hash..""..id..""..date
			text = string.gsub(text, "-", "n")
			text = string.gsub(text, ":", "")
			text = string.gsub(text, "_", "")
			text = string.gsub(text, "/", "")

			if Config.usingOldInventoryMethod then
				text = 'HRS_'..hash.."_"..id.."_"..date
			end

			exports.ox_inventory:RegisterStash(tostring(text), getLabel(Config.Models[hash].item), Config.Models[hash].slots, Config.Models[hash].weight, false)
		end
	end)
end

RegisterNetEvent('hrs_base_building:getPropData')
AddEventHandler('hrs_base_building:getPropData', function(propId)
	local _source = source

	if not props[propId] then return end

	local message = ""

	for k,v in pairs(props[propId]) do
		if type(v) == "table" then
			message = message .. "\n" .. k..": "..tostring(json.encode(v))
		else
			message = message .. "\n" .. k..": "..v
		end
	end

	ShowNotification(_source, "Prop Discord Log Generated")

	TriggerEvent('hrs_base_building:log','prop_info',_source,message)
end)

function OnPropDelete(id,hash,owner,date)

	if hash and Config.Models[hash].type == "storages" then
		if Config.inventory == 'ox_inventory' then
			local text = 'HRS'..hash..""..id..""..date
			text = string.gsub(text, "-", "n")
			text = string.gsub(text, ":", "")
			text = string.gsub(text, "_", "")
			text = string.gsub(text, "/", "")

			if Config.usingOldInventoryMethod then
				text = 'HRS_'..hash.."_"..id.."_"..date
			end

			exports.ox_inventory:ClearInventory(tostring(text))
		elseif Config.inventory == 'qb_inventory' then 
			local text = 'HRS'..hash..""..id..""..date
			text = string.gsub(text, "-", "n")
			text = string.gsub(text, ":", "")
			text = string.gsub(text, "_", "")
			text = string.gsub(text, "/", "")

			if Config.usingOldInventoryMethod then
				text = 'HRS'..hash..""..id..""..date
				text = string.gsub(text, "-", "_")
			end

			MySQL.Async.execute('DELETE FROM stashitems WHERE stash = @stash', {
				['@stash'] = tostring(text)
			})
		end
	end
end

function OnPropCreate(id,hash,owner,date)

	-- if hash and Config.Models[hash].type == "storages" then
	-- 	local text = 'HRS'..hash..""..id..""..date
	-- 	text = string.gsub(text, "-", "n")
	-- 	text = string.gsub(text, ":", "")
	-- 	text = string.gsub(text, "_", "")
	-- 	text = string.gsub(text, "/", "")
	-- 	text = "stackChest:" .. text

	-- 	MySQL.Async.execute('INSERT INTO summerz_entitydata (dkey, dvalue) VALUES (@dkey, @dvalue)',
	-- 	{
	-- 		['@dkey'] = text,
	-- 		['@dvalue'] = json.encode({})
	-- 	}, function()
		
	-- 	end)
	-- end
end

-------------------- DATABASE 

function ResetProp(k)
	if props[k] then
		props[k].life = Config.Models[props[k].hash].life
		
		MySQL.Async.execute('UPDATE props SET life = @life WHERE id = @id', {
			['@id'] = tonumber(k),
			['@life'] = props[k].life
		})
	end
end



------------ CHECK IF PROP IS MISSING FROM CONFIG --------------------------------------------------------------------

local notFoundProps = {}
local notFoundHashList = ""
local notFoundNumber = 0
function HashNotFoundDatabase(id,hash)
	notFoundProps[id] = hash
	notFoundHashList = notFoundHashList..hash..","
	notFoundNumber = notFoundNumber + 1
end

local notFoundCheckConsole = true
RegisterCommand("clearnotfound", function(source)	
    if source == 0 then
		if notFoundCheckConsole then
			notFoundCheckConsole = false
			print("[^3WARNING^7] Are you sure you want to remove ^5"..notFoundNumber.."^7 Objects from your database? If you do repeat the command")
		else
			for k,v in pairs(notFoundProps) do
				DeletePropJustDatabase(k)
			end
			print("[^2INFO^7] Objects removed from database")
		end
	end
end)

function DeletePropJustDatabase(id)
	MySQL.Async.execute('DELETE FROM props WHERE id = @id', {
		['@id'] = tonumber(id)
	})
end

function NotFoundCheck()
	if notFoundNumber > 0 then
		print("[^3WARNING^7] Seems like some ^5prop models^7 might have been ^5removed^7 from your ^5Config.Models^7")
		print("[^3WARNING^7] A total of ^5"..notFoundNumber.."^7 database props don't have their models in the ^5Config.Models^7")
		print("[^3WARNING^7] This is the list of missing hashes: ^5"..notFoundHashList.."^7")
		print("[^3WARNING^7] If you really removed this hashes from the ^5Config.Models^7 you can clear the database objects using the command ^5'clearnotfound'^7 on your server console^7")
	end
end


---------------------------------------------------------------------------------

function DeleteProp(id)
	local hash = props[id].hash
	local owner = props[id].identifier
	local date = props[id].date
	
	runExtraPropDeleteCode(id)

	if props[id].dead then
		hash = props[id].dead
	end

	if props[id] then
		props[id] = nil
		TriggerClientEvent('hrs_base_building:removeprop', -1,id)
	end

	MySQL.Async.execute('DELETE FROM props WHERE id = @id', {
		['@id'] = tonumber(id)
	})

	OnPropDelete(id,hash,owner,date)
end




MySQL.ready(function()
	MySQL.Async.fetchAll("SELECT * FROM props", {}, function(result)		
		for i = 1,#result do
			FirstPropGeneration(result[i])	
		end
		NotFoundCheck()

		runNewUpkeepFunction()

		runElectricConnectionsCheck()
	end)
	Wait(1000)
	loadCrews()
	TriggerClientEvent("hrs_base_building:juststarted",-1)
end)

function addToDatabase(id)
	local propInfo = props[id]

	runExtraPropCreateCode(id)

	

	OnPropCreate(propInfo.id,propInfo.hash,propInfo.identifier,propInfo.date)
	
	MySQL.Async.execute('INSERT INTO props (id, hash, x, y, z, heading, rotx, roty, rotz, fuel, identifier, life, code, date, bucket) VALUES (@id, @hash, @x, @y, @z, @heading, @rotx, @roty, @rotz, @fuel, @identifier, @life, @code, @date, @bucket)',
	{
		['@id'] = tonumber(id),
		['@hash'] = propInfo.hash,
		['@x'] = propInfo.coords.x,
		['@y'] = propInfo.coords.y,
		['@z'] = propInfo.coords.z,
		['@heading'] = propInfo.heading,
		['@rotx'] = propInfo.rotation.x,
		['@roty'] = propInfo.rotation.y,
		['@rotz'] = propInfo.rotation.z,
		['@fuel'] = propInfo.fuel,
		['@identifier'] = propInfo.identifier,
		['@life'] = propInfo.life,
		['@code'] = propInfo.code,
		['@date'] = propInfo.date,
		['@bucket'] = propInfo.bucket,
	}, function()
	
	end)
end

function updateHashDatabase(propid)
	MySQL.Async.execute('UPDATE props SET life = @life, hash = @hash WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@hash'] = props[propid].hash,
		['@life'] = props[propid].life
	})
end

metadataUpdates = {}

function updateMetadataDatabase(propid)
	MySQL.Async.execute('UPDATE props SET metadata = @metadata WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@metadata'] = json.encode(propsMetadata[propid])
	})
	metadataUpdates[propid] = nil
end

function updateClientMetadataDatabase(propid)
	MySQL.Async.execute('UPDATE props SET clientmetadata = @clientmetadata WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@clientmetadata'] = json.encode(props[propid].clientmetadata)
	})
end

function setMetadata(propid,metadata,database)
	propsMetadata[propid] = metadata 
	if database then
		updateMetadataDatabase(propid)	
	else
		metadataUpdates[propid] = true
	end
end

function getMetadata(propid)
	return propsMetadata[propid] or {}
end

function setClientMetadata(propid,metadata)
	if props[propid] then
		props[propid].clientmetadata = metadata
		updateClientMetadataDatabase(propid)
		TriggerClientEvent("hrs_base_building:updatePropData",-1,propid,"clientmetadata",metadata)	
	end
end

function getClientMetadata(propid)
	if not props[propid] then return nil end
	return props[propid].clientmetadata 
end

function setSessionData(propid,key,value,noSync)
	if props[propid] then
		props[propid][key] = value
		if not noSync then
			TriggerClientEvent("hrs_base_building:updatePropData",-1,propid,key,value)	
		end
	end
end

function setSessionDataList(list,noSync)
	for propid,v in pairs(list) do
		if props[propid] and v.key then
			props[propid][v.key] = v.value
		end
	end

	if not noSync then
		TriggerClientEvent("hrs_base_building:updatePropDataList",-1,list)	
	end
end

function boolToNumber(bool)
	if bool then return 1 end
	return 0
end

function updateLifeDatabase(propid)
	MySQL.Async.execute('UPDATE props SET life = @life, `on` = @on WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@life'] = props[propid].life,
		['@on'] = boolToNumber(props[propid].on),
	})
end

function updateFuelDatabase(propid)
	MySQL.Async.execute('UPDATE props SET fuel = @fuel, `on` = @on WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@fuel'] = props[propid].fuel,
		['@on'] =  boolToNumber(props[propid].on),
	})
end

function updateLifeANDFuelDatabase(propid)
	MySQL.Async.execute('UPDATE props SET life = @life, fuel = @fuel, `on` = @on WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@life'] = props[propid].life,
		['@fuel'] = props[propid].fuel,
		['@on'] =  boolToNumber(props[propid].on),
	})
end

function updateCode(propid)
	MySQL.Async.execute('UPDATE props SET code = @code WHERE id = @id', {
		['@id'] = tonumber(propid),
		['@code'] = props[propid].code
	})
end

function saveOnStopScript()
	print("[^2INFO^7] SAVING ON DATABASE")
	for k,v in pairs(props) do
		if metadataUpdates[k] then
			MySQL.Async.execute('UPDATE props SET life = @life, fuel = @fuel, metadata = @metadata, `on` = @on WHERE id = @id', {
				['@id'] = tonumber(k),
				['@life'] = props[k].life,
				['@fuel'] = props[k].fuel,
				['@metadata'] = json.encode(propsMetadata[k]),
				['@on'] =  boolToNumber(props[k].on),
			})
			metadataUpdates[k] = nil
		else
			MySQL.Async.execute('UPDATE props SET life = @life, fuel = @fuel, `on` = @on  WHERE id = @id', {
				['@id'] = tonumber(k),
				['@life'] = props[k].life,
				['@fuel'] = props[k].fuel,
				['@on'] =  boolToNumber(props[k].on),
			})
		end
	end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
		saveOnStopScript()
	end    
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
		saveOnStopScript()
	end    
end)

RegisterCommand('forcebasesave',function(source)
	if source > 0 then return end
	saveOnStopScript()
end)


-- RegisterCommand('testsave',function()
-- 	local nClock = os.clock()
-- 	saveOnStopScript()
-- 	print(os.clock() - nClock)
-- end)








----------------------- CREWS ------------------------------------
crews = {}
crewByIdentifier = {}
onlineIdentifiers = {}
invites = {}
lastOfflineIdentifiers = {}

-- RegisterCommand("basesrepair",function()
-- runNewUpkeepFunction(propsUpkeep)
-- end)

if Config.hourUpkeepCheck then
	CreateThread(function()
		while true do
			Wait(1000 * 60 * 60)
			runNewUpkeepFunction(propsUpkeep)
		end
	end)
end



function isOwnedByCrew(id)
	local identifier = props[id].identifier
	local crew = crewByIdentifier[identifier]
	if crew then
		return true, crew
	end
	return false, identifier 
end

function isPartOfCrew(identifier)
	local crew = crewByIdentifier[identifier]
	if crew then
		if crews[crew].data and crews[crew].data[identifier] then
			return true, crew
		end
	end
	return false, identifier 
end



function sendOwnerNotification(id, message)
	local identifier = props[id].identifier
	local crew = crewByIdentifier[identifier]
	if crew then

		local discordMessage = nil

		for k, v in pairs(crews[crew].data) do
			if onlineIdentifiers[k] then
				ShowNotification(onlineIdentifiers[k],message)
			end

			if v.discord then

				if not discordMessage then
					discordMessage = ""
				end

				discordMessage = discordMessage .. "<@"..v.discord..">"

				if Config.raidNotificationDiscordDm then
					sendDm("dms",v.discord,"<@"..v.discord..">".." "..message)
				end
			end
		end

		if discordMessage then
			if Config.raidNotificationDiscord then
				TriggerEvent('hrs_base_building:log','raid_notify',nil,message.."\n"..discordMessage)
			end
		end

		return 
	end
	
	if onlineIdentifiers[identifier] then
		ShowNotification(onlineIdentifiers[k],message)
	end
end

function updateCrewData(crewId,bypassDb)

	for k, v in pairs(crews[crewId].data) do
		if onlineIdentifiers[k] then
			TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[k],crews[crewId])
		end
	end

	if not bypassDb then
		MySQL.Async.execute('UPDATE crews SET data = @data WHERE owner = @owner', {
			['@data'] = json.encode(crews[crewId].data),
			['@owner'] = crewId
		})
	end

end

function offlineRaidCheck(id,ignoreRaidTime)
	if not Config.disableOfflineRaiding then return true end

	local crewBool, identifier = isOwnedByCrew(id)

	if crewBool then
		for k,v in pairs(crews[identifier].data) do
			if onlineIdentifiers[k] or lastOfflineIdentifiers[k] then

				if not ignoreRaidTime then
					lastRaidEvents[identifier] = Config.offlineRaidingRaidingTime
				end

				return true
			end
		end
	else
		if onlineIdentifiers[identifier] or lastOfflineIdentifiers[identifier] then

			if not ignoreRaidTime then
				lastRaidEvents[identifier] = Config.offlineRaidingRaidingTime
			end

			return true
		end
	end

	if lastRaidEvents[identifier] then
		return true
	end

	return false
end

function getUserDiscord(source)
	local discord = GetPlayerIdentifierByType(source, 'discord')
	if not discord then return nil end
	local discordId = string.gsub(discord, "discord:", "")
	return discordId
end

RegisterNetEvent('hrs_base_building:getCrewS')
AddEventHandler('hrs_base_building:getCrewS', function()
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	onlineIdentifiers[identifier] = source

	if Config.disableOfflineRaiding and Config.offlineRaidingDisconnectTime then
		lastOfflineIdentifiers[identifier] = nil
	end

	local crewBool, crewId = isPartOfCrew(identifier)

	local sendCrew = nil
	if crewBool then
	
		local discordId = getUserDiscord(_source)

		if discordId and crews[crewId].data[identifier].discord ~= discordId then
			crews[crewId].data[identifier].discord = discordId
			updateCrewData(crewId)
		end

		sendCrew = crews[crewId]
	end

	TriggerClientEvent('hrs_base_building:setCrewC',_source,sendCrew)

	Player(_source).state:set("hrsIdent", identifier, true)
	
	TriggerClientEvent('hrs_base_building:setInvitesC',_source,invites[identifier])
end)

AddEventHandler('playerDropped', function ()
	for k,v in pairs(onlineIdentifiers) do
		if v == source then

			if Config.disableOfflineRaiding and Config.offlineRaidingDisconnectTime then
				lastOfflineIdentifiers[k] = {time = Config.offlineRaidingDisconnectTime}	
			end

			onlineIdentifiers[k] = nil

			break
		end
	end
end)

function loadCrews()
	MySQL.Async.fetchAll("SELECT * FROM crews", {}, function(result)		
		for k,v in ipairs(result) do
			crews[v.owner] = {data = json.decode(v.data),label = v.label,owner = v.owner}
			
			local needUpdate = false
			for k2,v2 in pairs(crews[v.owner].data) do

				if type(v2) ~= 'table' then
					crews[v.owner].data[k2] = {name = v2}
					needUpdate = true
				end

				crewByIdentifier[k2] = v.owner
			end

			if needUpdate then
				MySQL.Async.execute('UPDATE crews SET data = @data WHERE owner = @owner', {
					['@data'] = json.encode(crews[v.owner].data),
					['@owner'] = v.owner
				})
			end
		end
	end)
end

RegisterNetEvent('hrs_base_building:createCrew')
AddEventHandler('hrs_base_building:createCrew', function(label)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)


	if Config.disableCrewManagementDuringRaidingTime then

		local crewBool, identifierVal = isPartOfCrew(identifier)

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	local name = getName(xPlayer)

	if not label then
		label = name.."'s Crew"
	end

	if not crews[identifier] and not crewByIdentifier[identifier] then
		crews[identifier] = {
			label = label,
			data = {
				[identifier] = {name = name,discord = getUserDiscord(_source)}
			},
			owner = identifier
		}

		crewByIdentifier[identifier] = identifier

		TriggerClientEvent('hrs_base_building:setCrewC',_source,crews[identifier])
		ShowNotification(_source,Config.Locales["crew_created"])

		MySQL.Async.execute('INSERT INTO crews (owner, label, data) VALUES (@owner, @label, @data)',
		{
			['@owner'] = identifier,
			['@label'] = label,
			['@data'] = json.encode(crews[identifier].data)
		})
	end
end)

RegisterNetEvent('hrs_base_building:deleteCrew')
AddEventHandler('hrs_base_building:deleteCrew', function()
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	if Config.disableCrewManagementDuringRaidingTime then

		local crewBool, identifierVal = isPartOfCrew(identifier)

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	if crews[identifier] then
		for k, v in pairs(crews[identifier].data) do
			crewByIdentifier[k] = nil
			if onlineIdentifiers[k] then
				TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[k],nil)

				ShowNotification(onlineIdentifiers[k],Config.Locales["crew_deleted"])
			end
		end

		crews[identifier] = nil

		MySQL.Async.execute('DELETE FROM crews WHERE owner = @owner', {
			['@owner'] = identifier
		})
	end
end)

RegisterNetEvent('hrs_base_building:addToCrew')
AddEventHandler('hrs_base_building:addToCrew', function(id)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	local toAddSource = id 
	local yPlayer = GetPlayerFromId(toAddSource)
	local yidentifier = GetIdentifier(yPlayer)

	local crewBool, identifierVal = isPartOfCrew(identifier)

	if Config.disableCrewManagementDuringRaidingTime then

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

		crewBool2, identifierVal2 = isPartOfCrew(yidentifier)

		if lastRaidEvents[identifierVal2] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	if crewByIdentifier[yidentifier] then
		ShowNotification(_source,Config.Locales["crew_player_on_crew"])
	else
		if crews[identifierVal] then
			local limit = false
			if Config.maxCrewMembers then
				local count = 0
				for k,v in pairs(crews[identifierVal].data) do
					count = count + 1
					if count >= Config.maxCrewMembers then
						limit = true
						break
					end
				end
			end

			if limit then
				ShowNotification(_source,Config.Locales["crew_crew_limit"])
			else
				if not invites[yidentifier] then invites[yidentifier] = {} end

				if not invites[yidentifier][identifierVal] then
					invites[yidentifier][identifierVal] = crews[identifierVal].label
					
					TriggerClientEvent('hrs_base_building:setInvitesC',id,invites[yidentifier])
					ShowNotification(id,Config.Locales["crew_new_invite"])
					ShowNotification(_source,Config.Locales["crew_you_invited"]..getName(id)..Config.Locales["crew_to_crew"])
				else
					ShowNotification(_source,Config.Locales["crew_already_invited"])
				end
			end
		else
			ShowNotification(_source,Config.Locales["crew_no_crew"])
		end
	end
end)

RegisterNetEvent('hrs_base_building:acceptCrew')
AddEventHandler('hrs_base_building:acceptCrew', function(ident)
	
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	if Config.disableCrewManagementDuringRaidingTime then

		local crewBool, identifierVal = isPartOfCrew(identifier)

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	if invites[identifier] and invites[identifier][ident] and crews[ident] then

		local limit = false
		if Config.maxCrewMembers then
			local count = 0
			for k,v in pairs(crews[ident].data) do
				count = count + 1
				if count >= Config.maxCrewMembers then
					limit = true
					break
				end
			end
		end

		if limit then
			ShowNotification(_source,Config.Locales["crew_limit_reached"])
		else
			crews[ident].data[identifier] = {name = getName(xPlayer), discord = getUserDiscord(_source)}
			crewByIdentifier[identifier] = ident
			
			for k, v in pairs(crews[ident].data) do
				if onlineIdentifiers[k] then
					if onlineIdentifiers[k] == _source then
						ShowNotification(_source,Config.Locales["crew_invite_accepted"])
					else
						ShowNotification(onlineIdentifiers[k],crews[ident].data[identifier].name..Config.Locales["crew_new_to_crew"])
					end

					TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[k],crews[ident])
				end
			end

			invites[identifier] = nil

			TriggerClientEvent('hrs_base_building:setInvitesC',onlineIdentifiers[identifier],nil)

			
			ShowNotification(_source,Config.Locales["crew_joined"]..crews[ident].label)
			

			MySQL.Async.execute('UPDATE crews SET data = @data WHERE owner = @owner', {
				['@data'] = json.encode(crews[ident].data),
				['@owner'] = ident
			})
		end
	end
end)


RegisterNetEvent('hrs_base_building:updateCrewPerms')
AddEventHandler('hrs_base_building:updateCrewPerms', function(otherIdentifier, perms)
	debug(otherIdentifier, perms)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	local crewBool, identifierVal = isPartOfCrew(identifier)
	local crewBool2, identifierVal2 = isPartOfCrew(otherIdentifier)

	if crewBool and crewBool2 and identifierVal == identifierVal2 then
		crews[identifierVal].data[otherIdentifier].permissions = perms

		updateCrewData(identifierVal)

		ShowNotification(_source,Config.Locales["updated_perms"]) 

	else
		ShowNotification(_source,Config.Locales["fail_updated_perms"]) 
	end

	
end)

RegisterNetEvent('hrs_base_building:updateCrewName')
AddEventHandler('hrs_base_building:updateCrewName', function(newName)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)
	local crewBool, identifierVal = isPartOfCrew(identifier)

	if newName and crewBool and identifier == identifierVal then
		crews[identifierVal].label = newName

		updateCrewData(identifierVal,true)

		MySQL.Async.execute('UPDATE crews SET label = @label WHERE owner = @owner', {
			['@label'] = newName,
			['@owner'] = identifier
		})


		ShowNotification(_source,Config.Locales["new_name_crew"]) 
	end

end)

RegisterNetEvent('hrs_base_building:updateCrewOwner')
AddEventHandler('hrs_base_building:updateCrewOwner', function(newOwner)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)
	local crewBool, identifierVal = isPartOfCrew(identifier)
	local crewBool2, identifierVal2 = isPartOfCrew(newOwner)

	if crewBool and crewBool2 and identifierVal == identifierVal2 and identifier == identifierVal then
		local label = crews[identifierVal]
		local data = crews[identifierVal].data

		crews[newOwner] = {
			data = {},
			label = crews[identifierVal].label,
			owner = newOwner
		}

		for k,v in pairs(crews[identifierVal].data) do
			crews[newOwner].data[k] = v
			crewByIdentifier[k] = newOwner
		end

		crews[identifierVal] = nil

		MySQL.Async.execute('DELETE FROM crews WHERE owner = @owner', {
			['@owner'] = identifierVal
		})

		MySQL.Async.execute('INSERT INTO crews (owner, label, data) VALUES (@owner, @label, @data)',
		{
			['@owner'] = newOwner,
			['@label'] = crews[newOwner].label,
			['@data'] = json.encode(crews[newOwner].data)
		})

		updateCrewData(newOwner,true)

		ShowNotification(_source,Config.Locales["new_crew_owner"])
		if onlineIdentifiers[newOwner] then
			ShowNotification(_source,Config.Locales["new_crew_owner_notify"])
		end

	end

end)


RegisterNetEvent('hrs_base_building:leaveCrew')
AddEventHandler('hrs_base_building:leaveCrew', function()
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	if Config.disableCrewManagementDuringRaidingTime then

		local crewBool, identifierVal = isPartOfCrew(identifier)

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	if crewByIdentifier[identifier] and crews[crewByIdentifier[identifier]] then
		local ident = crewByIdentifier[identifier]

		crews[ident].data[identifier] = nil
		crewByIdentifier[identifier] = nil
		
		TriggerClientEvent('hrs_base_building:setCrewC',_source,nil)

		for k, v in pairs(crews[ident].data) do
			if onlineIdentifiers[k] then

				if onlineIdentifiers[k] == _source then
					ShowNotification(_source,Config.Locales["crew_you_left"])
				else
					ShowNotification(onlineIdentifiers[k],getName(xPlayer)..Config.Locales["crew_left_crew"])
				end

				TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[k],crews[ident])
			end
		end

		MySQL.Async.execute('UPDATE crews SET data = @data WHERE owner = @owner', {
			['@data'] = json.encode(crews[ident].data),
			['@owner'] = ident
		})
	end
end)

RegisterNetEvent('hrs_base_building:removeFromCrew')
AddEventHandler('hrs_base_building:removeFromCrew', function(yidentifier)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)

	local crewBool, identifierVal = isPartOfCrew(identifier)

	if Config.disableCrewManagementDuringRaidingTime then

		

		if lastRaidEvents[identifierVal] then
			ShowNotification(_source,Config.Locales["no_edit_crew"])
			return
		end

	end

	if crews[identifierVal] and yidentifier ~= identifierVal then
		crews[identifierVal].data[yidentifier] = nil
		crewByIdentifier[yidentifier] = nil

		if onlineIdentifiers[yidentifier] then
			TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[yidentifier],nil)
		end

		for k, v in pairs(crews[identifierVal].data) do
			if onlineIdentifiers[k] then
				TriggerClientEvent('hrs_base_building:setCrewC',onlineIdentifiers[k],crews[identifierVal])
			end
		end

		ShowNotification(_source,Config.Locales["crew_player_removed"])

		if onlineIdentifiers[yidentifier] then
			ShowNotification(onlineIdentifiers[yidentifier],Config.Locales["crew_you_removed"])
		end

		MySQL.Async.execute('UPDATE crews SET data = @data WHERE owner = @owner', {
			['@data'] = json.encode(crews[identifierVal].data),
			['@owner'] = identifierVal
		})
	end
end)



-------------------- permissions
function hasPermission(identifier,id)
	if identifier == props[id].identifier then
		return true
	end

	if crewByIdentifier[identifier] and crews[crewByIdentifier[identifier]] and crews[crewByIdentifier[identifier]].data[props[id].identifier] then
		return true		
	end

	return false
end


function hasPermissionVeh(identifier,identifier2)

	if identifier == identifier2 then
		return true
	end

	if crewByIdentifier[identifier] and crews[crewByIdentifier[identifier]] and crews[crewByIdentifier[identifier]].data[identifier2] then
		return true		
	end

	return false
end

function hasCrewPermission(myIdentifier, otherIdentifier, permissionType)
	--debug('hasCrewPermission', myIdentifier, otherIdentifier, permissionType)
    if myIdentifier == otherIdentifier then
        return true
    end

	if not crewByIdentifier[myIdentifier] then 
		return false
	end

	if not crews[crewByIdentifier[myIdentifier]] then
		return false
	end

	if otherIdentifier then
		if not crews[crewByIdentifier[myIdentifier]].data[otherIdentifier] then
			return false
		end
	end

	if crews[crewByIdentifier[myIdentifier]].owner == myIdentifier then
		return true
	end

	if not permissionType then 
        return true
    end

	if not crews[crewByIdentifier[myIdentifier]].data[myIdentifier].permissions then
		return false
	end

	local permissionTypeKey = Config.crewPermissionsById[permissionType]

	if crews[crewByIdentifier[myIdentifier]].data[myIdentifier].permissions[permissionTypeKey] then
		return true
	end

    return false
end

exports("hasPermissionVeh", hasPermissionVeh)

exports("hasCrewPermission", hasCrewPermission)


--------------------------------------------------------------


------------------------------------ RANDOM FUCNTIONS

function GetDistanceXY(firstVec,secondVec)
    return #(firstVec.xy - secondVec.xy)
end

function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end


-----------------------------
RegisterNetEvent('hrs_base_building:trigger')
AddEventHandler('hrs_base_building:trigger', function(propid,Object)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	local identifier = GetIdentifier(xPlayer)
	local modelConfig = Config.Models[props[propid].hash]

	if modelConfig.noPermission or hasCrewPermission(identifier,props[propid].identifier,'canInteract') then
		TriggerClientEvent('hrs_base_building:triggerfinal',_source,props[propid].hash,Object)
	else
		ShowNotification(source,Config.Locales["no_permission"])	
	end			
end)


-- this trigger should be added to your change bucket script so the base building can know


-- RegisterCommand("setbucket", function(source, args, rawCommand)
-- 	SetPlayerRoutingBucket(tonumber(args[1]),tonumber(args[2]))
-- 	TriggerClientEvent('hrs_base_building:changebucket',tonumber(args[1]),tonumber(args[2]))
-- end,true)

if Config.useRoutingBucketsThread then
	local lastBuckets = {}	
	CreateThread(function()
		while true do
			Wait(1000)
			local Players = GetPlayers()
			local buckets = {}
			for k,v in ipairs(Players) do
				local currentBucket = GetPlayerRoutingBucket(v)			
				if lastBuckets[v] and lastBuckets[v] ~= currentBucket or not lastBuckets[v] then
					TriggerClientEvent('hrs_base_building:changebucket',v,currentBucket)
				end
				buckets[v] = currentBucket
			end	
			lastBuckets = buckets
		end
	end)
end


------------------------ EXPLODE ----------------------
RegisterNetEvent('hrs_base_building:canRaid')
AddEventHandler('hrs_base_building:canRaid', function(propid)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)
	if not props[propid] then return end

	if props[propid].dead then
		ShowNotification(_source,Config.Locales["no_explode"]) 
		return 
	end

	if not offlineRaidCheck(propid, true) then
		ShowNotification(_source,Config.Locales["no_offline_raid"])
		return
	end

	if not isRaidActiveNow() then
		ShowNotification(_source,Config.Locales["no_raid_now"])
		return
	end

	ShowNotification(_source,Config.Locales["inspect_raid_can"])
end)


RegisterNetEvent('hrs_base_building:hasexplosive')
AddEventHandler('hrs_base_building:hasexplosive', function(propid)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)

	if not props[propid] then return end

	local weakerItem = nil

	for itemName,v in pairs(Config.explosionItems) do
		if HasEnoughtInventoryItem(xPlayer,itemName,1) then
			if not weakerItem then
				weakerItem = itemName
			else
				if v.damage < Config.explosionItems[weakerItem].damage then
					weakerItem = itemName
				end
			end
		end
	end

	if not weakerItem then 
		ShowNotification(_source,Config.Locales["no_c4"])
		return
	end

	if props[propid].dead then
		ShowNotification(_source,Config.Locales["no_explode"]) 
		return 
	end

	if not offlineRaidCheck(propid) then
		ShowNotification(_source,Config.Locales["no_offline_raid"])
		return
	end

	if not isRaidActiveNow() then
		ShowNotification(_source,Config.Locales["no_raid_now"])
		return
	end

	local coordsVect = props[propid].coords
	
	RemoveInventoryItem(xPlayer,weakerItem,1)

	TriggerEvent('hrs_base_building:log','raid',_source,'Situation: **BASE RAID** \n Item: **"'..weakerItem..'"**\n Location: **'..props[propid].coords..'**\n Prop id: **'..propid..'**\n Owner: **'..props[propid].identifier..'**')
	
	TriggerClientEvent('hrs_base_building:explosionEffect', _source, coordsVect,weakerItem)
		
	if Config.explosionItems[weakerItem].delay then
		Wait(Config.explosionItems[weakerItem].delay * 1000)
	end

	if not props[propid] then return end

	props[propid].life = props[propid].life - Config.explosionItems[weakerItem].damage

	if Config.raidNotification then
		local boolCrew, identifierCrew = isPartOfCrew(props[propid].identifier)

		if not isNotificationWait(identifierCrew) then
			startNotificationWait(identifierCrew)
			sendOwnerNotification(propid, Config.Locales["base_raiding_message"])
		end
	end

	if props[propid].life <= 0.0 then
		if Config.Models[props[propid].hash].type == "storages" or getMetadata(propid).items then
			props[propid].dead = props[propid].hash
			props[propid].hash = Config.deadStorage
			props[propid].life = Config.Models[Config.deadStorage].life
			TriggerClientEvent('hrs_base_building:replaceprop', -1,propid,props[propid])

			updateHashDatabase(propid)
		else
			DeleteProp(propid)
		end	
	else
		updateLifeDatabase(propid)
	end

end)

RegisterNetEvent('hrs_base_building:hasexplosive2')
AddEventHandler('hrs_base_building:hasexplosive2', function(propid,weapon)
	
	local _source = source
	local xPlayer = GetPlayerFromId(_source)

	if not props[propid] then return end
	if props[propid].dead then return end
	if not props[propid] then return end

	if not offlineRaidCheck(propid) then
		ShowNotification(_source,Config.Locales["no_offline_raid"])
		return
	end

	if not isRaidActiveNow() then
		ShowNotification(_source,Config.Locales["no_raid_now"])
		return
	end

	TriggerEvent('hrs_base_building:log','raid',_source,'Situation: **BASE RAID** \n Weapon: **"'..weapon..'"**\n Location: **'..props[propid].coords..'**\n Prop id: **'..propid..'**\n Owner: **'..props[propid].identifier..'**')

	props[propid].life = props[propid].life - Config.weaponsDamage[weapon]

	if Config.raidNotification then
		local boolCrew, identifierCrew = isPartOfCrew(props[propid].identifier)

		if not isNotificationWait(identifierCrew) then
			startNotificationWait(identifierCrew)
			sendOwnerNotification(propid, Config.Locales["base_raiding_message"])
		end
	end
	
	if props[propid].life <= 0.0 then
		if Config.Models[props[propid].hash].type == "storages" or getMetadata(propid).items then
			props[propid].dead = props[propid].hash
			props[propid].hash = Config.deadStorage
			props[propid].life = Config.Models[Config.deadStorage].life
			TriggerClientEvent('hrs_base_building:replaceprop', -1,propid,props[propid])

			updateHashDatabase(propid)
		else
			DeleteProp(propid)
		end	
	else
		updateLifeDatabase(propid)
	end

end)

function raidScheduleStatusChanged(bool,finish)
	if bool then
		ShowNotification(-1,Config.Locales["raid_set_true"])
		TriggerEvent('hrs_base_building:log','raid_status_true',_source,'**🔔 The Time Has Come! 🔔**  **🏴 RAIDING HOURS HAVE BEGUN! 🏴** ')
	else
		ShowNotification(-1,Config.Locales["raid_set_false"])
		TriggerEvent('hrs_base_building:log','raid_status_false',_source,'**🔔 The Chaos Has Ceased! 🔔**  **🏳️ RAIDING HOURS HAVE ENDED! 🏳️**  ')
	end
end











-- function doDBCheck()

-- 	local result = exports.oxmysql:executeSync("SELECT DATABASE()")

-- 	local databaseName = nil

-- 	if result and #result > 0 then
-- 		databaseName = result[1]['DATABASE()']
-- 		print("[^2INFO^7] Current database name: " .. databaseName)
-- 	else
-- 		print("[^2INFO^7] Failed to retrieve the database name.")
-- 	end

-- 	if not databaseName then return end


-- 	local tableName = 'props2'
-- 	local columnsToCheck = {
-- 		{name = 'id', type = 'int(11) NOT NULL DEFAULT 0'},
-- 		{name = 'identifier', type = 'varchar(255) DEFAULT NULL'},
-- 		{name = 'hash', type = 'varchar(50) DEFAULT NULL'},
-- 		{name = 'x', type = 'float DEFAULT NULL'},
-- 		{name = 'y', type = 'float DEFAULT NULL'},
-- 		{name = 'z', type = 'float DEFAULT NULL'},
-- 		{name = 'heading', type = 'float DEFAULT NULL'},
-- 		{name = 'rotx', type = 'float DEFAULT NULL'},
-- 		{name = 'roty', type = 'float DEFAULT NULL'},
-- 		{name = 'rotz', type = 'float DEFAULT NULL'},
-- 		{name = 'life', type = 'float DEFAULT NULL'},
-- 		{name = 'code', type = 'varchar(50) DEFAULT NULL'},
-- 		{name = 'fuel', type = 'int(11) DEFAULT NULL'},
-- 		{name = 'date', type = 'varchar(50) DEFAULT NULL'},
-- 		{name = 'bucket', type = 'int(11) DEFAULT 0'},
-- 		{name = 'on', type = 'tinyint(1) DEFAULT 0'},
-- 		{name = 'metadata', type = 'longtext DEFAULT NULL'},
-- 		{name = 'clientmetadata', type = 'longtext DEFAULT NULL'}
-- 	}

-- 	local propsTableResult = exports.oxmysql:executeSync([[SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ? AND TABLE_SCHEMA = ?]], {tableName, databaseName})

-- 	if #propsTableResult > 0 then
-- 		print("[^2INFO^7] props TABLE EXISTS")
-- 	else
-- 		print("[^2INFO^7] props TABLE DOES NOT EXIST")
-- 		local createTableQuery = "CREATE TABLE IF NOT EXISTS `"..tableName.."` (\n"
-- 		for _, column in ipairs(columnsToCheck) do
-- 			createTableQuery = createTableQuery .. " `" .. column.name .. "` " .. column.type .. ",\n"
-- 		end
-- 		createTableQuery = createTableQuery .. " PRIMARY KEY (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;"
-- 		exports.oxmysql:executeSync(createTableQuery)
-- 		print("[^2INFO^7] props TABLE CREATED")
-- 	end

-- 	local checkColumnsQuery = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ? AND TABLE_SCHEMA = ?"

-- 	local result = exports.oxmysql:executeSync(checkColumnsQuery, {tableName,databaseName})

-- 	local existingColumns = {}
-- 	for _, column in ipairs(result) do
-- 		existingColumns[column.COLUMN_NAME] = true
-- 	end

-- 	local missingColumns = {}
-- 	for _, column in ipairs(columnsToCheck) do
-- 		if not existingColumns[column.name] then
-- 			table.insert(missingColumns, column)
-- 		end
-- 	end

-- 	if #missingColumns > 0 then
-- 		for _, column in ipairs(missingColumns) do
-- 			local addColumnQuery = string.format("ALTER TABLE `%s` ADD COLUMN `%s` %s", tableName, column.name, column.type)
-- 			exports.oxmysql:executeSync(addColumnQuery)
-- 			print("[^2INFO^7] ADDED COLUMN: " .. column.name)
-- 		end
-- 	else
-- 		print("[^2INFO^7] NO MISSING COLUMNS")
-- 	end
	
-- end

-- doDBCheck()








--------------------------- cliam flag ------------------------------------------------

RegisterNetEvent('hrs_base_building:reclaimObjects')
AddEventHandler('hrs_base_building:reclaimObjects', function(id,list)
	if not props[id] then return end
	if not Config.Models[props[id].hash].type == 'buildFlag' then return end

	local _source = source
	local newOwner = props[id].identifier
	local radius = Config.Models[props[id].hash].buildRadius or 25.0
	local coords = props[id].coords

	local updatedData = {}

	for _, propId in ipairs(list) do
		if props[propId] then
			if GetDistanceXY(coords, props[propId].coords) < radius then
				props[propId].identifier = newOwner

				updatedData[propId] = {key = 'identifier', value = newOwner}

				MySQL.Async.execute('UPDATE props SET identifier = @identifier WHERE id = @id', {
					['@id'] = tonumber(propId),
					['@identifier'] = props[propId].identifier
				})
			end
		end
	end

	setSessionDataList(updatedData)
	ShowNotification(_source, "You claimed "..#list.." objects")
end)