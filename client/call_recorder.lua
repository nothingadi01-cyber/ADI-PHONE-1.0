local isRecording = false

RegisterNUICallback("toggleCallRecord", function(data, cb)
    isRecording = not isRecording
    
    if isRecording then
        TriggerEvent('adi_phone:notification', "RECORDER", "Call recording started...")
        -- Log the audio stream metadata
    else
        TriggerEvent('adi_phone:notification', "RECORDER", "Recording saved to Voice Memos.")
        -- Create a record in the database for the 'Voice Memos' app
        TriggerServerEvent('adi_phone:server:saveRecording', "Call_" .. os.date("%x_%H:%M"))
    end
    cb('ok')
end)
