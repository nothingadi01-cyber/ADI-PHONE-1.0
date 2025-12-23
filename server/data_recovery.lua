RegisterServerEvent('adi_phone:server:forensicsRecover')
AddEventHandler('adi_phone:server:forensicsRecover', function(targetIdentifier)
    local src = source
    -- Fetch deleted messages from the database
    MySQL.Async.fetchAll('SELECT * FROM phone_messages WHERE (sender = @id OR receiver = @id) AND is_deleted = 1 LIMIT 10', {
        ['@id'] = targetIdentifier
    }, function(deletedData)
        if deletedData then
            TriggerClientEvent('adi_phone:client:showForensics', src, deletedData)
        end
    end)
end)
