RegisterServerEvent('adi_phone:server:securityBreach')
AddEventHandler('adi_phone:server:securityBreach', function(netId)
    local src = source
    -- If a player (who isn't the owner) enters the driver seat
    TriggerClientEvent('adi_phone:notification', src, "SECURITY", "Unrecognized Driver Detected! remote shutdown available.")
    
    -- Feature: "Remote Lock-In"
    -- Lock the thief inside the car until police arrive
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    SetVehicleDoorsLocked(vehicle, 4) -- Locked strictly
end)
