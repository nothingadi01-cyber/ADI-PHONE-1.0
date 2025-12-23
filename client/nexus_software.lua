-- ATM Burst Virus
function runVirus(type)
    if type == "atm" then
        local playerPed = PlayerPedId()
        local atm = GetClosestObjectOfType(GetEntityCoords(playerPed), 2.0, `prop_atm_02`, false, false, false)

        if DoesEntityExist(atm) then
            -- Mini-game on Phone screen
            TriggerEvent('adi_phone:minigame:startHacking', function(success)
                if success then
                    -- Physical Effect: ATM spits out cash
                    TriggerServerEvent('adi_phone:server:atmPayout')
                    RequestNamedPtfxAsset("core")
                    UseParticleFxAssetNextCall("core")
                    StartParticleFxLoopedAtCoord("ent_brk_banknotes", GetEntityCoords(atm), 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    TriggerEvent('adi_phone:notification', "NEXUS", "ATM Link Compromised. Cash Ejected.")
                else
                    -- Failed: Trigger Silent Alarm for Police
                    TriggerServerEvent('adi_phone:server:policeAlert', "ATM Tampering Detected")
                end
            end)
        end
    end
end
