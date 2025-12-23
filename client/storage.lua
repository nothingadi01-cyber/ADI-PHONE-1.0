RegisterNUICallback("clearAppCache", function(data, cb)
    local appName = data.app
    -- Logic to delete saved NUI local storage data for a specific app
    ExecuteCommand("me clears the cache of their " .. appName .. " app.")
    
    TriggerEvent('adi_phone:notification', "SYSTEM", "Cache cleared for " .. appName)
    cb('ok')
end)
