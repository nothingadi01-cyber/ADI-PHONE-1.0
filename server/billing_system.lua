RegisterServerEvent('adi_phone:server:processMonthlyBill')
AddEventHandler('adi_phone:server:processMonthlyBill', function()
    local src = source
    local billAmount = 250 -- Daily service fee
    
    if GetPlayerMoney(src) >= billAmount then
        RemoveMoney(src, billAmount)
        TriggerClientEvent('adi_phone:notification', src, "BILLING", "Daily service fee paid: $250")
    else
        -- Cut the signal!
        TriggerClientEvent('adi_phone:client:setSignalOverride', src, 0)
        TriggerClientEvent('adi_phone:notification', src, "SERVICE ALERT", "Insufficient funds. Service suspended. Only 911 calls allowed.")
    end
end)
