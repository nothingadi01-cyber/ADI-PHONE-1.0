RegisterNetEvent('adi_phone:client:triggerEAS')
AddEventHandler('adi_phone:client:triggerEAS', function(title, message, type)
    -- Play EAS Siren
    PlaySoundFrontend(-1, "Emergency_Siren", "DLC_ITY_Alerts", 1)
    
    -- Force Phone Open to EAS Page
    SendNUIMessage({
        action = "forceEAS",
        header = title,
        body = message,
        severity = type -- 'info', 'warning', 'critical'
    })
    
    -- Shake Camera for 'Critical' alerts
    if type == 'critical' then
        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.10)
    end
end)
