local voteDatabase = {}

RegisterServerEvent('adi_phone:server:castVote')
AddEventHandler('adi_phone:server:castVote', function(proposalId, choice)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)

    -- Check if player already voted
    if not HasVoted(identifier, proposalId) then
        MySQL.Async.execute('INSERT INTO phone_votes (identifier, prop_id, choice) VALUES (@id, @pid, @c)', {
            ['@id'] = identifier,
            ['@pid'] = proposalId,
            ['@c'] = choice
        })
        TriggerClientEvent('adi_phone:notification', src, "CIVIC", "Your vote has been recorded anonymously.")
    else
        TriggerClientEvent('adi_phone:notification', src, "SYSTEM", "You have already voted on this proposal.")
    end
end)
