local droneActive = false
local droneEntity = nil

RegisterNUICallback("launchDrone", function(data, cb)
    local ped = PlayerPedId()
    local spawnCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.5)
    
    -- Load Drone Model
    local model = `rcbandito` -- Or a custom drone prop
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end
    
    droneEntity = CreateVehicle(model, spawnCoords.x, spawnCoords.y, spawnCoords.z, GetEntityHeading(ped), true, false)
    droneActive = true
    
    -- Attach Camera to Drone and switch view
    local droneCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(droneCam, droneEntity, 0.0, 0.0, 0.0, true)
    RenderScriptCams(true, true, 500, true, true)
    
    cb('ok')
end)

-- Handle Virtual Joystick Input from NUI
RegisterNUICallback("moveDrone", function(data, cb)
    if droneActive then
        -- Apply force to drone based on data.x and data.y (joystick coords)
        ApplyForceToEntity(droneEntity, 1, data.x, data.y, 0.0, 0.0, 0.0, 0.0, false, true, true, true, false, true)
    end
end)
