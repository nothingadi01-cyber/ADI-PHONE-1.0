RegisterNUICallback("summonVehicle", function(data, cb)
    local vehicle = GetVehicleByPlate(data.plate) -- Custom function to find entity
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if DoesEntityExist(vehicle) then
        -- Create an invisible NPC driver to bring the car to you
        local driver = CreatePedInsideVehicle(vehicle, 26, `s_m_m_security_01`, -1, true, false)
        SetEntityVisible(driver, false, false)
        TaskVehicleDriveToCoord(driver, vehicle, coords.x, coords.y, coords.z, 20.0, 0, GetEntityModel(vehicle), 786603, 1.0, true)
        
        TriggerEvent('adi_phone:notification', "CARLINK", "Autopilot Engaged. Your vehicle is en route.")
        
        -- Delete driver and stop car when close
        Citizen.CreateThread(function()
            while true do
                local dist = #(GetEntityCoords(vehicle) - GetEntityCoords(playerPed))
                if dist < 5.0 then
                    DeleteEntity(driver)
                    SetVehicleHandbrake(vehicle, true)
                    break
                end
                Wait(1000)
            end
        end)
    end
    cb('ok')
end)
