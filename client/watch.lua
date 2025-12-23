local watchActive = false

RegisterCommand("checkwatch", function()
    local ped = PlayerPedId()
    
    if not watchActive then
        watchActive = true
        -- Animation: Lifting the wrist to the face
        TaskPlayAnim(ped, "amb@world_human_leaning@male@wall@p_arm_ready@idle_a", "idle_a", 8.0, -8.0, -1, 49, 0, false, false, false)
        
        SendNUIMessage({
            action = "openWatch",
            health = GetEntityHealth(ped) - 100,
            armor = GetPedArmour(ped),
            time = GetClockHours() .. ":" .. GetClockMinutes()
        })
    else
        watchActive = false
        ClearPedTasks(ped)
        SendNUIMessage({ action = "closeWatch" })
    end
end, false)

-- Keybind for Watch (e.g., Pressing 'Y')
RegisterKeyMapping('checkwatch', 'Quick Watch Sync', 'keyboard', 'Y')
