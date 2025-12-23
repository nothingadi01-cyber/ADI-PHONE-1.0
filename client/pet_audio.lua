local isListening = false

RegisterNUICallback("remoteAudio", function(data, cb)
    local petNetId = data.netId
    local petEntity = NetToPed(petNetId)

    if DoesEntityExist(petEntity) then
        isListening = not isListening
        if isListening then
            -- This attaches your 'Audio Listener' to the pet instead of your player
            MumbleSetListenerFocus(petEntity) 
            TriggerEvent('adi_phone:notification', "PET", "Audio Link Established.")
        else
            MumbleSetListenerFocus(PlayerPedId())
            TriggerEvent('adi_phone:notification', "PET", "Audio Link Cut.")
        end
    end
    cb('ok')
end)
