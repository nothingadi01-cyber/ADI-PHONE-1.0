RegisterServerEvent('adi_phone:server:throwPhone')
AddEventHandler('adi_phone:server:throwPhone', function(coords)
    local src = source
    -- Remove the item from inventory
    RemoveItem(src, "adi_phone_burner", 1)
    
    -- Create a physical prop on the ground for others to find
    local phoneProp = CreateObject(`prop_npc_phone_02`, coords.x, coords.y, coords.z, true, true, true)
    SetEntityAsMissionEntity(phoneProp, true, true)
    
    -- Stop any active wiretaps or tracks on this ID
    TriggerClientEvent('adi_phone:client:stopAllTracks', -1, src)
end)
