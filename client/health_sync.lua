Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped) - 100
        local armor = GetPedArmour(ped)
        
        -- Get Hunger/Thirst from your framework (ESX/QB)
        local hunger = exports['qb-inventory']:GetStats().hunger -- Example
        local thirst = exports['qb-inventory']:GetStats().thirst

        SendNUIMessage({
            action = "updateBioLink",
            data = {
                hp = health,
                arm = armor,
                food = hunger,
                water = thirst
            }
        })
        Wait(5000)
    end
end)
