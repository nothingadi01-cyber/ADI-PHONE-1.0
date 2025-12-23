RegisterServerEvent('adi_phone:server:startGlobalBroadcast')
AddEventHandler('adi_phone:server:startGlobalBroadcast', function(ticker)
    local src = source
    local name = GetPlayerName(src)
    
    -- Send "Breaking News" to every player
    TriggerClientEvent('adi_phone:notification', -1, "BREAKING NEWS", "Reporter " .. name .. " is LIVE! Tune in to Channel 7.")
    
    -- Sync the ticker text globally
    TriggerClientEvent('adi_phone:client:updateTicker', -1, ticker)
end)
