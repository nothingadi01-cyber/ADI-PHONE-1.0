RegisterServerEvent('adi_phone:server:syncMusic')
AddEventHandler('adi_phone:server:syncMusic', function(data)
    -- Broadcast the music to all players so they can start the stream locally
    -- only if they are within distance.
    TriggerClientEvent('adi_phone:client:playSpatialAudio', -1, data)
end)

RegisterServerEvent('adi_phone:server:updateMusicPosition')
AddEventHandler('adi_phone:server:updateMusicPosition', function(coords)
    local src = source
    TriggerClientEvent('adi_phone:client:updateSpatialCoords', -1, src, coords)
end)
