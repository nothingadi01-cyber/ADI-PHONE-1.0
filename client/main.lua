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
RegisterNUICallback("adiCommand", function(data, cb)
    local cmd = data.command:lower()
    
    if string.find(cmd, "waypoint") then
        SetNewWaypoint(200.0, -1000.0) -- Example Coords
        SendNUIMessage({action = "adi_voice", msg = "GPS UPDATED, ADI."})
    elseif string.find(cmd, "mechanic") then
        ExecuteCommand("service mechanic")
        SendNUIMessage({action = "adi_voice", msg = "DISPATCHING MECHANIC."})
    end
    cb('ok')
end)
local batteryPercent = 100.0
local isCharging = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Check every 1 minute
        local ped = PlayerPedId()
        
        if not isCharging then
            local drainRate = 0.5 -- Base drain
            
            -- If phone is being used, drain faster
            if isPhoneOpen then drainRate = 1.5 end
            -- If camera is open, drain MUCH faster
            if isCameraOpen then drainRate = 5.0 end
            
            batteryPercent = batteryPercent - drainRate
        end

        if batteryPercent <= 0 then
            batteryPercent = 0
            if isPhoneOpen then
                TogglePhone() -- Force close phone
                SendNUIMessage({action = "adi_voice", msg = "POWER CRITICAL. SHUTTING DOWN."})
            end
        end
        
        SendNUIMessage({ action = "updateBattery", percent = batteryPercent })
    end
end)

-- CHARGING STATIONS (at Gas Stations or 24/7 Stores)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local coords = GetEntityCoords(PlayerPedId())
        local distance = #(coords - vector3(25.0, -1345.0, 29.0)) -- Example: Bench at Legion Sq

        if distance < 2.0 then
            isCharging = true
            batteryPercent = math.min(100.0, batteryPercent + 5.0)
            SendNUIMessage({ action = "adi_voice", msg = "CHARGING..." })
        else
            isCharging = false
        end
    end
end)

-- JOB CENTER: Request a new task
RegisterNUICallback("requestMission", function(data, cb)
    local missionType = data.type -- e.g., 'delivery' or 'assassin'
    SendNUIMessage({ action = "adi_voice", msg = "MISSION DATA DOWNLOADED. CHECK GPS." })
    
    -- Create Blip for mission
    local blip = AddBlipForCoord(120.0, -500.0, 30.0)
    SetBlipSprite(blip, 1)
    SetBlipRoute(blip, true)
    cb('ok')
end)

-- SERVICES: Call Mechanic / EMS / Police
RegisterNUICallback("callService", function(data, cb)
    local service = data.name
    TriggerServerEvent("adi_phone:requestService", service, GetEntityCoords(PlayerPedId()))
    SendNUIMessage({ action = "adi_voice", msg = service .. " HAS BEEN NOTIFIED." })
    cb('ok')
end)
