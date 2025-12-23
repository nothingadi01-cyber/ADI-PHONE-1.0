local isBurner = false
local burnerTime = 0

RegisterNetEvent('adi_phone:client:useBurner')
AddEventHandler('adi_phone:client:useBurner', function(number)
    isBurner = true
    burnerTime = 60 -- Minutes until the SIM card self-destructs
    
    -- Change the UI look to a "Cheap" retro style
    SendNUIMessage({
        action = "setOSMode",
        mode = "burner",
        tempNumber = number
    })
    
    TriggerEvent('adi_phone:notification', "BURNER", "Temporary link established. 60m remaining.")
end)

-- Auto-wipe thread
Citizen.CreateThread(function()
    while isBurner do
        Wait(60000) -- Check every minute
        burnerTime = burnerTime - 1
        if burnerTime <= 0 then
            isBurner = false
            TriggerServerEvent('adi_phone:server:expireBurner')
            TriggerEvent('adi_phone:notification', "BURNER", "SIM EXPIRED. Data purged.")
        end
    end
end)
