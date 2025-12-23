local autoInjectActive = true

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped) - 100

        -- If health is below 20% and we have a medkit
        if autoInjectActive and health < 20 and not IsEntityDead(ped) then
            if exports['ox_inventory']:Search('count', 'medkit') > 0 then
                
                -- Trigger Animation
                TaskPlayAnim(ped, "amb@code_human_onclick_phone@base", "base", 8.0, -8.0, 2000, 49, 0, false, false, false)
                
                -- Effect: Instant Health Boost & Screen Flash
                TriggerServerEvent('adi_phone:server:consumeMedkit')
                StartScreenEffect("HeistCelebrationVariable", 0, true)
                
                SendNUIMessage({ 
                    action = "nanoAlert", 
                    msg = "BIOMETRIC CRITICAL: AUTO-INJECTING..." 
                })
                
                Wait(30000) -- Cooldown
                StopScreenEffect("HeistCelebrationVariable")
            end
        end
    end
end)
