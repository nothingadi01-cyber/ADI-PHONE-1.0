local playerAlarms = {}

RegisterNUICallback("setAlarm", function(data, cb)
    table.insert(playerAlarms, {
        time = data.time, -- Format "HH:MM"
        label = data.label or "Reminder"
    })
    TriggerEvent('adi_phone:notification', "CALENDAR", "Alarm set for " .. data.time)
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        local currentTime = string.format("%02d:%02d", hour, minute)

        for i, alarm in ipairs(playerAlarms) do
            if alarm.time == currentTime then
                -- Trigger Alarm Effect
                TriggerEvent('adi_phone:client:triggerAlarm', alarm.label)
                table.remove(playerAlarms, i)
            end
        end
        Wait(2000) -- Check every 2 seconds
    end
end)

RegisterNetEvent('adi_phone:client:triggerAlarm')
AddEventHandler('adi_phone:client:triggerAlarm', function(label)
    -- Vibrate the phone and play a loud sound
    local count = 0
    while count < 3 do
        PlaySoundFrontend(-1, "Phone_Generic_Key_01", "HUD_MINI_GAME_SOUNDSET", 1)
        ShakeGameplayCam("VIBRATE_SHAKE", 1.0)
        TriggerEvent('adi_phone:notification', "ALARM", label)
        count = count + 1
        Wait(1000)
    end
end)
