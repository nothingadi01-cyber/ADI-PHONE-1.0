local isPhoneLocked = true
local biometricEnabled = true

RegisterNUICallback("unlockPhone", function(data, cb)
    if biometricEnabled then
        -- Check if player is looking at the phone or if it's the owner
        local ped = PlayerPedId()
        if not IsEntityDead(ped) and not IsPedCuffed(ped) then
            isPhoneLocked = false
            PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_G_SOUNDS", 1)
            SendNUIMessage({ action = "unlockSuccess" })
        else
            TriggerEvent('adi_phone:notification', "SECURITY", "Biometric Authentication Failed.")
        end
    end
    cb('ok')
end)

local isPhoneLocked = true
local biometricEnabled = true

RegisterNUICallback("attemptFaceID", function(data, cb)
    local ped = PlayerPedId()
    
    -- Verification Conditions
    local isCuffed = IsPedCuffed(ped)
    local isDead = IsEntityDead(ped)
    local isDazed = IsPedRagdoll(ped)

    if not isDead and not isCuffed and not isDazed then
        -- Animation: Character brings phone closer to face
        TaskPlayAnim(ped, "cellphone@", "cellphone_text_read_base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        
        Citizen.Wait(1200) -- Simulate "Scanning" time
        
        isPhoneLocked = false
        SendNUIMessage({ action = "unlockPhoneSuccess" })
        PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_G_SOUNDS", 1)
    else
        -- If cuffed, the phone refuses to unlock
        isPhoneLocked = true
        SendNUIMessage({ action = "unlockPhoneFail" })
        PlaySoundFrontend(-1, "Pin_Bad", "DLC_HEIST_BIOLAB_PREP_G_SOUNDS", 1)
        TriggerEvent('adi_phone:notification', "SECURITY", "Biometric Match Failed: Obstruction Detected.")
    end
    cb('ok')
end)
