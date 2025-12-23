local phoneHealth = 100

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        
        -- Water Damage Check
        if IsEntityInWater(ped) and not HasItem("waterproof_case") then
            phoneHealth = phoneHealth - 5
            if phoneHealth < 50 then
                TriggerEvent('adi_phone:client:glitchUI', true)
            end
            if phoneHealth <= 0 then
                TriggerServerEvent('adi_phone:server:breakPhone', "Water Damage")
                break
            end
        end

        -- Explosion/Melee Damage Check
        if HasEntityBeenDamagedByWeapon(ped, `weapon_hammer`, 0) then
            phoneHealth = 0
            TriggerServerEvent('adi_phone:server:breakPhone', "Physical Destruction")
            ClearEntityLastDamageEntity(ped)
        end
        
        Wait(5000)
    end
end)
