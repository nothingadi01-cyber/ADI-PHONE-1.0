local function generateDropOffLocation()
    -- Define a list of safe, obscure locations for drop-offs
    local locations = {
        { x = -1350.0, y = -1400.0, z = 4.0 }, -- Abandoned warehouse area
        { x = 320.0, y = 260.0, z = 104.0 },  -- Under a bridge
        { x = 1720.0, y = 3780.0, z = 33.0 }   -- Rural dirt road
    }
    return locations[math.random(1, #locations)]
end

RegisterNUICallback("purchaseDarkItem", function(data, cb)
    local item = data.item
    local price = data.price

    -- Send request to server for payment & item check
    TriggerServerEvent('adi_phone:server:buyDarknetItem', item, price)
    cb('ok')
end)

RegisterNetEvent('adi_phone:client:initiateDropOff')
AddEventHandler('adi_phone:client:initiateDropOff', function(item, coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 140) -- Briefcase icon
    SetBlipColour(blip, 1)   -- Red
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Shadow-Net Drop-Off")
    EndTextCommandSetBlipName(blip)
    
    TriggerEvent('adi_phone:notification', "SHADOW-NET", "Delivery en route. Proceed to drop-off.")
    
    Citizen.CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local dist = #(playerCoords - coords)
            
            if dist < 5.0 then
                -- Player is at drop-off, deliver item
                RemoveBlip(blip)
                TriggerServerEvent('adi_phone:server:collectDarknetItem', item)
                TriggerEvent('adi_phone:notification', "SHADOW-NET", "Item retrieved. Transaction complete.")
                break
            end
            Wait(1000)
        end
    end)
end)
