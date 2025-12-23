RegisterNetEvent('adi_phone:client:receiveDropKey')
AddEventHandler('adi_phone:client:receiveDropKey', function(dropData)
    -- Add to the phone's 'Stash' app
    table.insert(myReceivedDrops, dropData)
    
    -- Start a 'Hot/Cold' beep on the Adrenaline HUD
    Citizen.CreateThread(function()
        while true do
            local dist = #(GetEntityCoords(PlayerPedId()) - dropData.pos)
            if dist < 50.0 then
                -- Show a pulsing red circle on the Phone Map
                DrawMarker(1, dropData.pos.x, dropData.pos.y, dropData.pos.z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 255, 0, 0, 150, false, false, 2, false, nil, nil, false)
                if dist < 2.0 then
                    DrawText3Ds(dropData.pos.x, dropData.pos.y, dropData.pos.z, "Press [E] to Enter PIN")
                end
            end
            Citizen.Wait(0)
        end
    end)
end)
