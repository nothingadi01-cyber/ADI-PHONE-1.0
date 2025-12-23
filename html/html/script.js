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
