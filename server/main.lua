local currentPrice = 50000.0 -- Starting price of Adi-Coin
local priceHistory = {}

-- 1. Global Price Fluctuation (Every 60 seconds)
Citizen.CreateThread(function()
    while true do
        local change = math.random(-5000, 5500) -- Random market movement
        currentPrice = currentPrice + change
        if currentPrice < 1000 then currentPrice = 1000 end -- Floor price
        
        table.insert(priceHistory, currentPrice)
        if #priceHistory > 10 then table.remove(priceHistory, 1) end
        
        TriggerClientEvent('adi_phone:updateCrypto', -1, currentPrice)
        Citizen.Wait(60000)
    end
end)

-- 2. Buy/Sell Logic (Example for QBCore/ESX)
RegisterServerEvent('adi_phone:buyCrypto')
AddEventHandler('adi_phone:buyCrypto', function(amount)
    local src = source
    local cost = amount * currentPrice
    -- Add your framework check here (e.g., if xPlayer.getMoney() >= cost)
    print("Player " .. src .. " bought " .. amount .. " Adi-Coin")
end)
