-- Secret Admin Menu (Triggered via /adiadmin)
local isAdmin = false

TriggerServerEvent('adi_phone:server:isAdmin') -- Check perms on startup

RegisterNetEvent('adi_phone:client:openAdminPanel')
AddEventHandler('adi_phone:client:openAdminPanel', function()
    SendNUIMessage({
        action = "openApp",
        app = "admin_console",
        data = {
            totalUsers = 150, -- Mock data
            serverLoad = "0.01ms",
            activeCalls = 12
        }
    })
end)

RegisterNUICallback("adminAction", function(data, cb)
    if data.type == "global_alert" then
        TriggerServerEvent('adi_phone:server:globalAlert', data.message)
    elseif data.type == "wipe_player" then
        TriggerServerEvent('adi_phone:server:remoteWipe', data.targetId)
    end
    cb('ok')
end)
