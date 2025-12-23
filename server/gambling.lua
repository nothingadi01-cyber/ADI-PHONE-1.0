local activeBets = {}

RegisterServerEvent('adi_phone:server:createBet')
AddEventHandler('adi_phone:server:createBet', function(targetId, amount, gameType)
    local src = source
    -- Check if both players have the cash
    if GetPlayerMoney(src) >= amount and GetPlayerMoney(targetId) >= amount then
        activeBets[src] = { opponent = targetId, wager = amount, type = gameType }
        TriggerClientEvent('adi_phone:client:receiveInvite', targetId, src, amount, gameType)
    end
end)

RegisterServerEvent('adi_phone:server:finishBet')
AddEventHandler('adi_phone:server:finishBet', function(winnerId, loserId, totalPot)
    -- Transfer the 'Dirty' or 'Clean' cash
    RemoveMoney(loserId, totalPot/2)
    AddMoney(winnerId, totalPot)
    
    TriggerClientEvent('adi_phone:notification', winnerId, "BET", "YOU WON $" .. totalPot)
    TriggerClientEvent('adi_phone:notification', loserId, "BET", "YOU LOST $" .. totalPot/2)
end)
