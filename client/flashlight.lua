local flashlightActive = false

RegisterNUICallback("toggleFlashlight", function(data, cb)
    flashlightActive = not flashlightActive
    local ped = PlayerPedId()

    Citizen.CreateThread(function()
        while flashlightActive do
            local coords = GetEntityCoords(ped)
            local forward = GetEntityForwardVector(ped)
            -- Create a spotlight at the phone's position
            DrawSpotLight(coords.x, coords.y, coords.z, forward.x, forward.y, forward.z, 255, 255, 255, 20.0, 1.0, 1.0, 10.0, 1.0)
            Wait(0)
        end
    end)
    cb('ok')
end)
