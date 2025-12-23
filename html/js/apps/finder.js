function trackLostDevice(targetNumber) {
    $.post(`https://${GetParentResourceName()}/pingDevice`, JSON.stringify({
        number: targetNumber
    }), function(coords) {
        if (coords) {
            // Draw a temporary blip on the map for 10 seconds
            setGPSRoute(coords.x, coords.y);
            showNotification("DEVICE LOCATED: Signal pulsing on GPS.");
        } else {
            showNotification("SIGNAL LOST: Phone may be powered off or destroyed.");
        }
    });
}
