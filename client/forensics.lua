RegisterNUICallback("scanArea", function(data, cb)
    local pos = GetEntityCoords(PlayerPedId())
    -- Query the server database for recent messages sent at these coordinates
    TriggerServerEvent('adi_phone:server:getAreaLogs', pos)
    
    -- Animation: Character holds phone up like a scanner
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MOBILE_FILM_PHOTOGRAPH", 0, true)
    cb('ok')
end)
