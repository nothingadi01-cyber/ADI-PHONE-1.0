RegisterServerEvent('adi_phone:server:buyDarknetItem')
AddEventHandler('adi_phone:server:buyDarknetItem', function(item, price)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player.PlayerData.money.bank >= price then
        player.Functions.RemoveMoney('bank', price, "Shadow-Net Purchase: "..item)
        
        -- Generate random drop-off location
        local dropOff = GetRandomDropOffLocation() -- Custom function
        
        -- Notify client to go to drop-off
        TriggerClientEvent('adi_phone:client:initiateDropOff', src, item, dropOff)
        TriggerClientEvent('adi_phone:notification', src, "SHADOW-NET", "Payment confirmed. Delivery initiated.")
    else
        TriggerClientEvent('adi_phone:notification', src, "ERROR", "Insufficient funds for dark-net purchase.")
    end
end)

RegisterServerEvent('adi_phone:server:collectDarknetItem')
AddEventHandler('adi_phone:server:collectDarknetItem', function(item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    -- Add the purchased item to the player's inventory
    player.Functions.AddItem(item, 1)
end)

-- Placeholder for custom drop-off location logic
function GetRandomDropOffLocation()
    local locations = {
        vector3(-1350.0, -1400.0, 4.0), 
        vector3(320.0, 260.0, 104.0),  
        vector3(1720.0, 3780.0, 33.0)   
    }
    return locations[math.random(1, #locations)]
end
