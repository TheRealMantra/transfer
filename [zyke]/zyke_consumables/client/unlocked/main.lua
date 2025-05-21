Z.registerCommand(Config.Settings.creatorMenu.command, function(plyId)
    local hasAdminPerms = Z.hasPermission(Config.Settings.creatorMenu.permissions.useMenu)
    local isJobAccess = not hasAdminPerms and Z.isJob(Config.Settings.allowedJobs)
    if (not hasAdminPerms and not isJobAccess) then Z.notify("noPermission") return end

    SetNuiFocus(true, true)
    SendNUIMessage({
        event = "SetItemCreatorOpen",
        data = {
            open = true,
            isJobAccess = isJobAccess
        }
    })
end)

Z.registerCommand(Config.Settings.ingredientMenu.command, function(plyId)
    local hasPerms = Z.hasPermission(Config.Settings.ingredientMenu.permission.useMenu)
    if (not hasPerms) then Z.notify("noPermission") return end

    SetNuiFocus(true, true)
    SendNUIMessage({
        event = "SetIngredientMenuOpen",
        data = {
            open = true
        }
    })
end)