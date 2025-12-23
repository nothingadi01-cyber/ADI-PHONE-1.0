local isSummoning = false

function summonVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetVehiclePedIsIn(playerPed, false) -- Get your saved car entity
    
    if not isSummoning then
        isSummoning = true
        
        -- Unlock and Start Engine Remotely
        SetVehicleEngineOn(vehicle, true, true, false)
        SetVehicleDoorsLocked(vehicle, 1)

        -- Task the Vehicle to drive to Player Coords
        -- 786603 is the driving style (safe, obeys lights)
        TaskVehicleDriveToCoord(GetPedInVehicleSeat(vehicle, -1), vehicle, playerCoords.x, playerCoords.y, playerCoords.z, 20.0, 0, GetEntityModel(vehicle), 786603, 1.0, true)
        
        TriggerEvent('adi_phone:notification', "VALET", "Vehicle is en route to your location.")
        
        -- Monitor distance to stop
        Citizen.CreateThread(function()
            while isSummoning do
                local dist = #(GetEntityCoords(vehicle) - GetEntityCoords(PlayerPedId()))
                if dist < 5.0 then
                    ClearPedTasks(GetPedInVehicleSeat(vehicle, -1))
                    BringVehicleToHalt(vehicle, 2.0, 1, false)
                    isSummoning = false
                    TriggerEvent('adi_phone:notification', "VALET", "Vehicle has arrived.")
                end
                Wait(1000)
            end
        end)
    end
end
