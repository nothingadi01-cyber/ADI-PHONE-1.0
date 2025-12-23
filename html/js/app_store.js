let installedApps = ['settings', 'app_store', 'phone']; // Default system apps

function installApp(appId) {
    if (installedApps.includes(appId)) return;

    const btn = event.target;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>'; // Loading icon
    
    setTimeout(() => {
        installedApps.push(appId);
        btn.innerHTML = 'OPEN';
        btn.style.background = '#007aff';
        btn.style.color = '#fff';
        
        // Tell the phone to add the icon to the home screen
        $.post(`https://${GetParentResourceName()}/saveInstalledApp`, JSON.stringify({
            app: appId
        }));
        
        renderHomeScreen(); // Refresh home screen icons
    }, 3000);
}
