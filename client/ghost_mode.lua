local ghostModeActive = false

RegisterNUICallback("toggleGhostMode", function(data, cb)
    ghostModeActive = not ghostModeActive
    
    if ghostModeActive then
        -- Tell the server to remove this player from the "Active Signal" table
        TriggerServerEvent('adi_phone:server:setSignalStealth', true)
        SetTimecycleModifier("scanline_cam_bw") -- Subtle visual filter when on
        TriggerEvent('adi_phone:notification', "GHOST", "Encryption active. You are now off the grid.")
    else
        TriggerServerEvent('adi_phone:server:setSignalStealth', false)
        ClearTimecycleModifier()
        TriggerEvent('adi_phone:notification', "GHOST", "Signal restored. Network visibility: 100%.")
    end
    cb('ok')
end)
