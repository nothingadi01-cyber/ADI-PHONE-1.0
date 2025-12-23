local isPhoneOpen = false

-- Open Phone with 'M' key or Command
RegisterCommand("phone", function()
    TogglePhone()
end)

function TogglePhone()
    isPhoneOpen = not isPhoneOpen
    SetNuiFocus(isPhoneOpen, isPhoneOpen)
    
    if isPhoneOpen then
        SendNUIMessage({ action = "openPhone" })
        -- Animation: Pulling out phone
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
    else
        SendNUIMessage({ action = "closePhone" })
        StopAnimTask(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", "idle", 1.0)
    end
end

-- Crypto App Logic
RegisterNUICallback("getCryptoPrice", function(data, cb)
    local btcPrice = math.random(40000, 60000)
    cb({ price = btcPrice })
end)
local currentCamera = "rear"
local fov = 50.0

-- SWITCH FRONT/REAR CAMERA
function switchCamera()
    if currentCamera == "rear" then
        currentCamera = "front"
        AttachCamToEntity(phoneCam, PlayerPedId(), 0.05, 0.5, 0.8, true) -- Front view
    else
        currentCamera = "rear"
        AttachCamToEntity(phoneCam, PlayerPedId(), 0.1, 0.1, 0.8, true) -- Normal view
    end
end

-- CAMERA ZOOM LOGIC
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isCameraOpen then
            if IsControlJustPressed(0, 27) then -- Scroll Up
                fov = math.max(10.0, fov - 5.0)
                SetCamFov(phoneCam, fov)
            elseif IsControlJustPressed(0, 173) then -- Scroll Down
                fov = math.min(70.0, fov + 5.0)
                SetCamFov(phoneCam, fov)
            end
        end
    end
end)
