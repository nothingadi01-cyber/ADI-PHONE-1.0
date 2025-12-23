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

local isBroadcasting = false

function toggleLive()
    isBroadcasting = not isBroadcasting
    local ped = PlayerPedId()

    if isBroadcasting then
        -- Character holds phone up like a pro camera
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MOBILE_FILM_PHOTOGRAPH", 0, true)
        
        -- Start the Stream
        local tickerText = GetTickerInput()
        TriggerServerEvent('adi_phone:server:startGlobalBroadcast', tickerText)
    else
        ClearPedTasks(ped)
        TriggerServerEvent('adi_phone:server:stopGlobalBroadcast')
    end
end

-- Replacing textures on every TV in the world
RegisterNetEvent('adi_phone:client:syncTvFeed')
AddEventHandler('adi_phone:client:syncTvFeed', function(isLive, url)
    if isLive then
        AddReplaceTexture("prop_tv_flat_01", "tv_screen", "AdiNews", "LiveFeed")
        -- Logic to point the DUI to the URL
    else
        RemoveReplaceTexture("prop_tv_flat_01", "tv_screen")
    end
end)
