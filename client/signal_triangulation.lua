local isTracking = false
local targetCoords = nil

RegisterNetEvent('adi_phone:client:startTracking')
AddEventHandler('adi_phone:client:startTracking', function(coords)
    isTracking = true
    targetCoords = coords
    
    Citizen.CreateThread(function()
        while isTracking do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - targetCoords)
            
            -- Send signal strength to UI (0.0 to 1.0)
            local strength = 1.0 - (distance / 1000.0)
            if strength < 0 then strength = 0 end
            
            SendNUIMessage({
                action = "updateTracker",
                strength = strength,
                dist = distance
            })
            
            -- Audio feedback: Faster beeps as you get closer
            PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACK_SOUNDS", 1)
            Wait(math.floor(math.max(200, distance * 2)))
        end
    end)
end)
