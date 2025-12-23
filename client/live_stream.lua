local isStreaming = false
local streamCam = nil

RegisterNUICallback("toggleStream", function(data, cb)
    isStreaming = not isStreaming
    local ped = PlayerPedId()

    if isStreaming then
        -- Attach camera to phone prop bone
        streamCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        AttachCamToEntity(streamCam, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, true)
        SetCamRot(streamCam, 0.0, 0.0, GetEntityHeading(ped), 2)
        
        TriggerServerEvent('adi_phone:server:startStream', GetPlayerName(PlayerId()))
        TriggerEvent('adi_phone:notification', "LIVE", "You are now broadcasting to the city!")
    else
        DestroyCam(streamCam, false)
        RenderScriptCams(false, false, 0, 1, 0)
        TriggerServerEvent('adi_phone:server:stopStream')
    end
    cb('ok')
end)
