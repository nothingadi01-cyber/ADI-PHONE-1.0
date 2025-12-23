RegisterServerEvent('adi_phone:server:repairPhone')
AddEventHandler('adi_phone:server:repairPhone', function()
    local src = source
    local price = 1500 -- Repair Cost
    
    if GetPlayerMoney(src) >= price then
        RemoveItem(src, "broken_phone", 1)
        AddItem(src, "adi_phone_infinity", 1)
        
        -- The Magic Moment: Quantum Sync
        TriggerClientEvent('adi_phone:notification', src, "REPAIR", "Hardware fixed. Syncing Cloud Data...")
        TriggerEvent('adi_phone:server:restoreQuantumBackup', src)
    end
end)
