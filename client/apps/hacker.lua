RegisterNUICallback("triggerBlackout", function(data, cb)
    -- Check if player has "Hacker Device" item
    SendNUIMessage({ action = "adi_voice", msg = "BREACHING CITY GRID... STAND BY." })
    
    TriggerServerEvent("adi_phone:server:blackout")
    
    -- Visual Glitch on phone
    StartScreenEffect("DeathFailOut", 0, 0)
    Wait(2000)
    StopScreenEffect("DeathFailOut")
    cb('ok')
end)
