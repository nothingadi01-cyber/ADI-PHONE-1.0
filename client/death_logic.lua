AddEventHandler('baseevents:onPlayerDied', function()
    local src = source
    -- Check if player has the "Quantum-Cloud" insurance policy
    TriggerServerEvent('adi_phone:server:checkInsurance', function(hasInsurance)
        if not hasInsurance then
            -- The physical phone prop is "dropped" at the scene
            local coords = GetEntityCoords(PlayerPedId())
            local brokenPhone = CreateObject(`prop_npc_phone_02`, coords.x, coords.y, coords.z, true, true, true)
            SetEntityAsMissionEntity(brokenPhone, true, true)
            
            -- Remove item from player inventory
            TriggerServerEvent('adi_phone:server:removePhoneItem')
            TriggerEvent('adi_phone:notification', "SYSTEM", "Hardware lost. Access Quantum Cloud to restore data on a new device.")
        end
    end)
end)
