RegisterServerEvent('adi_phone:server:getAreaLogs')
AddEventHandler('adi_phone:server:getAreaLogs', function(coords)
    local src = source
    -- Search database for messages where distance from 'coords' < 5.0
    MySQL.Async.fetchAll('SELECT sender FROM phone_messages WHERE distance(@coords, sent_coords) < 5.0 LIMIT 3', {
        ['@coords'] = coords
    }, function(results)
        TriggerClientEvent('adi_phone:client:displayForensics', src, results)
    end)
end)
