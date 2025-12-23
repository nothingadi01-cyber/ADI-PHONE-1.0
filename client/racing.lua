local raceCheckpoints = {}

function startDrawingTrack()
    SendNUIMessage({ action = "openBigMap" })
    -- Enable a cursor on the map to drop pins
    while isDrawing do
        Wait(0)
        if IsControlJustReleased(0, 38) then -- [E] Key to drop checkpoint
            local mapCoords = GetMapClickCoords()
            table.insert(raceCheckpoints, mapCoords)
            -- Play a 'Blip' sound for feedback
            PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINIGAME_SOUNDSET", 1)
        end
    end
end
