local isTracking = false
local trackRadius = 500.0

RegisterNetEvent('adi_phone:client:startTriangulation')
AddEventHandler('adi_phone:client:startTriangulation', function(targetCoords)
    isTracking = true
    
    Citizen.CreateThread(function()
        while isTracking do
            local myCoords = GetEntityCoords(PlayerPedId())
            local dist = #(myCoords - targetCoords)
            
            -- The "Bleep" sound speeds up as you get closer
            local beepInterval = math.max(200, dist * 2)
            PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACK_SOUNDS", 1)
            
            -- UI Pulse on ADRENALINE HUD
            SendNUIMessage({ action = "signalPulse", intensity = (1.0 - (dist/500)) })
            
            Wait(math.floor(beepInterval))
        end
    end)
end)
