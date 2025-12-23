RegisterServerEvent('adi_phone:server:onPlayerDeath')
AddEventHandler('adi_phone:server:onPlayerDeath', function()
    local src = source
    local playerPolicy = GetPlayerInsurance(src) -- Pulls from SQL

    if playerPolicy == "premium" then
        -- Tell the death script NOT to clear items
        TriggerClientEvent('hospital:client:KeepItems', src)
        
        -- Send a notification to the phone
        TriggerClientEvent('adi_phone:notification', src, "ADI-CARE", "Policy Active: Your equipment has been recovered.")
    else
        -- Standard loss of items
        TriggerClientEvent('adi_phone:notification', src, "SYSTEM", "No Insurance: Assets lost in transit.")
    end
end)
