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
-- Global Twitter Post
RegisterServerEvent('adi_phone:postTwitter')
AddEventHandler('adi_phone:postTwitter', function(content)
    local src = source
    local name = GetPlayerName(src)
    -- Send to all clients to show a notification on their HUD
    TriggerClientEvent('adi_phone:client:receiveTweet', -1, name, content)
end)

-- Silent/Mute Mode Toggle
RegisterServerEvent('adi_phone:setSilent')
AddEventHandler('adi_phone:setSilent', function(status)
    Player(source).state.isSilent = status
end)
-- Example for ESX/QB-Core
RegisterUsableItem("powerbank", function(source)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeInventoryItem("powerbank", 1)
    TriggerClientEvent('adi_phone:usePowerbank', source)
end)

RegisterServerEvent('adi_phone:placeBounty')
AddEventHandler('adi_phone:placeBounty', function(targetPlayerId, reward)
    local src = source
    -- Deduct money from 'src'
    
    -- Notify all "Criminal" players
    TriggerClientEvent('adi_phone:notifyBounty', -1, targetPlayerId, reward)
    
    -- Add a red zone on the map for the target
    print("BOUNTY PLACED ON " .. targetPlayerId .. " FOR $" .. reward)
end)
-- Save player data to Database
RegisterServerEvent('adi_phone:cloudSync')
AddEventHandler('adi_phone:cloudSync', function(data)
    local identifier = GetPlayerIdentifier(source, 0)
    MySQL.Async.execute('INSERT INTO adi_phone_cloud (identifier, data) VALUES (@id, @data) ON DUPLICATE KEY UPDATE data = @data', {
        ['@id'] = identifier,
        ['@data'] = json.encode(data)
    })
    TriggerClientEvent('adi_phone:notification', source, "ADI-CLOUD", "Data Backup Successful")
end)
local cityTreasury = 4250900
local currentTaxRate = 5 -- Default 5%

-- Automatic Tax Collection
RegisterServerEvent('adi_phone:server:processPaycheck')
AddEventHandler('adi_phone:server:processPaycheck', function(salary)
    local src = source
    local taxAmount = math.floor(salary * (currentTaxRate / 100))
    local finalSalary = salary - taxAmount
    
    cityTreasury = cityTreasury + taxAmount
    
    -- Give money to player (Framework dependent)
    -- TriggerClientEvent('adi_phone:notification', src, "Gov Tax", "Deducted: $" .. taxAmount)
    
    -- Sync new treasury balance to Mayor's phone
    TriggerClientEvent('adi_phone:client:updateTreasury', -1, cityTreasury)
end)

-- Mayor changing the tax
RegisterServerEvent('adi_phone:server:setTaxRate')
AddEventHandler('adi_phone:server:setTaxRate', function(newRate)
    currentTaxRate = newRate
    TriggerClientEvent('adi_phone:client:getAdiVoice', -1, "CITY TAX RATE UPDATED TO " .. newRate .. "%")
end)

RegisterNetEvent('adi_phone:smartNotify')
AddEventHandler('adi_phone:smartNotify', function(appName, title, message, icon)
    -- Trigger HUD Animation
    SendNUIMessage({
        action = "showSmartNotify",
        app = appName,
        header = title,
        msg = message,
        img = icon
    })
    
    -- Subtle Haptic Feedback
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDS", 1)
end)

RegisterServerEvent('adi_phone:server:syncTvForAll')
AddEventHandler('adi_phone:server:syncTvForAll', function(netId)
    -- Tell all players near this NetID to replace their TV texture
    TriggerClientEvent('adi_phone:client:applyTvTexture', -1, netId)
end)

-- Save new passcode from Settings
RegisterServerEvent('adi_phone:server:updatePasscode')
AddEventHandler('adi_phone:server:updatePasscode', function(newPin)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    MySQL.Async.execute('UPDATE phone_settings SET passcode = @pin WHERE citizenid = @id', {
        ['@pin'] = newPin,
        ['@id'] = identifier
    })
end)

-- On Player Load:
-- Fetch the passcode and send it to the NUI so the phone knows its 'Master Key'
