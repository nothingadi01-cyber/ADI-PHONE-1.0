-- Wireless Terminal Link (Phone to PC)
local linkedTerminal = nil

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        -- Find nearby PC/Laptop props
        local pc = GetClosestObjectOfType(playerCoords, 2.0, `prop_laptop_01a`, false, false, false)
        
        if DoesEntityExist(pc) then
            sleep = 0
            -- HUD Prompt via ADRENALINE HUD
            DrawText3Ds(GetEntityCoords(pc), "[Y] UPLINK PHONE TO TERMINAL")
            
            if IsControlJustReleased(0, 246) then -- Key Y
                linkedTerminal = pc
                ExecuteCommand("openphone")
                SendNUIMessage({ 
                    action = "terminalMode", 
                    pcId = ObjToNet(pc),
                    status = "connected"
                })
                -- Play "Typing on Phone" animation
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
            end
        end
        Wait(sleep)
    end
end)

function DrawText3Ds(coords, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x,_y)
end
