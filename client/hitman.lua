local activeContract = nil
local targetBlip = nil

RegisterNetEvent('adi_phone:client:startTracking')
AddEventHandler('adi_phone:client:startTracking', function(targetCoords)
    if targetBlip then RemoveBlip(targetBlip) end
    
    -- Create a fuzzy search radius (Radius Blip)
    targetBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 150.0)
    SetBlipSprite(targetBlip, 9)
    SetBlipColour(targetBlip, 1) -- Red
    SetBlipAlpha(targetBlip, 128)
    
    TriggerEvent('adi_phone:notification', "HITMAN", "Target signal localized. Check your GPS.")
end)

-- If the target is killed, clear the blip
RegisterNetEvent('adi_phone:client:contractComplete')
AddEventHandler('adi_phone:client:contractComplete', function()
    if targetBlip then RemoveBlip(targetBlip) end
    activeContract = nil
end)
