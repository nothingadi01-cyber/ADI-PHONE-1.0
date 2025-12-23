Citizen.CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            local fuel = GetVehicleFuelLevel(vehicle)
            local health = GetVehicleEngineHealth(vehicle) / 10
            
            SendNUIMessage({
                action = "updateVehStatus",
                fuel = math.ceil(fuel),
                health = math.ceil(health),
                plate = GetVehicleNumberPlateText(vehicle),
                name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            })
        end
        Wait(5000) -- Update every 5 seconds
    end
end)
