local inVehicle = false
local currentDui = nil

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(veh, seat, name)
    local hasScreen = GetEntityBoneIndexByName(veh, "v_dashboard_screen")
    
    if hasScreen ~= -1 then
        -- Automatically sync phone to Dashboard
        local txd = CreateRuntimeTxd("CarLinkFeed")
        currentDui = CreateDui("http://adi_phone/html/carlink.html", 1024, 512)
        local handle = GetDuiHandle(currentDui)
        CreateRuntimeTextureFromDuiHandle(txd, "Display", handle)
        
        -- Replace the car's built-in dashboard texture
        AddReplaceTexture(GetEntityModel(veh), "script_rt_dashboard", "CarLinkFeed", "Display")
        inVehicle = true
    end
end)
