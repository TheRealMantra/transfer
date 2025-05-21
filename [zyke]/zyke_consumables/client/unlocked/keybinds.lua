while (not Translations) do Wait(0) end

Z.registerKey("consumables:use", Config.Settings.keys["use"], T("controls:use:description"), function()
    if (Cache.interacting) then Z.notify("selfOccupied") return end

    local success, reason = UseItem(Cache.item)
    if (not success and reason ~= "noItemEquipped" and reason) then Z.notify(reason) end
end)

Z.registerKey("consuambles:unequip", Config.Settings.keys["unequip"], T("controls:unequip:description"), function()
    if (Cache.interacting) then Z.notify("selfOccupied") return end

    local success, reason = UnequipItem("self")
    if (not success and reason ~= "noItemEquipped") then Z.notify(reason) end
end)

Z.registerKey("consumables:placeItem", Config.Settings.keys["placeItem"], T("controls:place:description"), function()
    if (Cache.interacting) then Z.notify("selfOccupied") return end

    local success, reason = PlaceItem()
    if (not success and (reason ~= "noItemEquipped" and reason ~= "resetting")) then Z.notify(reason) end
end)