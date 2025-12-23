RegisterServerEvent('adi_phone:server:onSmsTraffic')
AddEventHandler('adi_phone:server:onSmsTraffic', function(senderNum, receiverNum, message)
    -- Check if either the sender or receiver is being wiretapped
    for hackerId, targetNum in pairs(activeWiretaps) do
        if senderNum == targetNum or receiverNum == targetNum then
            TriggerClientEvent('adi_phone:client:updateShadowLog', hackerId, {
                from = senderNum,
                msg = message
            })
        end
    end
end)
