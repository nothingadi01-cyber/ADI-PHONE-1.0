local currentTourCam = nil

RegisterNUICallback("switchRoom", function(data, cb)
    local roomCoords = Config.Properties[data.propertyId].rooms[data.roomName]
    
    if currentTourCam then DestroyCam(currentTourCam) end
    
    -- Create a high-quality cinematic camera in the interior
    currentTourCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", roomCoords.x, roomCoords.y, roomCoords.z, 0.0, 0.0, roomCoords.h, 60.0, false, 0)
    SetCamActive(currentTourCam, true)
    
    -- This renders the camera view into a texture that the NUI can read
    RenderScriptCams(true, false, 0, true, true)
    cb('ok')
end)
