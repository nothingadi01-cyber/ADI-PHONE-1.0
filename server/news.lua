RegisterServerEvent('adi_phone:server:postNews')
AddEventHandler('adi_phone:server:postNews', function(headline, content)
    local src = source
    local playerName = GetPlayerName(src)
    
    -- In a real scenario, check if player has 'reporter' job
    local newsData = {
        title = headline,
        body = content,
        author = playerName,
        time = os.date("%H:%M")
    }

    -- Trigger notification for EVERYONE
    TriggerClientEvent('adi_phone:client:receiveNews', -1, newsData)
    
    -- Save to database so new players can see it
    MySQL.Async.execute('INSERT INTO phone_news (title, content, author) VALUES (@title, @content, @author)', {
        ['@title'] = headline,
        ['@content'] = content,
        ['@author'] = playerName
    })
end)
