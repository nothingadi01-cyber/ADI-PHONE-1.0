RegisterNUICallback("ai_command", function(data, cb)
    local input = data.input:lower()
    
    if string.find(input, "car") and string.find(input, "lock") then
        ExecuteCommand("lockcar") -- Triggers your car lock system
        SendNUIMessage({ action = "ai_reply", msg = "Vehicle secured, Adi." })
    elseif string.find(input, "gps") then
        SetNewWaypoint(441.1, -981.4) -- Example: Legion Sq
        SendNUIMessage({ action = "ai_reply", msg = "Route to City Center established." })
    end
    cb('ok')
end)
