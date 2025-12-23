let step = 'current';
let tempNewPin = '';

function initiatePinChange() {
    // We reuse the Passcode UI from before but in "Setup Mode"
    step = 'current';
    openPasscodeUI("Enter Current Passcode");
}

// Logic called when the 4th digit is pressed in Settings mode
function handleSettingsPinEntry(enteredPin) {
    if (step === 'current') {
        if (enteredPin === masterCode) {
            step = 'new';
            resetPasscodeUI("Enter New Passcode");
        } else {
            shakePasscodeUI();
        }
    } else if (step === 'new') {
        tempNewPin = enteredPin;
        step = 'confirm';
        resetPasscodeUI("Confirm New Passcode");
    } else if (step === 'confirm') {
        if (enteredPin === tempNewPin) {
            saveNewPin(enteredPin);
            closePasscodeUI();
            showNotification("SUCCESS", "Passcode changed successfully.");
        } else {
            step = 'new';
            resetPasscodeUI("Pins didn't match. Try New Pin");
        }
    }
}

function saveNewPin(pin) {
    masterCode = pin; // Update local variable
    $.post(`https://${GetParentResourceName()}/updatePasscode`, JSON.stringify({
        newPin: pin
    }));
}
