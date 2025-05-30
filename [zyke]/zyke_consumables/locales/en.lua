return {
    ["noIdentifier"] = {msg = "Could not find your character identifier.", type = "error"},
    ["noIdentifier2"] = {msg = "Could not find character identifier.", type = "error"},
    ["noPermission"] = {msg = "You are not allowed to do this.", type = "error"},
    ["selfOccupied"] = {msg = "You are already occupied.", type = "error"},
    ["otherOccupied"] = {msg = "This person is already occupied.", type = "error"},
    ["noItemEquipped"] = {msg = "You don't have any item equipped"},
    ["alreadyBeingInteracted"] = {msg = "This item is already being interacted with.", type = "error"},
    ["alreadyEquipped"] = {msg = "This item is already equipped.", type = "error"},
    ["notAuthorized"] = {msg = "You are not authorized to do this.", type = "error"},
    ["emptyItem"] = {msg = "Your item is empty.", type = "error"},
    ["noWorldItemLoaded"] = {msg = "This item can not be loaded.", type = "error"},
    ["itemIsNotInWorld"] = {msg = "This item can not be found in the world.", type = "error"},
    ["tooFarToPickup"] = {msg = "This item is too far away to pick up.", type = "error"},
    ["tooFarToPlace"] = {msg = "This item is too far away to place.", type = "error"},
    ["savedItem"] = {msg = "Item has been saved.", type = "success"},
    ["createdItem"] = {msg = "Item has been created.", type = "success"},
    ["itemRemovedFromCreator"] = {msg = "This item is no longer usable.", type = "error"},
    ["missingItemSettings"] = {msg = "This item doesn't have any settings saved yet."},
    ["missingIngredientSettings"] = {msg = "This ingredient doesn't have any settings saved yet."},
    ["missingItems"] = {msg = "You are missing items (%s)."}, -- %s = list of items
    ["craftedItems"] = {msg = "Crafted %x %s."}, -- %s = amount, %s = item label
    ["savedIngredient"] = {msg = "Ingredient has been saved.", type = "success"},
    ["createdIngredient"] = {msg = "Ingredient has been created.", type = "success"},
    ["ingredientRemovedFromCreator"] = {msg = "This ingredient is no longer usable.", type = "error"},
    ["missingItemType"] = {msg = "Missing item type.", type = "error"},
    ["invalidIngredientAmount"] = {msg = "Your ingredient amount is invalid.", type = "error"},

    -- Item validation nottifications
    ["invalidModels"] = {msg = "You have invalid models.", type = "error"},
    ["invalidPropModels"] = {msg = "You have invalid prop models.", type = "error"},
    ["itemAlreadyExists"] = {msg = "This item already exists.", type = "error"},
    ["invalidItem"] = {msg = "The item is invalid.", type = "error"},
    ["noItemData"] = {msg = "No item data could be found", type = "error"},
    ["invalidUseAmount"] = {msg = "Your use amount is invalid.", type = "error"},
    ["invalidAnim"] = {msg = "Your animation combination is invalid.", type = "error"},
    ["missingProps"] = {msg = "This item has no props.", type = "error"},
    ["invalidItemType"] = {msg = "The item type is invalid.", type = "error"},
    ["invalidImageUrl"] = {msg = "The image URL you provided is invalid.", type = "error"},
    ["jobLockedItemRequiresIngredients"] = {msg = "This item is job locked and requires ingredients as the consumption reward.", type = "error"},

    -- World Item Interactions
    ["pickupItem"] = "Pickup",

    -- Item descriptions
    ["itemDescription:drink"] = "Remaining: %sml",
    ["itemDescription:food"] = "Remaining: %sg",
    ["itemDescription:one_hit"] = "Remaining: %sx",
    ["itemDescription:ingredient:quality"] = "Quality: %s%%", --%s = quality

    ["controls:use:description"] = "Use Current Item",
    ["controls:place:description"] = "Place Current Item",
    ["controls:unequip:description"] = "Unequip Item",

    -- UI
    ["cancel"] = "Cancel",
    ["confirm"] = "Confirm",
    ["delete"] = "Delete",
    ["quality"] = "Quality",

    -- Item Creator
    ["ic:title"] = "Item Creator",
    ["ic:itemSearchLabel"] = "Search",
    ["ic:create"] = "Create",
    ["ic:creating"] = "Creating",
    ["ic:editing"] = "Editing",
    ["ic:save"] = "Save",
    ["ic:itemLabel"] = "Item Label",
    ["ic:unusedItems"] = "Unused Items",
    ["ic:unusedItemsPlaceholder"] = "Select an item",
    ["ic:useAmount"] = "Use Amount",
    ["ic:addProp"] = "Add More",
    ["ic:deleteProp"] = "Delete",
    ["ic:makePrimary"] = "Make Primary",
    ["ic:itemSearchPlaceholder"] = "Burger",
    ["ic:dummyItemLabel"] = "Create More Items!",
    ["ic:createItem"] = "Create Item",
    ["ic:currentItem"] = "(Current)",
    ["ic:animDict"] = "Anim. Dictionary",
    ["ic:animClip"] = "Anim. Clip",
    ["ic:disableIdleStage"] = "Disable Idle",
    ["ic:enableIdleStage"] = "Enable Idle",
    ["ic:idleDisabled"] = "Idle Disabled",
    ["ic:animDuration"] = "Anim. Duration (0.0-%s)", -- %s = max
    ["ic:idleStage"] = "Idle Stage (0.0-%s)", -- %s = max
    ["ic:revertChanges"] = "Revert Changes",
    ["ic:invalid"] = "Invalid",
    ["ic:giveItem"] = "Give Item",
    ["ic:deleteItem"] = "Delete Item",
    ["ic:confirmDeleteItemTitle"] = "Confirm Item Deletion",
    ["ic:confirmDeleteItemDesc"] = "Deleting an item is a permanent action. We strongly advise you to create a backup by exporting the preset data first. Be sure of your choice.",
    ["ic:bone"] = "Bone",
    ["ic:rewardLabel"] = "Consumption Reward",
    ["ic:rewardMultiplier"] = "Reward Multiplier",
    ["ic:removeReward"] = "Remove",
    ["ic:availableRewards"] = "Available Rewards",
    ["ic:selectReward"] = "Select Reward...",
    ["ic:addRewardHint"] = "Add Rewards!",
    ["ic:unsavedChangesTooltip"] = "You Have Unsaved Changes",
    ["ic:itemType"] = "Item Type",
    ["ic:discardOnEmpty"] = "Discard On Empty",
    ["ic:noItemIdTooltip"] = "Finish Creating First",
    ["ic:itemImage"] = "Item Image",
    ["ic:itemImagePlaceholder"] = "Image URL",
    ["ic:job"] = "Job",
    ["ic:basicSectionTitle"] = "Basic",
    ["ic:animSectionTitle"] = "Animations & Props",
    ["ic:rewardsSectionTitle"] = "Consumption Rewards",
    ["ic:ingredientSearchLabel"] = "Search",
    ["ic:addIngredient"] = "Add Ingredient",
    ["ic:ingredientSearch"] = "Add More",
    ["ic:ingredientSearchEmpty"] = "Empty",
    ["ic:consumptionSearch"] = "Add More",
    ["ic:consumptionSearchEmpty"] = "Empty",
    ["ic:name"] = "Name",
    ["ic:total"] = "Total",
    ["ic:amount"] = "Amount",
    ["ic:configure"] = "Configure",
    ["ic:useConsumptionRewards"] = "Consumption Rewards",
    ["ic:useIngredients"] = "Ingredients",
    ["ic:noJob"] = "None",
    ["ic:configureAlignments"] = "Configure Alignments",

    -- Ingredient Menu
    ["ing:title"] = "Ingredient Configurator",
    ["ing:search"] = "Search",
    ["ing:searchPlaceholder"] = "Burger Patty...",
    ["ing:createIngredient"] = "Create Ingredient",
    ["ing:saveIngredient"] = "Save Ingredient",
    ["ing:revertChanges"] = "Revert Changes",
    ["ing:confirmIngredient"] = "Confirm Ingredient",
    ["ing:cancelIngredient"] = "Cancel Ingredient",
    ["ing:ingredientLabel"] = "Ingredient Label",
    ["ing:unusedIngredients"] = "Unused Ingredients",
    ["ing:unusedIngredientsPlaceholder"] = "Select an ingredient",
    ["ing:addPropIngredient"] = "Add More",
    ["ing:deletePropIngredient"] = "Delete",
    ["ing:makePrimaryIngredient"] = "Make Primary",
    ["ing:ingredientSearchPlaceholder"] = "Sugar",
    ["ing:dummyIngredientLabel"] = "Create More Ingredients!",
    ["ing:createIngredientButton"] = "Create Ingredient",
    ["ing:currentIngredient"] = "(Current)",
    ["ing:openCreate"] = "Create Ingredient",
    ["ing:editing"] = "Editing %s", -- %s = item label
    ["ing:creating"] = "Creating New Ingredient",
    ["ing:useAmount"] = "Amount",
    ["ing:basicSectionTitle"] = "Basic",
    ["ing:rewardsSectionTitle"] = "Consumption Rewards",
    ["ing:pressToEdit"] = "Press To Edit",
    ["ing:ingredientRewardMultiplier"] = "Multiplier",
    ["ing:removeIngredientReward"] = "Delete",
    ["ing:qualityThresholdLabel"] = "Quality Threshold",
    ["ing:qualityThresholdDesc"] = "Perform actions as long as quality is above the threshold.",
    ["ing:qualityThresholdStandardLabel"] = "Standard",
    ["ing:qualityThresholdReversedLabel"] = "Reversed",
    ["ing:qualityCalcLabel"] = "Quality Calculation",
    ["ing:qualityCalcBasic"] = "Basic",
    ["ing:qualityCalcChance"] = "Chance",
    ["ing:ingredientSelectLabel"] = "Selected Ingredient",
    ["ing:unsavedChangesTooltip"] = "You Have Unsaved Changes",
    ["ing:creatingIngredientTooltip"] = "Finish Creating First",
    ["ing:giveIngredient"] = "Give Ingredient",
    ["ing:confirmDeleteIngredientTitle"] = "Confirm Ingredient Deletion",
    ["ing:confirmDeleteIngredientDesc"] = "Deleting an ingredient is a permanent action. We strongly advise you to create a backup by exporting the preset data first. Be sure of your choice.",
    ["ing:quality"] = "Quality %s%", -- %s = quality
}