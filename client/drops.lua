local currentDrops = {}

function createPhysicalDrop()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local passcode = GetUIInput('drop-passcode')

    -- Animation: Character kneels and hides a small package
    TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
    Wait(4000)
    
    -- Create the physical 'Small Package' prop
    local dropProp = CreateObject(`prop_money_bag_01`, coords.x, coords.y, coords.z - 1.0, true, true, true)
    PlaceObjectOnGroundProperly(dropProp)
    FreezeEntityPosition(dropProp, true)

    -- Generate the 'Digital Key' (Metadata for a text message)
    local dropKey = {
        pos = coords,
        pin = passcode,
        id = math.random(1000, 9999)
    }
    
    TriggerServerEvent('adi_phone:server:saveDrop', dropKey)
    ClearPedTasks(ped)
end
