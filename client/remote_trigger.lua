local connectedC4 = nil

RegisterNetEvent('adi_phone:client:linkExplosive')
AddEventHandler('adi_phone:client:linkExplosive', function(entity)
    connectedC4 = entity
    TriggerEvent('adi_phone:notification', "TRIGGER", "Device Linked: Ready for Remote Detonation.")
end)

RegisterNUICallback("detonateSovereign", function(data, cb)
    if connectedC4 ~= nil and DoesEntityExist(connectedC4) then
        local coords = GetEntityCoords(connectedC4)
        AddExplosion(coords.x, coords.y, coords.z, 2, 1.0, true, false, 1.0)
        connectedC4 = nil
        TriggerEvent('adi_phone:notification', "TRIGGER", "Signal Sent: Target Neutralized.")
    else
        TriggerEvent('adi_phone:notification', "ERROR", "No active signal found.")
    end
    cb('ok')
end)
