window.addEventListener('message', function(event) {
    if (event.data.action === "updateCrypto") {
        const priceElement = document.getElementById('live-price');
        const trend = document.getElementById('price-trend');
        const oldPrice = parseFloat(priceElement.innerText.replace('$', ''));
        const newPrice = event.data.price;

        priceElement.innerText = "$" + newPrice.toLocaleString();

        if (newPrice > oldPrice) {
            trend.innerText = "▲ MARKET RISING";
            trend.className = "trend-up";
        } else {
            trend.innerText = "▼ MARKET CRASHING";
            trend.className = "trend-down";
        }
    }
});
let installedApps = {
    insta: true,
    twitter: true,
    dark: false
};

function downloadApp(appId) {
    const btn = document.getElementById(`btn-${appId}`);
    btn.innerHTML = '<div class="spinner"></div>'; // Loading animation
    
    setTimeout(() => {
        btn.innerHTML = "OPEN";
        btn.className = "open-btn";
        installedApps[appId] = true;
        refreshHomeScreen(); // Updates the main phone screen
        speak("App installation complete, Adi.");
    }, 3000);
}

function updateApp(appId) {
    const btn = document.getElementById(`btn-${appId}`);
    btn.innerHTML = "UPDATING...";
    
    setTimeout(() => {
        btn.innerHTML = "LATEST";
        btn.disabled = true;
        btn.style.opacity = "0.5";
        speak("System update applied for " + appId);
    }, 2000);
}
function attemptUnlock() {
    const lockScreen = document.getElementById('lock-screen');
    const faceIcon = document.getElementById('face-id-scanner');
    
    faceIcon.classList.add('scanning'); // Pulsing animation
    
    // Call client to check if face is visible
    fetch(`https://${GetParentResourceName()}/checkFace`, {}).then(resp => resp.json()).then(data => {
        if (data.success) {
            lockScreen.style.transform = "translateY(-100%)";
            speak("Face ID recognized. Welcome, Adi.");
        } else {
            faceIcon.classList.add('error-shake');
            speak("Access denied. Remove mask.");
        }
    });
}

let currentApp = null;

function openApp(appId) {
    // Dynamic Island Expansion Effect
    const island = document.getElementById('dynamic-island');
    island.classList.add('island-expand');
    
    setTimeout(() => {
        document.getElementById(`${appId}-app`).style.display = 'block';
        document.getElementById('ios-app-grid').style.opacity = '0';
        island.classList.remove('island-expand');
        currentApp = appId;
    }, 300;
}

// Swipe Up Gesture (Home Indicator)
document.querySelector('.home-indicator').addEventListener('click', () => {
    if (currentApp) {
        document.getElementById(`${currentApp}-app`).style.display = 'none';
        document.getElementById('ios-app-grid').style.opacity = '1';
        currentApp = null;
    } else {
        closePhone(); // Close the NUI
    }
});

function searchGoogle(query) {
    const url = `https://www.google.com/search?q=${query}`;
    document.getElementById('safari-frame').src = url;
}
-- Client side FaceTime logic
RegisterNetEvent('adi_phone:faceTimeStream')
AddEventHandler('adi_phone:faceTimeStream', function(targetId)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    -- Create a sub-camera focusing on targetPed's face
    local faceCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(faceCam, targetPed, 0.0, 0.5, 0.7, true)
    -- Push to NUI via RUI (Render Target)
end)

// TINDER SWIPE SYSTEM
function swipeTinder(direction) {
    const card = document.querySelector('.tinder-card');
    if (direction === 'right') {
        card.style.transform = 'translateX(200px) rotate(20deg)';
        speak("It's a match, Adi!");
    } else {
        card.style.transform = 'translateX(-200px) rotate(-20deg)';
    }
    setTimeout(() => { loadNextProfile(); }, 500);
}

// TELEGRAM (Encrypted Group Chats)
function sendTelegram(msg) {
    fetch(`https://${GetParentResourceName()}/sendTelegram`, {
        method: 'POST',
        body: JSON.stringify({ message: msg, channel: 'Global' })
    });
}

function processNFCPayment(amount, recipientId) {
    // Play a "Beep" sound
    const audio = new Audio('assets/nfc_beep.mp3');
    audio.play();

    // Trigger animation
    document.getElementById('nfc-animation').style.display = 'block';

    fetch(`https://${GetParentResourceName()}/processPayment`, {
        method: 'POST',
        body: JSON.stringify({ amount: amount, to: recipientId })
    }).then(() => {
        speak("Payment successful. Thank you, Adi.");
    });
}
