RegisterServerEvent('adi_phone:server:requestLocate')
AddEventHandler('adi_phone:server:requestLocate', function(cid, passcode)
    local src = source
    -- Fetch the owner's data from SQL
    MySQL.Async.fetchAll('SELECT * FROM phone_settings WHERE citizenid = @cid AND passcode = @pass', {
        ['@cid'] = cid,
        ['@pass'] = passcode
    }, function(result)
        if result[1] then
            -- Find who currently has the phone in their inventory
            -- (Checking all online players)
            for _, targetId in ipairs(GetPlayers()) do
                if HasPhoneWithID(targetId, cid) then
                    local coords = GetEntityCoords(GetPlayerPed(targetId))
                    TriggerClientEvent('adi_phone:client:locateResponse', src, coords, "online")
                    return
                end
            end
            TriggerClientEvent('adi_phone:client:locateResponse', src, nil, "offline")
        else
            TriggerClientEvent('adi_phone:notification', src, "ERROR", "Invalid ID or Passcode.")
        end
    end)
end)
