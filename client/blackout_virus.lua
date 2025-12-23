RegisterNUICallback("triggerBlackout", function(data, cb)
    local pos = GetEntityCoords(PlayerPedId())
    
    -- Effect: Physical world change
    TriggerServerEvent('adi_phone:server:syncBlackout', pos)
    
    -- Visual Feedback on Phone
    SendNUIMessage({ action = "terminalLog", msg = "UPLOADING EXPLOIT: GRID_OVERLOAD_V2..." })
    
    Citizen.SetTimeout(5000, function()
        -- Turn off all lights in a 200m radius
        SetScriptGfxDrawOrder(1)
        SetBlackout(true) 
        
        TriggerEvent('adi_phone:notification', "NEXUS", "Grid offline. Stealth protocol active.")
        
        -- Restore power after 2 minutes
        Citizen.Wait(120000)
        SetBlackout(false)
    end)
    cb('ok')
end)
