RegisterServerEvent('adi_phone:server:activateBurner')
AddEventHandler('adi_phone:server:activateBurner', function()
    local src = source
    local newNumber = math.random(111111, 999999)
    
    -- Update only the current session's number, not the master database
    Player(src).state.tempNumber = newNumber
    
    TriggerClientEvent('adi_phone:notification', src, "BURNER", "New Identity Active: " .. newNumber)
    
    -- Log the link for 24 hours, then revert
    SetTimeout(86400000, function()
        Player(src).state.tempNumber = nil
    end)
end)
