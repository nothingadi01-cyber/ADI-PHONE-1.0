RegisterNetEvent('adi_phone:client:triggerEAS')
AddEventHandler('adi_phone:client:triggerEAS', function(message)
    -- Force phone to open on the Emergency Screen
    ExecuteCommand("openphone")
    SendNUIMessage({
        action = "emergencyAlert",
        msg = message
    })

    -- Intense vibration and sound
    Citizen.CreateThread(function()
        local count = 0
        while count < 10 do
            ShakeGameplayCam("VIBRATE_SHAKE", 1.0)
            PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)
            count = count + 1
            Wait(500)
        end
    end)
end)
