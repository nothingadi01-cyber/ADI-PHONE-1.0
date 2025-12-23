// Settings Management
let phoneSettings = {
    airplaneMode: false,
    darkMode: true,
    haptics: true,
    volume: 80
};

function toggleAirplaneMode() {
    phoneSettings.airplaneMode = !phoneSettings.airplaneMode;
    
    // Send to Lua to cut GPS and Signal
    $.post(`https://${GetParentResourceName()}/toggleSignal`, JSON.stringify({
        status: phoneSettings.airplaneMode
    }));

    updateUI();
}

function changeTheme(mode) {
    if (mode === 'dark') {
        $('body').addClass('dark-theme').removeClass('light-theme');
    } else {
        $('body').addClass('light-theme').removeClass('dark-theme');
    }
}

function updateUI() {
    const icon = phoneSettings.airplaneMode ? "✈️" : "📶";
    $('#signal-status').text(icon);
}

// Toggle Dark Mode
function toggleDarkMode(enabled) {
    if (enabled) {
        document.body.classList.add('dark-theme');
        document.body.classList.remove('light-theme');
    } else {
        document.body.classList.add('light-theme');
        document.body.classList.remove('dark-theme');
    }
}

// Adjust HUD Brightness via Slider
$('#hud-slider').on('input', function() {
    let value = $(this).val();
    $.post(`https://${GetParentResourceName()}/updateHudAlpha`, JSON.stringify({
        alpha: value
    }));
});
function toggleFaceID() {
    let isEnabled = $('#faceid-toggle').is(':checked');
    
    $.post(`https://${GetParentResourceName()}/saveSecuritySetting`, JSON.stringify({
        faceid: isEnabled
    }));

    if(isEnabled) {
        showNotification("SECURITY", "FaceID Enabled. Your data is now protected.");
    }
}

// Logic to show/hide lock screen on open
window.addEventListener('message', function(event) {
    if (event.data.action === "openPhone") {
        if (biometricEnabled) {
            $('#faceid-screen').show();
            $.post(`https://${GetParentResourceName()}/attemptFaceID`);
        }
    }
});
