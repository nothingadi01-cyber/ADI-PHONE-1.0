RegisterServerEvent('adi_phone:server:wipePhone')
AddEventHandler('adi_phone:server:wipePhone', function(stolenPhoneId)
    local src = source
    -- Logic to check if player has 'Hacker Tool'
    -- If successful, the phone is cleared of the old owner's data
    -- The criminal can then sell the 'Clean Phone' for a high price or use it.
    TriggerClientEvent('adi_phone:notification', src, "SYSTEM", "Phone Encrypted Data Wiped.")
end)

// Mini-game for hacking into a stolen phone
function startBruteForce() {
    let code = Math.floor(Math.random() * 9000) + 1000;
    // Player must solve a puzzle to 'crack' the 4-digit pin
    openHackingGame(code, function(success) {
        if (success) {
            showIslandStatus("🔓 ACCESS GRANTED");
            openApp('bank'); // Access the victim's money!
        }
    });
            }
            
