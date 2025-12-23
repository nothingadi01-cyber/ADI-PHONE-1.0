window.addEventListener('message', function(event) {
    if (event.data.action === "updateBattery") {
        const level = event.data.level;
        const charging = event.data.isCharging;

        $('#battery-text').text(level + "%");
        $('#battery-fill').css('width', level + "%");

        if (level <= 20) $('#battery-fill').addClass('low-battery');
        else $('#battery-fill').removeClass('low-battery');

        if (charging) $('#charging-bolt').show();
        else $('#charging-bolt').hide();
        
        if (level <= 0) {
            $('#phone-wrapper').fadeOut(); // Shut down phone
        }
    }
});
