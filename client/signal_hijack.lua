local hackableBillboards = { `prop_billboard_01`, `prop_billboard_02`, `prop_billboard_03` }

RegisterNUICallback("hijackBillboard", function(data, cb)
    local playerPos = GetEntityCoords(PlayerPedId())
    for _, model in pairs(hackableBillboards) do
        local billboard = GetClosestObjectOfType(playerPos, 50.0, model, false, false, false)
        if DoesEntityExist(billboard) then
            -- Use DUIs (Digital UI) to project the image onto the prop
            local txd = CreateRuntimeTxd("billboard_hack")
            local dui = CreateDui(data.url, 1024, 512)
            local handle = GetDuiHandle(dui)
            CreateRuntimeTextureFromDuiHandle(txd, "hacked_img", handle)
            
            -- Apply the texture to the physical object
            AddReplaceTexture("script_rt_billboard", "billboard_base", "billboard_hack", "hacked_img")
            
            TriggerEvent('adi_phone:notification', "NEXUS", "Signal Overwritten. City-wide broadcast active.")
            break
        end
    end
    cb('ok')
end)
