-- Logic to handle hardware loss vs data preservation
RegisterServerEvent('adi_phone:server:restoreQuantumBackup')
AddEventHandler('adi_phone:server:restoreQuantumBackup', function()
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)

    -- Fetch the "Digital Soul" of the phone from the database
    MySQL.Async.fetchAll('SELECT * FROM phone_backups WHERE identifier = @id', {
        ['@id'] = identifier
    }, function(result)
        if result[1] then
            local phoneData = json.decode(result[1].metadata)
            
            -- Push data back to the active phone resource
            TriggerClientEvent('adi_phone:client:applyRestore', src, phoneData)
            TriggerClientEvent('adi_phone:notification', src, "QUANTUM", "Neural Link Restored. Welcome back.")
        else
            TriggerClientEvent('adi_phone:notification', src, "ERROR", "No backup found in the Cloud.")
        end
    end)
end)
