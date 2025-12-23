RegisterNUICallback("send911", function(data, cb)
    local plyPos = GetEntityCoords(PlayerPedId())
    local streetName = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)
    
    TriggerServerEvent('adi_phone:server:emergencyCall', {
        type = data.service, -- "Police" or "EMS"
        message = data.message,
        coords = plyPos,
        street = GetStreetNameFromHashKey(streetName)
    })
    
    TriggerEvent('adi_phone:notification', "911", "Call sent. Emergency services notified.")
    cb('ok')
end)
