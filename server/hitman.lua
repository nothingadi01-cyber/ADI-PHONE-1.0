local activeHits = {}

RegisterServerEvent('adi_phone:server:placeBounty')
AddEventHandler('adi_phone:server:placeBounty', function(targetId, reward)
    local src = source
    if GetPlayerMoney(src) >= reward then
        RemoveMoney(src, reward)
        activeHits[targetId] = {
            reward = reward,
            creator = src
        }
        TriggerClientEvent('adi_phone:notification', -1, "DARKNET", "A new contract has been posted.")
    end
end)

-- Detect when the target is killed
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
    if activeHits[source] then
        local reward = activeHits[source].reward
        AddMoney(killedBy, reward)
        
        TriggerClientEvent('adi_phone:client:contractComplete', killedBy)
        TriggerClientEvent('adi_phone:notification', killedBy, "SHADOW", "Contract verified. $" .. reward .. " transferred.")
        activeHits[source] = nil
    end
end)
