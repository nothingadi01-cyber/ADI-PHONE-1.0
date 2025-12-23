-- Ghost-Sim Spoofing Logic
RegisterServerEvent('adi_phone:server:sendSpoofedMsg')
AddEventHandler('adi_phone:server:sendSpoofedMsg', function(targetNumber, fakeNumber, message)
    local src = source
    local hasSpoofCard = CheckInventory(src, "ghost_sim") -- Requires special item

    if hasSpoofCard then
        -- We trigger the standard phone message event but replace the 'sender' ID
        TriggerClientEvent('adi_phone:client:receiveSMS', -1, {
            sender = fakeNumber, -- The Spoofed Number
            receiver = targetNumber,
            content = message,
            isGhost = true
        })
        -- Consume the single-use Ghost Sim
        RemoveItem(src, "ghost_sim", 1)
    else
        TriggerClientEvent('adi_phone:notification', src, "ERROR", "No Ghost-Sim detected.")
    end
end)
