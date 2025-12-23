local burnerTime = 3600 -- 1 Hour in seconds

Citizen.CreateThread(function()
    while isUsingBurner do
        Citizen.Wait(1000)
        burnerTime = burnerTime - 1
        
        -- Update the UI timer
        SendNUIMessage({ action = "updateBurnerTimer", time = burnerTime })

        if burnerTime <= 0 then
            -- The "Short-Circuit" Effect
            TriggerServerEvent('adi_phone:server:destroyBurner')
            
            -- Visual/Sound effects
            PlaySoundFrontend(-1, "Air_Confirm", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
            
            isUsingBurner = false
            SendNUIMessage({ action = "forceClose" })
            break
        end
    end
end)
