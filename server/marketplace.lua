local marketItems = {}

RegisterServerEvent('adi_phone:server:listItem')
AddEventHandler('adi_phone:server:listItem', function(itemName, price, count)
    local src = source
    local id = #marketItems + 1
    
    marketItems[id] = {
        seller = GetPlayerName(src),
        item = itemName,
        price = price,
        amount = count
    }
    
    TriggerClientEvent('adi_phone:notification', -1, "MARKET", "New item listed: " .. itemName)
end)

RegisterServerEvent('adi_phone:server:buyItem')
AddEventHandler('adi_phone:server:buyItem', function(itemId)
    local src = source
    local item = marketItems[itemId]
    
    if item and GetPlayerBankBalance(src) >= item.price then
        RemoveBankMoney(src, item.price)
        AddItem(src, item.item, item.amount)
        table.remove(marketItems, itemId)
        TriggerClientEvent('adi_phone:notification', src, "ADI-BAY", "Purchase successful!")
    end
end)
