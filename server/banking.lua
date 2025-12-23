RegisterServerEvent('adi_phone:server:transferMoney')
AddEventHandler('adi_phone:server:transferMoney', function(targetId, amount)
    local src = source
    local sender = QBCore.Functions.GetPlayer(src)
    local receiver = QBCore.Functions.GetPlayer(tonumber(targetId))

    if receiver and sender.PlayerData.citizenid ~= receiver.PlayerData.citizenid then
        if sender.PlayerData.money.bank >= amount then
            sender.Functions.RemoveMoney('bank', amount, "Phone Transfer to "..targetId)
            receiver.Functions.AddMoney('bank', amount, "Phone Transfer from "..src)
            
            -- Log to Database for History
            MySQL.Async.execute('INSERT INTO phone_transactions (sender, receiver, amount, label) VALUES (@s, @r, @a, @l)', {
                ['@s'] = sender.PlayerData.citizenid,
                ['@r'] = receiver.PlayerData.citizenid,
                ['@a'] = amount,
                ['@l'] = "Digital Transfer"
            })

            TriggerClientEvent('adi_phone:notification', src, "BANK", "Sent $"..amount.." to ID "..targetId)
            TriggerClientEvent('adi_phone:notification', targetId, "BANK", "Received $"..amount.." from ID "..src)
        else
            TriggerClientEvent('adi_phone:notification', src, "BANK", "Insufficient funds.")
        end
    else
        TriggerClientEvent('adi_phone:notification', src, "BANK", "Target player not found.")
    end
end)
