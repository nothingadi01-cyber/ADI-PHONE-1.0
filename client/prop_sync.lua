local currentPhoneProp = `prop_npc_phone_02` -- Default
local activePhoneEntity = nil

RegisterNetEvent('adi_phone:client:updatePhoneProp')
AddEventHandler('adi_phone:client:updatePhoneProp', function(caseType)
    -- Map cases to physical GTA props or your custom add-on props
    local props = {
        ["default"] = `prop_npc_phone_02`,
        ["gold"] = `p_amb_phone_01`, -- Example gold-ish prop
        ["tactical"] = `prop_v_res_phone_01`, -- Rugged look
        ["pink"] = `prop_phone_ing_01`
    }

    currentPhoneProp = props[caseType] or props["default"]
    
    -- If player is currently holding the phone, swap it instantly
    if activePhoneEntity ~= nil then
        DeleteEntity(activePhoneEntity)
        local ped = PlayerPedId()
        activePhoneEntity = CreateObject(currentPhoneProp, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(activePhoneEntity, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    end
end)
