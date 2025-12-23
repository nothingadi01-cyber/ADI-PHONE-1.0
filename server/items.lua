QBCore.Functions.CreateUseableItem("radio_decrypter", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    -- This item is consumed or used as a passive check for the phone app
    TriggerClientEvent('adi_phone:client:enableScanner', source)
end)
