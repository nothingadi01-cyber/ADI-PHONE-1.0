function HackTrafficLight()
    local playerCoords = GetEntityCoords(PlayerPedId())
    -- Find the nearest traffic light prop
    local light = GetClosestObjectOfType(playerCoords, 20.0, `prop_traffic_01a`, false, false, false)
    
    if DoesEntityExist(light) then
        -- Force the light state (requires specific server-side sync for all players)
        SetEntityTrafficlightOverride(light, 0) -- 0: Green, 1: Red, 2: Yellow
        Citizen.Wait(10000)
        SetEntityTrafficlightOverride(light, -1) -- Reset to normal
    end
end
