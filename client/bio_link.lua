local emergencyContact = "555-0199"

Citizen.CreateThread(function()
    while true do
        local health = GetEntityHealth(PlayerPedId())
        
        -- If player is downed/bleeding out
        if health < 105 and health > 0 then
            TriggerEvent('adi_phone:notification', "BIO-LINK", "CRITICAL VITALS: Initiating Emergency SOS...")
            
            -- Wait 10 seconds, then auto-call EMS
            Wait(10000)
            if GetEntityHealth(PlayerPedId()) < 105 then
                TriggerServerEvent('adi_phone:server:autoDial911', "Automated Bio-Link SOS: Patient unconscious at " .. GetStreetNameAtCoord(GetEntityCoords(PlayerPedId())))
            end
        end
        Wait(5000)
    end
end)
