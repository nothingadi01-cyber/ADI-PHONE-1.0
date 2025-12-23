RegisterServerEvent('adi_phone:server:syncToQuantum')
AddEventHandler('adi_phone:server:syncToQuantum', function(recoveryKey)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    -- Saves all phone metadata to a secure 'Cloud' table
    MySQL.Async.execute('INSERT INTO adi_phone_quantum (identifier, recovery_key, data) VALUES (@id, @key, @data) ON DUPLICATE KEY UPDATE data = @data', {
        ['@id'] = identifier,
        ['@key'] = recoveryKey,
        ['@data'] = json.encode(PlayerPhoneData[src])
    })
    TriggerClientEvent('adi_phone:notification', src, "QUANTUM", "Neural Backup Complete.")
end)
