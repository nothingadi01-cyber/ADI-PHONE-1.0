local isJammed = false

Citizen.CreateThread(function()
    while true do
        local sleep = 5000
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        -- Check for nearby jammer objects (prop_cs_case_01 as example)
        local jammer = GetClosestObjectOfType(playerCoords, 30.0, `prop_cs_case_01`, false, false, false)

        if DoesEntityExist(jammer) then
            if not isJammed then
                isJammed = true
                SendNUIMessage({ action = "setSignal", strength = 0, status = "JAMMED" })
                TriggerEvent('adi_phone:notification', "SIGNAL", "WARNING: High-frequency interference detected.")
            end
            sleep = 1000
        else
            if isJammed then
                isJammed = false
                SendNUIMessage({ action = "setSignal", strength = 5, status = "ONLINE" })
            end
        end
        Wait(sleep)
    end
end)
