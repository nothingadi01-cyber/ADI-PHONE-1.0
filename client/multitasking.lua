local backgroundApps = {}

-- Register an app to run in the background
RegisterNUICallback("runInBackground", function(data, cb)
    backgroundApps[data.appId] = true
    TriggerEvent('adi_phone:notification', "SYSTEM", data.appId .. " is now running in the background.")
    cb('ok')
end)

-- Main Thread for Background Tasks
Citizen.CreateThread(function()
    while true do
        Wait(10000) -- Every 10 seconds
        for app, active in pairs(backgroundApps) do
            if active then
                if app == "police_tracker" then
                    CheckForNearbyPolice() -- Existing tracking logic
                elseif app == "bio_monitor" then
                    SyncAdrenalineHUD()
                end
            end
        end
    end
end)
