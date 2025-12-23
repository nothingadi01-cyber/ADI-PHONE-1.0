local placedCameras = {}

RegisterNUICallback("deployCamera", function(data, cb)
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 0.0)
    
    -- Create the physical small camera object
    local camObj = CreateObject(`prop_micro_cam`, coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(camObj, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    
    -- Animation to 'place' it
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    Wait(3000)
    DetachEntity(camObj, true, true)
    PlaceObjectOnGroundProperly(camObj)
    
    table.insert(placedCameras, {obj = camObj, coords = coords})
    cb('ok')
end)
