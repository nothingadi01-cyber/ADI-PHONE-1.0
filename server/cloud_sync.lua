Citizen.CreateThread(function()
    while true do
        Wait(600000) -- 10 Minutes
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
            if xPlayer then
                local phoneData = exports['adi_phone']:GetPlayerData(playerId)
                
                MySQL.Async.execute('INSERT INTO phone_backups (identifier, metadata) VALUES (@id, @data) ON DUPLICATE KEY UPDATE metadata = @data', {
                    ['@id'] = xPlayer.PlayerData.citizenid,
                    ['@data'] = json.encode(phoneData)
                })
                TriggerClientEvent('adi_phone:notification', playerId, "CLOUD", "Auto-sync complete.")
            end
        end
    end
end)
