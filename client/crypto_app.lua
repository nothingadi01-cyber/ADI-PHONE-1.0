local cryptoPrices = { ["ADI"] = 100.0, ["BTC"] = 2500.0 }

-- Update prices based on server events
RegisterNetEvent('adi_phone:client:updateCrypto')
AddEventHandler('adi_phone:client:updateCrypto', function(coin, newPrice)
    cryptoPrices[coin] = newPrice
    SendNUIMessage({
        action = "updateMarket",
        coin = coin,
        price = newPrice
    })
end)

function buyCrypto(coin, amount)
    local price = cryptoPrices[coin] * amount
    TriggerServerEvent('adi_phone:server:processCryptoTrade', coin, amount, price, "buy")
end
