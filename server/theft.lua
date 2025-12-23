RegisterServerEvent('adi_phone:server:wipePhone')
AddEventHandler('adi_phone:server:wipePhone', function(stolenPhoneId)
    local src = source
    -- Logic to check if player has 'Hacker Tool'
    -- If successful, the phone is cleared of the old owner's data
    -- The criminal can then sell the 'Clean Phone' for a high price or use it.
    TriggerClientEvent('adi_phone:notification', src, "SYSTEM", "Phone Encrypted Data Wiped.")
end)
