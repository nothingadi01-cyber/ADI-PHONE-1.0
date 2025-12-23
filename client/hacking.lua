RegisterNUICallback("hackTrafficLight", function(data, cb)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local trafficLight = GetClosestObjectOfType(coords.x, coords.y, coords.z, 20.0, `prop_traffic_01a`, false, false, false)

    if DoesEntityExist(trafficLight) then
        SendNUIMessage({ action = "adi_voice", msg = "TRAFFIC SYSTEM BREACHED. SIGNAL SET TO GREEN." })
        Entity(trafficLight).state:set('lightState', 'green', true)
        -- Reset after 10 seconds
        SetTimeout(10000, function()
            Entity(trafficLight).state:set('lightState', 'normal', true)
        end)
    end
    cb('ok')
end)
