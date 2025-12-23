RegisterServerEvent('adi_phone:server:sendKillCode')
AddEventHandler('adi_phone:server:sendKillCode', function(targetIMEI)
    local src = source
    -- Find the player who owns this IMEI
    MySQL.Async.fetchScalar('SELECT identifier FROM phone_hardware WHERE imei = @imei', {
        ['@imei'] = targetIMEI
    }, function(identifier)
        if identifier then
            local targetPlayer = QBCore.Functions.GetPlayerByCitizenId(identifier)
            if targetPlayer then
                TriggerClientEvent('adi_phone:client:brickDevice', targetPlayer.PlayerData.source)
                TriggerClientEvent('adi_phone:notification', src, "SUCCESS", "Device Brick Command Executed.")
            end
        end
    end)
end)

-- Client Side (The Victim)
RegisterNetEvent('adi_phone:client:brickDevice')
AddEventHandler('adi_phone:client:brickDevice', function()
    -- Lock the screen to a "SYSTEM ERROR" screen
    SendNUIMessage({ action = "openApp", app = "error_screen" })
    TriggerEvent('adi_phone:notification', "HARDWARE", "CRITICAL ERROR: Kernel Panic. System Wipe Initiated.")
    
    -- Play explosion sound at ear level
    PlaySoundFrontend(-1, "HACK_FAILED", "DLC_HEIST_BIOLAB_PREP_G_SOUNDS", 1)
    
    -- Drop the phone prop
    TaskLeaveAnyVehicle(PlayerPedId())
    Wait(500)
    TriggerServerEvent('adi_phone:server:removePhoneItem')
end)
