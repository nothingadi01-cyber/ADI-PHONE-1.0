RegisterNUICallback("hackTrafficLight", function(data, cb)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local trafficLight = GetClosestObjectOfType(coords.x, coords.y, coords.z, 20.0, `prop_traffic_01a`, false, false, false)

    if DoesEntityExist(trafficLight) then
        SendNUIMessage({ action = "adi_voice", msg = "TRAFFIC SYSTEM BREACHED. SIGNAL SET TO GREEN." })
        Entity(trafficLight).state:set('lightState', 'green', true)
        -- Reset after 10 seconds
        SetTimeout(10000, function()
            Entity(trafficLight).state:set('lightState', 'normal', true)
        end)
    end
    cb('ok')
end)

RegisterNUICallback("attemptVehicleHack", function(data, cb)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)

    if DoesEntityExist(vehicle) then
        -- Character Animation: Leaning over the dashboard/door
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
        
        -- Trigger the NUI Hacking Mini-game
        SendNUIMessage({ action = "startHackGame", difficulty = "hard" })
    else
        SendNUIMessage({ action = "adi_voice", msg = "NO VEHICLE SIGNAL DETECTED." })
    end
    cb('ok')
end)

-- On Successful Hack
RegisterNetEvent('adi_phone:hackSuccess')
AddEventHandler('adi_phone:hackSuccess', function(netId)
    local vehicle = NetToVeh(netId)
    SetVehicleDoorsLocked(vehicle, 1) -- Unlock
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true, false)
    
    -- Visual Feedback: Lights Flash
    SetVehicleLights(vehicle, 2)
    Wait(500)
    SetVehicleLights(vehicle, 0)
    
    SendNUIMessage({ action = "adi_voice", msg = "IGNITION BYPASSED. WELCOME, OPERATOR." })
end)
