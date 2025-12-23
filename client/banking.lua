RegisterNUICallback("transferMoney", function(data, cb)
    local targetId = data.id
    local amount = tonumber(data.amount)

    if amount and amount > 0 then
        -- Send request to server
        TriggerServerEvent('adi_phone:server:transferMoney', targetId, amount)
    else
        TriggerEvent('adi_phone:notification', "BANK", "Invalid amount.")
    end
    cb('ok')
end)

-- Update Balance on App Open
RegisterNUICallback("getBankData", function(data, cb)
    QBCore.Functions.TriggerCallback('adi_phone:server:getBankInfo', function(info)
        SendNUIMessage({
            action = "updateBank",
            balance = info.balance,
            transactions = info.history
        })
    end)
    cb('ok')
end)
