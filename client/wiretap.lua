local tappedTarget = nil

RegisterNetEvent('adi_phone:client:startListening')
AddEventHandler('adi_phone:client:startListening', function(targetPlayerServerId)
    tappedTarget = targetPlayerServerId
    
    -- Redirect the hacker's "Ear" to the victim's position
    -- This allows the hacker to hear what the victim hears in the call
    MumbleSetListenerFocus(GetPlayerPed(GetPlayerFromServerId(targetPlayerServerId)))
    
    TriggerEvent('adi_phone:notification', "NEXUS", "Audio Bridge Established. Listening...")
end)

-- Stop listening when they hang up
RegisterNetEvent('adi_phone:client:stopListening')
AddEventHandler('adi_phone:client:stopListening', function()
    MumbleSetListenerFocus(PlayerPedId()) -- Reset audio to self
    tappedTarget = nil
end)
