local activeRaces = {}

RegisterServerEvent('adi_phone:server:joinRace')
AddEventHandler('adi_phone:server:joinRace', function(raceId)
    local src = source
    local race = activeRaces[raceId]
    
    if GetPlayerMoney(src) >= race.buyIn then
        RemoveMoney(src, race.buyIn)
        table.insert(race.participants, src)
        race.totalPot = race.totalPot + race.buyIn
        
        -- Sync the new Pot and Driver List to all racers
        TriggerClientEvent('adi_phone:client:updateRaceUI', -1, raceId, race.totalPot)
    end
end)

function FinishRace(winnerId, raceId)
    local prize = activeRaces[raceId].totalPot
    AddMoney(winnerId, prize)
    TriggerClientEvent('adi_phone:notification', -1, "NITRO", GetPlayerName(winnerId) .. " WON THE POT: $" .. prize)
end
