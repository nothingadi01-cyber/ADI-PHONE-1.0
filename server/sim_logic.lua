RegisterServerEvent('adi_phone:server:swapSIM')
AddEventHandler('adi_phone:server:swapSIM', function(simID)
    local src = source
    local newNumber = math.random(111111, 999999) -- Generate random new number
    
    -- Update database with the new number for this player
    MySQL.Async.execute('UPDATE adi_phone_data SET phone_number = @num WHERE identifier = @id', {
        ['@num'] = newNumber,
        ['@id'] = GetPlayerIdentifier(src, 0)
    }, function(changed)
        TriggerClientEvent('adi_phone:notification', src, "SIM", "New Number Activated: " .. newNumber)
        -- Sync contacts to the new number
        TriggerClientEvent('adi_phone:client:syncData', src)
    end)
end)
