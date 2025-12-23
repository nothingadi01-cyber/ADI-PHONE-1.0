RegisterNUICallback("nfcPayment", function(data, cb)
    local playerPed = PlayerPedId()
    local target, distance = GetClosestPlayer() -- Function to find nearest person

    if distance < 2.0 then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MOBILE_FILM_PHOTOGRAPH", 0, true)
        TriggerServerEvent('adi_phone:server:transferNFC', GetPlayerServerId(target), data.amount)
        
        -- Play "Pay" Sound Effect
        PlaySoundFrontend(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 1)
        TriggerEvent('adi_phone:notification', "ADI-PAY", "Transaction Complete: $" .. data.amount)
    else
        TriggerEvent('adi_phone:notification', "ADI-PAY", "No receiver in range.")
    end
    cb('ok')
end)
