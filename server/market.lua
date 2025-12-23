RegisterServerEvent('adi_phone:server:buyItem')
AddEventHandler('adi_phone:server:buyItem', function(listingId, deliveryType)
    local src = source
    local itemData = GetListingData(listingId) -- Pulls from SQL
    local playerMoney = GetPlayerMoney(src)

    if playerMoney >= itemData.price then
        RemoveMoney(src, itemData.price)
        -- Give money to the seller (if it's a player listing)
        AddMoney(itemData.sellerId, itemData.price)

        if itemData.type == "item" then
            -- Option 1: Instant Delivery to Inventory
            AddItem(src, itemData.itemName, 1)
        elseif itemData.type == "vehicle" then
            -- Option 2: Delivery to Player's Garage
            SaveVehicleToGarage(src, itemData.vehicleModel)
        end

        TriggerClientEvent('adi_phone:notification', src, "MARKET", "Purchase Successful! Check your inventory.")
    else
        TriggerClientEvent('adi_phone:notification', src, "MARKET", "Insufficient Funds.")
    end
end)
