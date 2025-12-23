local isListening = false
local currentFrequency = 0.0

RegisterNUICallback("tuneFrequency", function(data, cb)
    local freq = data.frequency
    currentFrequency = freq
    
    -- If it's a public frequency (like music)
    if freq > 100 then
        exports['pma-voice']:setRadioChannel(0) -- Leave voice radio
        TriggerEvent('adi_phone:client:playRadioStream', freq)
    else
        -- Logic for voice radio channels
        exports['pma-voice']:setRadioChannel(freq)
        TriggerEvent('adi_phone:notification', "RADIO", "Tuned to: " .. freq .. " MHz")
    end
    cb('ok')
end)

-- The "Scanner" Logic (Eavesdropping)
RegisterNUICallback("attemptDecrypt", function(data, cb)
    -- Check if player has the "Decryption Key" item in their inventory
    QBCore.Functions.TriggerCallback('adi_phone:server:hasDecryptKey', function(hasKey)
        if hasKey then
            local targetFreq = (data.type == "police") and 1.0 or 2.0
            exports['pma-voice']:setRadioChannel(targetFreq)
            SendNUIMessage({ action = "unlockFrequency", type = data.type })
            TriggerEvent('adi_phone:notification', "HACK", "Frequency Decrypted. Monitoring Dispatch...")
        else
            TriggerEvent('adi_phone:notification', "ERROR", "Encryption too strong. Hardware Key required.")
        end
    end)
    cb('ok')
end)
