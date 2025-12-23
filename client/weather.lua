local weatherIcons = {
    ["EXTRASUNNY"] = "fa-sun",
    ["CLEAR"] = "fa-cloud-sun",
    ["CLOUDS"] = "fa-cloud",
    ["RAIN"] = "fa-cloud-showers-heavy",
    ["THUNDER"] = "fa-bolt",
    ["SNOW"] = "fa-snowflake"
}

Citizen.CreateThread(function()
    while true do
        local weatherType = GetPrevWeatherTypeHashName() -- Native to get current weather
        local temp = GetTemperatureAtCoords(0.0, 0.0, 0.0) -- Basic native temp
        
        -- Logic to find the string name of the weather
        local weatherString = "CLEAR" -- Default
        -- (Add your framework specific weather string check here)

        SendNUIMessage({
            action = "updateWeather",
            icon = weatherIcons[weatherString] or "fa-sun",
            temp = math.floor(temp) .. "°C",
            desc = weatherString,
            bg = (weatherString == "RAIN" or weatherString == "THUNDER") and "#4a4a4a" or "#5ac8fa"
        })
        Wait(30000) -- Update every 30 seconds
    end
end)
