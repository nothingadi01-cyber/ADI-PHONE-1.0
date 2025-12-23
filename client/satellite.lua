local satCam = nil

function requestOrbitalFeed(coords)
    local x, y, z = coords.x, coords.y, coords.z
    
    -- Create the Orbital Camera
    satCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z + 500.0, -90.0, 0.0, 0.0, 60.0, false, 0)
    SetCamActive(satCam, true)
    RenderScriptCams(true, true, 1500, true, true)

    -- Apply Digital Filters
    SetTimecycleModifier("tunnel") -- Gives it a grainy, digital look
    SetTimecycleModifierStrength(0.5)

    TriggerEvent('adi_phone:notification', "SATELLITE", "Orbital Link Established. 60s remaining.")

    -- Timer to cut the feed
    SetTimeout(60000, function()
        stopOrbitalFeed()
    end)
end

function setSatMode(mode)
    if mode == "thermal" then
        SetSeethrough(true) -- Enable Thermal
    else
        SetSeethrough(false)
    end
end
