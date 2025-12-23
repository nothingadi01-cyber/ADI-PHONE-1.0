RegisterNUICallback("vehicleAction", function(data, cb)
    local action = data.action
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    -- Find closest vehicle owned by player
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 30.0, 0, 71)

    if DoesEntityExist(vehicle) then
        -- Play Key Fob Animation
        TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 8.0, -1, 48, 1, false, false, false)
        
        if action == "lock" then
            local lockStatus = GetVehicleDoorLockStatus(vehicle)
            if lockStatus <= 1 then
                SetVehicleDoorsLocked(vehicle, 2)
                PlayVehicleDoorCloseSound(vehicle, 1)
                TriggerEvent('adi_phone:notification', "VEHICLE", "Doors Locked.")
            else
                SetVehicleDoorsLocked(vehicle, 1)
                PlayVehicleDoorOpenSound(vehicle, 0)
                TriggerEvent('adi_phone:notification', "VEHICLE", "Doors Unlocked.")
            end
        elseif action == "engine" then
            local status = GetIsVehicleEngineRunning(vehicle)
            SetVehicleEngineOn(vehicle, not status, true, true)
            TriggerEvent('adi_phone:notification', "VEHICLE", "Engine Toggle Sent.")
        elseif action == "trunk" then
            if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                SetVehicleDoorShut(vehicle, 5, false)
            else
                SetVehicleDoorOpen(vehicle, 5, false, false)
            end
        end
    else
        TriggerEvent('adi_phone:notification', "ERROR", "No vehicle signal found.")
    end
    cb('ok')
end)
