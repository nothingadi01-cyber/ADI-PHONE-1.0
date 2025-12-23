window.addEventListener('message', function(event) {
    if (event.data.action === "updateLocationType") {
        if (event.data.isIllegalZone) {
            $('body').addClass('nexus-theme');
            showApp('shadow_net'); // Auto-reveal hidden app
        } else {
            $('body').removeClass('nexus-theme');
            hideApp('shadow_net');
        }
    }
});
