-- Global settings table
local currentSettings = {
    airplaneMode = false,
    hudOpacity = 1.0,
    isEncrypted = false
}

-- Toggle Airplane Mode
RegisterNUICallback("toggleAirplane", function(data, cb)
    currentSettings.airplaneMode = data.status
    
    if currentSettings.airplaneMode then
        -- Cut off GPS and Network
        TriggerEvent('adi_phone:client:setSignal', 0)
        TriggerEvent('adi_phone:notification', "SYSTEM", "Airplane Mode: ON")
    else
        -- Restore Signal
        TriggerEvent('adi_phone:client:setSignal', 5)
    end
    cb('ok')
end)

-- Sync Settings to Database
function savePhoneSettings()
    TriggerServerEvent('adi_phone:server:savePlayerSettings', currentSettings)
end
