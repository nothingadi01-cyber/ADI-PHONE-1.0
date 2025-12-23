local signalStrength = 5 -- 1 to 5 bars

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local zone = GetNameOfZone(coords.x, coords.y, coords.z)
        
        -- Logic: If underground or in a dead zone (like the mines or tunnels)
        if GetInteriorFromEntity(ped) ~= 0 then
            signalStrength = math.random(1, 2)
        elseif zone == "MTCHIL" or zone == "ALAMO" then -- Rural/Mountain
            signalStrength = 3
        else
            signalStrength = 5
        end

        SendNUIMessage({
            action = "updateSignal",
            strength = signalStrength
        })
        Wait(5000)
    end
end)
