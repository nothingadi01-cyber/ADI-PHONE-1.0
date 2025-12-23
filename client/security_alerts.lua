local failedAttempts = 0
local maxAttempts = 10
local eraseDataEnabled = false

RegisterNUICallback("failedPinAttempt", function(data, cb)
    failedAttempts = failedAttempts + 1
    
    if eraseDataEnabled and failedAttempts >= maxAttempts then
        -- Trigger the Wipe
        TriggerServerEvent('adi_phone:server:factoryResetDevice')
        TriggerEvent('adi_phone:notification', "SECURITY", "Max attempts reached. Data wiped for your protection.")
    else
        local remaining = maxAttempts - failedAttempts
        TriggerEvent('adi_phone:notification', "SECURITY", "Wrong PIN. " .. remaining .. " attempts left.")
    end
    cb('ok')
end)

RegisterNUICallback("unlockByPasscode", function(data, cb)
    failedAttempts = 0 -- Reset counter on successful login
    cb('ok')
end)
