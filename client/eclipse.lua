RegisterNetEvent('adi_phone:client:disablePoliceTech')
AddEventHandler('adi_phone:client:disablePoliceTech', function(state)
    local job = GetPlayerJob() -- Check if user is Cop
    if job == "police" or job == "sheriff" then
        if state then
            -- The "Total Blindness" Effect
            DisplayRadar(false) -- Removes Minimap
            SetWaypointOff() -- Clears all GPS waypoints
            
            -- Add a 'Signal Jammed' static overlay to the Phone/HUD
            SendNUIMessage({ action = "showStaticOverlay", duration = 300000 })
        else
            DisplayRadar(true)
        end
    end
end)
