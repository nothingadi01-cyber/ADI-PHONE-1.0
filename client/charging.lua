Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local ped = PlayerPedId()
        
        if IsPedInAnyVehicle(ped, false) then
            -- Charging in car
            sleep = 1000
            isCharging = true
            if batteryLevel < 100 then
                batteryLevel = batteryLevel + 1.0
            end
        else
            isCharging = false
        end
        Wait(sleep)
    end
end)

-- Power Bank Item Logic
RegisterNetEvent('adi_phone:client:usePowerBank')
AddEventHandler('adi_phone:client:usePowerBank', function()
    if batteryLevel < 90 then
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
        Progressbar("Charging", 5000) -- Use your framework's progress bar
        batteryLevel = batteryLevel + 25.0
        TriggerEvent('adi_phone:notification', "BATTERY", "Power Bank used. +25%")
    else
        TriggerEvent('adi_phone:notification', "BATTERY", "Battery already sufficient.")
    end
end)
