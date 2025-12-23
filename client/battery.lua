local currentBattery = 100.0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Check every 1 minute
        if isPhoneOpen then
            currentBattery = currentBattery - 1.5 -- Drain faster while using
        else
            currentBattery = currentBattery - 0.2 -- Passive drain
        end

        if currentBattery <= 0 then
            currentBattery = 0
            TriggerEvent('adi_phone:forceClose', "Battery Dead")
            -- Play a 'power down' sound
            PlaySoundFrontend(-1, "Phone_Generic_Key_01", "HUD_MINIGAME_SOUNDSET", 1)
        end
        
        -- Update the UI
        SendNUIMessage({ action = "updateBattery", level = currentBattery })
    end
end)

-- Power Bank usage
RegisterNetEvent('adi_phone:usePowerBank')
AddEventHandler('adi_phone:usePowerBank', function()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
    TriggerEvent('adi_hud:progressBar', "Charging Device...", 10000)
    Citizen.Wait(10000)
    currentBattery = math.min(currentBattery + 50.0, 100.0)
    ClearPedTasks(PlayerPedId())
end)
