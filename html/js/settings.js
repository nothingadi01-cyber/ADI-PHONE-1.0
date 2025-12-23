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
