local marketPrices = {
    ["BTC"] = 95000.0,
    ["ADI"] = 1.20,
    ["GHOST"] = 50.0
}

-- Price Volatility Loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Every 1 minute
        for coin, price in pairs(marketPrices) do
            local fluctuation = math.random(-5, 5) / 100 -- -5% to +5%
            marketPrices[coin] = price * (1 + fluctuation)
        end
        TriggerClientEvent('adi_phone:client:updatePrices', -1, marketPrices)
    end
end)
