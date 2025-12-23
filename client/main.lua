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

RegisterNUICallback("carControl", function(data, cb)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true) -- Gets last vehicle
    local action = data.action

    if DoesEntityExist(vehicle) then
        if action == "lock" then
            SetVehicleDoorsLocked(vehicle, 2)
            PlayVehicleDoorCloseSound(vehicle, 1)
            SendNUIMessage({action = "adi_voice", msg = "VEHICLE SECURED."})
        elseif action == "engine" then
            local status = GetIsVehicleEngineRunning(vehicle)
            SetVehicleEngineOn(vehicle, not status, true, true)
            SendNUIMessage({action = "adi_voice", msg = "ENGINE TOGGLED."})
        elseif action == "find" then
            SetBlipRoute(GetEntityBlip(vehicle), true)
            SendNUIMessage({action = "adi_voice", msg = "VEHICLE LOCATED."})
        end
    end
    cb('ok')
end)

local currentMission = nil

RegisterNUICallback("startContract", function(data, cb)
    local type = data.type
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)

    if type == "illegal_delivery" then
        local dropOff = vector3(120.5, -1200.2, 29.0) -- Random location
        currentMission = { pos = dropOff, type = "delivery" }
        
        SetNewWaypoint(dropOff.x, dropOff.y)
        SendNUIMessage({ action = "adi_voice", msg = "PACKAGE MARKED. DON'T GET CAUGHT." })
        
        -- Spawn an NPC "Buyer" at the location
        SpawnMissionNPC(dropOff)
    end
    cb('ok')
end persistence)

-- AR SCANNER LOGIC
RegisterNUICallback("startARScanner", function(data, cb)
    local ped = PlayerPedId()
    SendNUIMessage({ action = "adi_voice", msg = "NEURAL SCANNER INITIALIZED." })
    
    Citizen.CreateThread(function()
        while isScannerOpen do
            Citizen.Wait(100)
            local target = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if DoesEntityExist(target) and IsEntityAPed(target) then
                local tId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(target))
                SendNUIMessage({
                    action = "ar_data",
                    name = GetPlayerName(NetworkGetPlayerIndexFromPed(target)),
                    id = tId
                })
            end
        end
    end)
    cb('ok')
end)

local securityCam = nil
local isWatchingCCTV = false

RegisterNUICallback("viewCCTV", function(data, cb)
    local camCoords = data.coords -- The location of the house camera
    local camRotation = data.rotation

    if not isWatchingCCTV then
        isWatchingCCTV = true
        
        -- Create the Security Camera
        securityCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(securityCam, camCoords.x, camCoords.y, camCoords.z)
        SetCamRot(securityCam, camRotation.x, camRotation.y, camRotation.z, 2)
        SetCamFov(securityCam, 70.0)
        
        -- Apply a "Security Filter" (Black & White or Grainy)
        SetTimecycleModifier("scanline_cam_chevron")
        SetTimecycleModifierStrength(1.2)
        
        -- Render the camera to the NUI
        RenderScriptCams(true, false, 0, true, true)
        SendNUIMessage({ action = "adi_voice", msg = "CCTV LINK ESTABLISHED." })
    else
        StopCCTV()
    end
    cb('ok')
end)

function StopCCTV()
    isWatchingCCTV = false
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(securityCam)
    ClearTimecycleModifier()
    SendNUIMessage({ action = "adi_voice", msg = "CCTV DISCONNECTED." })
end

-- Create a camera for the person you are calling
function startFaceTime(targetId)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    local phoneCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(phoneCam, targetPed, 0.1, 0.5, 0.6, true)
    -- This renders to a texture used in the NUI <iframe>
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
end

RegisterNUICallback("summonVehicle", function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    local playerCoords = GetEntityCoords(PlayerPedId())

    if DoesEntityExist(vehicle) then
        -- Neural link feedback
        SendNUIMessage({ action = "adi_voice", msg = "NEURAL LINK ESTABLISHED. VEHICLE EN ROUTE." })
        
        TaskVehicleDriveToCoord(GetPedInVehicleSeat(vehicle, -1), vehicle, playerCoords.x, playerCoords.y, playerCoords.z, 20.0, 0, GetEntityModel(vehicle), 786603, 1.0, true)
    end
    cb('ok')
end)

local scannerMode = "normal"

RegisterNUICallback("toggleVision", function(data, cb)
    scannerMode = data.mode -- 'thermal' or 'night'
    if scannerMode == "thermal" then
        SetSeethrough(true)
    elseif scannerMode == "night" then
        SetNightvision(true)
    else
        SetSeethrough(false)
        SetNightvision(false)
    end
    cb('ok')
end)

RegisterNUICallback("requestValet", function(data, cb)
    local vehiclePlate = data.plate
    SendNUIMessage({ action = "adi_voice", msg = "VALET IS BRINGING YOUR VEHICLE, ADI." })
    
    -- Logic to spawn vehicle nearby and drive to player
    TriggerServerEvent("adi_phone:valetFetch", vehiclePlate)
    cb('ok')
end)

RegisterNUICallback("transferMoney", function(data, cb)
    local targetNumber = data.number
    local amount = tonumber(data.amount)
    local note = data.note or "Sent from Adi-Phone"

    -- Trigger server to check balance and send
    TriggerServerEvent("adi_phone:server:transferMoney", targetNumber, amount, note)
    cb('ok')
end)

-- Receive Notification
RegisterNetEvent('adi_phone:client:getPaid')
AddEventHandler('adi_phone:client:getPaid', function(amount, senderName)
    SendNUIMessage({
        action = "adi_voice", 
        msg = "PAYMENT RECEIVED: $" .. amount .. " FROM " .. senderName
    })
    -- Play a "Cash Register" sound
    PlaySoundFrontend(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
end)
RegisterNUICallback("getNearbyPlayers", function(data, cb)
    local players = GetActivePlayers()
    local nearby = {}
    local myPos = GetEntityCoords(PlayerPedId())

    for _, player in ipairs(players) do
        local targetPed = GetPlayerPed(player)
        local targetPos = GetEntityCoords(targetPed)
        if #(myPos - targetPos) < 20.0 and player ~= PlayerId() then
            table.insert(nearby, {
                name = GetPlayerName(player),
                id = GetPlayerServerId(player)
            })
        end
    end
    cb(nearby)
end)
