-- Tactical Command: Search for Narcotics
RegisterNUICallback("petAction", function(data, cb)
    local playerPed = PlayerPedId()
    local pet = GetPetEntity() -- Function to get your active pet

    if data.action == "search" then
        -- Find nearby 'drug' items or 'stash' props
        local drugProp = GetClosestObjectOfType(GetEntityCoords(pet), 20.0, `prop_poly_bag_01`, false, false, false)
        
        if DoesEntityExist(drugProp) then
            TaskGoToEntity(pet, drugProp, -1, 1.0, 2.0, 1073741824, 0)
            -- Play "Barking" when found
            Citizen.Wait(2000)
            PlaySoundFromEntity(-1, "Bark", pet, "DLC_ITY_Dogs", 0, 0)
            TriggerEvent('adi_phone:notification', "PET", "Your pet has caught a scent!")
        end
    elseif data.action == "attack" then
        local target = GetClosestPlayer() -- Get nearest hostile
        TaskCombatPed(pet, target, 0, 16)
        TriggerEvent('adi_phone:notification', "PET", "K9 DEPLOYED: Takedown initiated.")
    end
    cb('ok')
end)
