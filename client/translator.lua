RegisterNetEvent('adi_phone:client:translateVoice')
AddEventHandler('adi_phone:client:translateVoice', function(sourcePlayer, originalText, targetLang)
    -- This simulates the 'Neural Link' picking up local speech
    local translatedText = exports['adi_translator']:Translate(originalText, targetLang)
    
    -- Display as a sleek subtitle on the Phone Screen/HUD
    SendNUIMessage({
        action = "showSubtitle",
        sender = GetPlayerName(sourcePlayer),
        text = translatedText
    })
end)
