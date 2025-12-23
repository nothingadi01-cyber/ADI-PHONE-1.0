local payphoneProps = {
    `prop_phonebox_01a`, `prop_phonebox_01b`, `prop_phonebox_01c`, `prop_phonebox_02`, `prop_phonebox_03`, `prop_phonebox_04`
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        for _, model in pairs(payphoneProps) do
            local booth = GetClosestObjectOfType(coords, 2.0, model, false, false, false)
            if DoesEntityExist(booth) then
                sleep = 0
                DrawText3Ds(GetEntityCoords(booth), "[E] USE PUBLIC PHONE ($10)")
                
                if IsControlJustReleased(0, 38) then -- Key E
                    TriggerServerEvent('adi_phone:server:usePublicPhone')
                    -- Open a limited version of the phone UI
                    SendNUIMessage({ action = "openPublicPhone" })
                    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_MOBILE", 0, true)
                end
            end
        end
        Wait(sleep)
    end
end)
