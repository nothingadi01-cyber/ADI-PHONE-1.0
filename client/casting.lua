local isCasting = false
local currentTvObj = nil

RegisterNUICallback("startCasting", function(data, cb)
    local pos = GetEntityCoords(PlayerPedId())
    -- Find the nearest TV prop (Samsung/Sony TV props in GTA)
    local tv = GetClosestObjectOfType(pos, 5.0, `prop_tv_flat_01`, false, false, false)

    if DoesEntityExist(tv) then
        isCasting = true
        currentTvObj = tv
        
        -- Create a Runtime Texture to project the Phone Screen
        local txd = CreateRuntimeTxd("AdiCast")
        local duiObj = CreateDui("http://adi_phone/html/index.html", 1280, 720)
        local duiHandle = GetDuiHandle(duiObj)
        CreateRuntimeTextureFromDuiHandle(txd, "PhoneFeed", duiHandle)
        
        -- Replace the TV Screen texture with our Phone Feed
        AddReplaceTexture("prop_tv_flat_01", "tv_screen", "AdiCast", "PhoneFeed")
        
        TriggerServerEvent('adi_phone:server:syncTvForAll', ObjToNet(tv))
    end
end)
