RegisterNetEvent('adi_phone:client:locateResponse')
AddEventHandler('adi_phone:client:locateResponse', function(coords, deviceStatus)
    if deviceStatus == "online" then
        -- Create a temporary blip on the map for 30 seconds
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 459) -- Phone Icon
        SetBlipColour(blip, 2) -- Green
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Lost Device")
        EndTextCommandSetBlipName(blip)
        
        TriggerEvent('adi_phone:notification', "ADI-CLOUD", "Device coordinates updated on GPS.")
        
        Citizen.Wait(30000)
        RemoveBlip(blip)
    else
        TriggerEvent('adi_phone:notification', "ERROR", "Device is offline or destroyed.")
    end
end)

-- The "Play Sound" feature (Force phone to ring even if on silent)
RegisterNetEvent('adi_phone:client:forcePing')
AddEventHandler('adi_phone:client:forcePing', function()
    local count = 0
    while count < 5 do
        PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEIST_HACK_SOUNDS", 1)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'phone_ping', 0.5)
        count = count + 1
        Wait(1000)
    end
end)
