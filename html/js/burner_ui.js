function applyBurnerRestrictions() {
    // Hide high-end apps
    $('.app-icon[data-app="crypto"]').hide();
    $('.app-icon[data-app="quantum_cloud"]').hide();
    $('.app-icon[data-app="settings"]').css('filter', 'grayscale(100%)');
    
    // Change wallpaper to a static "Low-Res" image
    $('#phone-wrapper').css('background', 'url("assets/img/old_mobile.jpg")');
}
