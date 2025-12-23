local activeLobbies = {}

RegisterServerEvent('adi_phone:server:createLobby')
AddEventHandler('adi_phone:server:createLobby', function(jobType)
    local src = source
    local lobbyId = math.random(1000, 9999)
    
    activeLobbies[lobbyId] = {
        type = jobType,
        leader = src,
        players = {src},
        status = "waiting"
    }
    
    -- Assign a unique Routing Bucket (Virtual World)
    SetPlayerRoutingBucket(src, lobbyId)
    TriggerClientEvent('adi_phone:client:updateLobby', src, lobbyId)
end)

function StartInstance(lobbyId)
    for _, playerId in ipairs(activeLobbies[lobbyId].players) do
        SetPlayerRoutingBucket(playerId, lobbyId)
        -- Trigger the heist script for this specific crew
        TriggerClientEvent('heist:start', playerId, activeLobbies[lobbyId].type)
    end
end
