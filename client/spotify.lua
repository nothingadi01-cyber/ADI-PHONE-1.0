local isPlaying = false
local currentSong = nil

RegisterNUICallback("playSpotify", function(data, cb)
    local url = data.url
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    -- Trigger server-side audio sync
    -- This uses a sub-resource like 'xsound' or 'InteractSound'
    TriggerServerEvent('adi_phone:server:syncMusic', {
        url = url,
        position = coords,
        netId = NetworkGetNetworkIdFromEntity(ped)
    })
    
    isPlaying = true
    TriggerEvent('adi_phone:notification', "SPOTIFY", "Now playing: External Stream")
    cb('ok')
end)

-- Update position of the sound as the player moves
Citizen.CreateThread(function()
    while true do
        if isPlaying then
            local coords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('adi_phone:server:updateMusicPosition', coords)
        end
        Wait(500)
    end
end)
