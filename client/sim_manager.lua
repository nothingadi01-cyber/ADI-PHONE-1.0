local currentSim = "123-4567"

RegisterNetEvent('adi_phone:client:swapSim')
AddEventHandler('adi_phone:client:swapSim', function(newNumber)
    currentSim = newNumber
    
    -- Play "Changing SIM" Animation
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
    
    Citizen.Wait(3000)
    ClearPedTasks(PlayerPedId())

    SendNUIMessage({
        action = "updatePhoneNumber",
        number = newNumber
    })
    
    TriggerEvent('adi_phone:notification', "HARDWARE", "SIM Card Swapped. New Number: " .. newNumber)
end)
