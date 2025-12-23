local activeStreams = {}

-- Notification for Police
RegisterNetEvent('adi_phone:police:receiveAlert')
AddEventHandler('adi_phone:police:receiveAlert', function(witnessId, coords, reason)
    local ped = PlayerPedId()
    -- Only show for officers (check your framework job here)
    if PlayerJob == 'police' then 
        SendNUIMessage({
            action = "dispatchAlert",
            msg = "LIVE WITNESS FEED AVAILABLE",
            loc = coords,
            id = witnessId
        })
        
        -- Add a pulsing red blip on the map
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 161)
        SetBlipColour(blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("CRIME IN PROGRESS")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Function to 'Watch' the stream
RegisterNUICallback("watchWitness", function(data, cb)
    local targetId = data.targetId
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    
    -- Create a camera that follows the Witness
    local dispatchCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(dispatchCam, targetPed, 0.0, 0.0, 0.8, true)
    SetCamFov(dispatchCam, 80.0)
    
    -- Add a 'Bodycam' overlay
    SetTimecycleModifier("scanline_cam_chevron")
    RenderScriptCams(true, false, 0, true, true)
    
    cb('ok')
end)
