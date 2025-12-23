RegisterNUICallback("repairComponent", function(data, cb)
    local ped = PlayerPedId()
    
    -- Start Repair Animation
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_PARKING_METER", 0, true)
    
    -- Progress Bar (Integration with your Adrenaline HUD)
    TriggerEvent('adi_hud:progressBar', "Repairing Hardware...", 5000)
    
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    
    -- Remove the 'Broken' state from the phone
    TriggerServerEvent('adi_phone:server:fixPhone', data.component)
    cb('ok')
end)
