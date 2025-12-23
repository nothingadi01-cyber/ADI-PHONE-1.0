RegisterNUICallback("publishArticle", function(data, cb)
    -- Check if player has 'journalist' or 'admin' job
    local job = GetPlayerJob() 
    if job == "journalist" or job == "admin" then
        TriggerServerEvent('adi_phone:server:postNews', data.title, data.content, data.image)
        cb('ok')
    else
        TriggerClientEvent('adi_phone:notification', source, "SYSTEM", "Unauthorized Access.")
    end
end)
