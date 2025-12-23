local isBroadcasting = false
local currentFrequency = 105.5

function startPodcast()
    isBroadcasting = true
    -- Connect to a hidden VOIP channel for the radio station
    exports["pma-voice"]:setRadioChannel(currentFrequency)
    SendNUIMessage({ action = "updateStation", title = "LIVE: Adi's Talk Show" })
    
    -- Animation: Character holds a professional microphone if available
    local micProp = CreateObject(`p_ingame_mic_01`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(micProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.05, 0.05, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end
