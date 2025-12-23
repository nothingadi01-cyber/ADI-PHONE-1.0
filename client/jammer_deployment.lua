local activeJammer = nil

RegisterNUICallback("deployJammer", function(data, cb)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local spawnPos = coords + (forward * 1.0)

    -- Create physical jammer object
    activeJammer = CreateObject(`prop_v_res_phone_01`, spawnPos.x, spawnPos.y, spawnPos.z - 1.0, true, true, true)
    PlaceObjectOnGroundProperly(activeJammer)
    
    TriggerServerEvent('adi_phone:server:registerJammer', spawnPos)
    TriggerEvent('adi_phone:notification', "SIGNAL", "Electronic Jammer Deployed. Radius: 20m")
    cb('ok')
end)

-- Jammer detection logic
Citizen.CreateThread(function()
    while true do
        local isNearJammer = GlobalState.JammerActive -- Server-side sync
        if isNearJammer then
            SendNUIMessage({ action = "setSignal", strength = 0, status = "JAMMED" })
            SetPlayerCanDoDriveBy(PlayerId(), false) -- Simulate electronics failing
        end
        Wait(3000)
    end
end)
