RegisterServerEvent('adi_phone:server:extractData')
AddEventHandler('adi_phone:server:extractData', function(targetIdentifier)
    local src = source
    
    -- Fetch 'Deleted' messages from SQL that haven't been purged from the Cloud yet
    MySQL.Async.fetchAll('SELECT * FROM phone_messages WHERE (sender = @id OR receiver = @id) ORDER BY timestamp DESC LIMIT 5', {
        ['@id'] = targetIdentifier
    }, function(results)
        if results then
            TriggerClientEvent('adi_phone:client:viewExtractedData', src, results)
        else
            TriggerClientEvent('adi_phone:notification', src, "ERROR", "Encryption too strong. Extraction failed.")
        end
    end)
end)
