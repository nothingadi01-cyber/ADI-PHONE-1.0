RegisterNUICallback("performDeepScan", function(data, cb)
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(playerPed, false)
    
    -- Search for specific 'bug' items attached to the player or car
    local foundBug = false
    local objects = GetGamePool('COBJECT')
    for _, obj in ipairs(objects) do
        if GetEntityModel(obj) == `prop_phone_ingame` and IsEntityAtEntity(obj, playerPed, 0.5, 0.5, 0.5, false, true, false) then
            foundBug = true
            break
        end
    end
    
    SendNUIMessage({ action = "scanResult", bugFound = foundBug })
    cb('ok')
end)
