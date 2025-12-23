RegisterNUICallback("triggerSpecter", function(data, cb)
    local coords = GetEntityCoords(PlayerPedId())
    
    if data.type == "traffic_loop" then
        -- Logic to find traffic light entities and force them to 'Green'
        local trafficLights = GetGamePool('COBJECT')
        for _, obj in ipairs(trafficLights) do
            if GetEntityModel(obj) == `prop_traffic_01a` and #(coords - GetEntityCoords(obj)) < 50.0 then
                Entity(obj).state:set('forceGreen', true, true)
            end
        end
    end
    cb('ok')
end)
