RegisterServerEvent('adi_phone:server:sendMove')
AddEventHandler('adi_phone:server:sendMove', function(targetId, moveData)
    local src = source
    -- Sync the move to the opponent
    TriggerClientEvent('adi_phone:client:receiveMove', targetId, moveData)
    
    -- Optional: If a wager was set, the server tracks the winner
    print("Move synced between " .. src .. " and " .. targetId)
end)
