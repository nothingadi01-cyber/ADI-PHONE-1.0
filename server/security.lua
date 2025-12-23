local LicenseKey = "ADI-XXXX-YYYY-ZZZZ" -- The server owner puts their key here
local MasterServer = "https://api.adi-scripts.com/verify" -- Your own verification API

MySQL.ready(function()
    print("^4[Adi-Secure]^7 Verifying License for Adi-Infinity OS...")

    PerformHttpRequest(MasterServer .. "?key=" .. LicenseKey, function(errorCode, resultData, resultHeaders)
        local response = json.decode(resultData)

        if errorCode == 200 and response.status == "success" then
            print("^2[Adi-Secure]^7 SUCCESS: License Valid. Welcome, " .. response.owner)
            StartAdiInfinityOS() -- Starts all your apps
        else
            print("^1[Adi-Secure] ERROR: UNAUTHORIZED ACCESS DETECTED.")
            print("^1[Adi-Secure] Script is locking. Please contact Adi on GitHub.")
            -- Stop the script from functioning
            StopResource(GetCurrentResourceName())
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end)
