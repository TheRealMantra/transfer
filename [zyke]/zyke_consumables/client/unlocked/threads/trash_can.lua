-- Handles the trashcan logic, to dispose of empty items

-- Only supports targetsystems for now
-- if (not Target) then return end

local models = {
    ["v_ind_cfbin"] = true,
    ["prop_bin_13a"] = true,
    ["prop_bin_14a"] = true,
    ["mp_b_kit_bin_01"] = true,
    ["v_corp_bombbin"] = true,
    ["zprop_bin_01a_old"] = true,
    ["xm3_prop_xm3_med_wastebin_01a"] = true,
    ["prop_bin_11b"] = true,
    ["v_ret_csr_bin"] = true,
    ["prop_bin_05a"] = true,
    ["prop_snow_bin_01"] = true,
    ["v_ind_bin_01"] = true,
    ["prop_recyclebin_04_a"] = true,
    ["prop_bin_07c"] = true,
    ["prop_bin_07b"] = true,
    ["prop_cs_bin_01"] = true,
    ["prop_bin_delpiero"] = true,
    ["ch_chint02_bin"] = true,
    ["prop_bin_07d"] = true,
    ["prop_recyclebin_02_d"] = true,
    ["prop_bin_11a"] = true,
    ["v_ret_gc_bin"] = true,
    ["prop_food_bin_02"] = true,
    ["prop_bin_04a"] = true,
    ["v_serv_tc_bin2_"] = true,
    ["prop_gas_smallbin01"] = true,
    ["prop_bin_02a"] = true,
    ["prop_bin_09a"] = true,
    ["prop_cs_bin_03"] = true,
    ["hei_heist_kit_bin_01"] = true,
    ["prop_cs_bin_01_skinned"] = true,
    ["prop_bin_01a"] = true,
    ["ch_prop_casino_bin_01a"] = true,
    ["prop_cs_bin_02"] = true,
    ["v_med_bin"] = true,
    ["v_serv_tc_bin3_"] = true,
    ["v_res_mbbin"] = true,
    ["prop_snow_bin_02"] = true,
    ["prop_bin_10a"] = true,
    ["prop_bin_beach_01a"] = true,
    ["prop_recyclebin_02_c"] = true,
    ["v_serv_metro_floorbin"] = true,
    ["prop_bin_beach_01d"] = true,
    ["bkr_ware03_bin"] = true,
    ["prop_recyclebin_01a"] = true,
    ["v_serv_tc_bin1_"] = true,
    ["sc1_07_clinical_bin"] = true,
    ["prop_bin_12a"] = true,
    ["v_serv_waste_bin1"] = true,
    ["prop_food_bin_01"] = true,
    ["v_med_cor_cembin"] = true,
    ["prop_bin_10b"] = true,
    ["v_serv_metro_wallbin"] = true,
    ["prop_fbibombbin"] = true,
    ["prop_recyclebin_04_b"] = true,
    ["prop_bin_08a"] = true,
    ["prop_bin_03a"] = true,
    ["prop_bin_06a"] = true,
    ["prop_bin_delpiero_b"] = true,
    ["bkr_ware03_bin2"] = true,
    ["xm3_prop_xm3_med_bin_01a"] = true,
    ["prop_bin_07a"] = true,
    ["prop_bin_08open"] = true,
    ["v_res_tre_bin"] = true,
    ["vw_prop_vw_casino_bin_01a"] = true,
    ["m23_2_int5_m232_bin"] = true,
    ["prop_recyclebin_02b"] = true,
    ["prop_recyclebin_02a"] = true,
    ["prop_bin_14b"] = true,
}

local hashModels = {}
for model, value in pairs(models) do
    hashModels[joaat(model)] = value
end
models = hashModels

local function getNearby()
    local objects = GetGamePool("CObject")
    local nearby = {}

    local plyPos = GetEntityCoords(PlayerPedId())

    for i = 1, #objects do
        local model = GetEntityModel(objects[i])

        if (models[model] and #(plyPos - GetEntityCoords(objects[i])) < 100.0) then
            local min, max = GetModelDimensions(model)

            nearby[#nearby+1] = {
                entity = objects[i],
                raise = (max.x - min.x) + 0.25
            }
        end
    end

    return nearby
end

-- if (not Target) then
    CreateThread(function()
        local nearby = {}
        local lastFetchedNearby = 0

        while (1) do
            if (GetGameTimer() - lastFetchedNearby > 3000) then
                nearby = getNearby()
                lastFetchedNearby = GetGameTimer()
            end

            local ply = PlayerPedId()
            local plyPos = GetEntityCoords(ply)

            for i = 1, #nearby do
                if (DoesEntityExist(nearby[i].entity) == 1) then
                    local pos = GetEntityCoords(nearby[i].entity)
                    local dst = #(plyPos - pos)

                    if (dst < 1.5) then
                        Z.draw3dText(pos + vector3(0, 0, nearby[i].raise), "[E] Discard", 0.35)

                        if (IsControlJustPressed(0, 38)) then
                            TriggerServerEvent("zyke_consumables:Discard")
                        end
                    end
                end
            end

            Wait(1)
        end
    end)
-- end