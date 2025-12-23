-- Toggle Focus Mode
RegisterNUICallback("setFocusMode", function(data, cb)
    local mode = data.mode -- 'dnd', 'driving', 'work'
    
    if mode == "driving" then
        -- Automatically block notifications if speed > 50mph
        Citizen.CreateThread(function()
            while focusMode == "driving" do
                local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
                if speed > 50.0 then
                    SetPhoneNotifications(false)
                end
                Wait(1000)
            end
        end)
    end
    cb('ok')
end)
