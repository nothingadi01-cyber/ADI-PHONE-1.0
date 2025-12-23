function DrawARPath(waypointCoords)
    Citizen.CreateThread(function()
        while navigationActive do
            local playerCoords = GetEntityCoords(PlayerPedId())
            -- Draws a specialized 'Laser' or 'Marker' path towards the target
            DrawPoly(playerCoords.x, playerCoords.y, playerCoords.z, waypointCoords.x, waypointCoords.y, waypointCoords.z, ...)
            Citizen.Wait(0)
        end
    end)
end
