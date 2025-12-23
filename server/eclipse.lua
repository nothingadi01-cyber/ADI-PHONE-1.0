local eclipseActive = false

RegisterServerEvent('adi_phone:server:triggerEclipse')
AddEventHandler('adi_phone:server:triggerEclipse', function()
    local src = source
    if not eclipseActive then
        eclipseActive = true
        
        -- Announce to the world via a 'Emergency Alert' on all phones
        TriggerClientEvent('adi_phone:client:showEAS', -1, "SATELLITE INTERFERENCE DETECTED: MINIMAP & GPS OFFLINE.")

        -- Targeted effect: Only affects Police/Government
        TriggerClientEvent('adi_phone:client:disablePoliceTech', -1, true)

        -- 5 Minute Timer
        SetTimeout(300000, function()
            eclipseActive = false
            TriggerClientEvent('adi_phone:client:disablePoliceTech', -1, false)
            TriggerClientEvent('adi_phone:notification', -1, "SYSTEM", "SATELLITE LINK RESTORED.")
        end)
    end
end)
