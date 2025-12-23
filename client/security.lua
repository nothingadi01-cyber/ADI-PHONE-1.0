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
