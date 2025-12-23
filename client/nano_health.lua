Citizen.CreateThread(function()
    while true do
        local health = GetEntityHealth(PlayerPedId()) - 100
        if autoInjectEnabled and health < 20 then
            if HasItem("adrenaline_shot") then
                TriggerServerEvent('adi_phone:server:useItem', "adrenaline_shot")
                SendNUIMessage({ action = "nano_alert", msg = "EMERGENCY DOSE ADMINISTERED" })
            end
        end
        Wait(5000)
    end
end)
