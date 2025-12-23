local isPhoneOpen = false

-- Open Phone with 'M' key or Command
RegisterCommand("phone", function()
    TogglePhone()
end)

function TogglePhone()
    isPhoneOpen = not isPhoneOpen
    SetNuiFocus(isPhoneOpen, isPhoneOpen)
    
    if isPhoneOpen then
        SendNUIMessage({ action = "openPhone" })
        -- Animation: Pulling out phone
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
    else
        SendNUIMessage({ action = "closePhone" })
        StopAnimTask(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", "idle", 1.0)
    end
end

-- Crypto App Logic
RegisterNUICallback("getCryptoPrice", function(data, cb)
    local btcPrice = math.random(40000, 60000)
    cb({ price = btcPrice })
end)
