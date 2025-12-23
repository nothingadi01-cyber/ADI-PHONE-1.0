RegisterNUICallback("initiateAdiDrop", function(data, cb)
    local target, distance = GetClosestPlayer() -- Use your existing proximity function

    if distance < 3.0 then
        -- Play "Sending" Animation
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
        
        TriggerServerEvent('adi_phone:server:sendAirdrop', GetPlayerServerId(target), {
            type = data.type, -- "photo", "contact", "location"
            content = data.content
        })
        TriggerEvent('adi_phone:notification', "ADI-DROP", "File sent successfully!")
    else
        TriggerEvent('adi_phone:notification', "ERROR", "No devices found nearby.")
    end
    cb('ok')
end)
