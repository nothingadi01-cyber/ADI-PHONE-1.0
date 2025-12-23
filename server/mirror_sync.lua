RegisterServerEvent('adi_phone:server:startMirroring')
AddEventHandler('adi_phone:server:startMirroring', function(targetId)
    local src = source
    -- Sync the NUI state from Source to Target
    TriggerClientEvent('adi_phone:client:receiveMirrorStream', targetId, src)
end)

-- On the Client receiving the stream:
RegisterNetEvent('adi_phone:client:receiveMirrorStream')
AddEventHandler('adi_phone:client:receiveMirrorStream', function(streamerId)
    SendNUIMessage({
        action = "initiateMirrorUI",
        streamer = streamerId
    })
    -- All NUI messages sent to the streamer are now also sent to the listener
end)
