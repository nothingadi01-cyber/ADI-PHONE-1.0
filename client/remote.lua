local nearbyObjects = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local pos = GetEntityCoords(PlayerPedId())
        -- Find nearby 'Smart' objects (Garage doors, TVs)
        local door = GetClosestObjectOfType(pos, 10.0, `p_iron_gate_01`, false, false, false)
        
        if DoesEntityExist(door) then
            SendNUIMessage({
                action = "foundDevice",
                name = "Main Mansion Gate",
                type = "gate"
            })
        end
    end
end)
