Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        -- Check if near owned vehicle
        local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
        if DoesEntityExist(vehicle) then
            local plate = GetVehicleNumberPlateText(vehicle)
            if MyPhone.HasDigitalKey(plate) then
                -- Send HUD prompt to unlock via phone
                TriggerEvent('adi_hud:showPrompt', "Press [G] to Phone-Unlock")
            end
        end
    end
end)
