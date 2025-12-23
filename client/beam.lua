RegisterNUICallback("startBeamTransfer", function(data, cb)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local targetPlayer, distance = GetClosestPlayer() -- Custom function to find nearest ID

    if targetPlayer ~= -1 and distance < 2.0 then
        -- Play Handshake Animation
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_MOBILE", 0, true)
        
        -- Trigger the Beam Effect
        TriggerServerEvent('adi_phone:server:processBeam', GetPlayerServerId(targetPlayer), data.amount)
        
        -- Visual/Sound Feedback
        PlaySoundFrontend(-1, "Scan_Unlock", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
    else
        SendNUIMessage({ action = "adi_voice", msg = "NO TARGET IN NFC RANGE." })
    end
    cb('ok')
end)
