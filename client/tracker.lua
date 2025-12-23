local targetLocation = vector3(100.0, 200.0, 30.0) -- Example hidden drop

Citizen.CreateThread(function()
    while trackingActive do
        Citizen.Wait(500)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - targetLocation)
        
        -- Send signal strength to the Phone UI
        -- Closer = Stronger Beep and Faster Pulse
        SendNUIMessage({
            action = "updateSignal",
            strength = math.max(0, 100 - (distance / 5)) 
        })
    end
end)
