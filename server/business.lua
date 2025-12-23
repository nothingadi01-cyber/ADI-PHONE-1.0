RegisterNUICallback("getBusinessStock", function(data, cb)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    -- Query database for business owned by player
    MySQL.Async.fetchAll('SELECT stock_level, supply_level FROM player_businesses WHERE owner = @id', {
        ['@id'] = identifier
    }, function(result)
        if result[1] then
            cb({stock = result[1].stock_level, supplies = result[1].supply_level})
        end
    end)
end)
