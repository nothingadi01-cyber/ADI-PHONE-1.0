local isSniffing = false

RegisterNUICallback("toggleSniffer", function(data, cb)
    isSniffing = not isSniffing
    if isSniffing then
        TriggerEvent('adi_phone:notification', "NEXUS", "Packet Sniffing Active. Monitoring localized data...")
    end
    cb('ok')
end)

-- Catching the "Data Leak" from the server
RegisterNetEvent('adi_phone:client:onDataIntercepted')
AddEventHandler('adi_phone:client:onDataIntercepted', function(info)
    if isSniffing then
        local myCoords = GetEntityCoords(PlayerPedId())
        if #(myCoords - info.coords) < 50.0 then
            SendNUIMessage({
                action = "addSniffLog",
                log = "[INTERCEPTED]: " .. info.type .. " from " .. info.sender
            })
            PlaySoundFrontend(-1, "Key_Press_Success", "DLC_HEIST_HACK_SOUNDS", 1)
        end
    end
end)
