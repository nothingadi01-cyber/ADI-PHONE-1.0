const allApps = {
    'banking': { label: 'Bank', icon: 'fas fa-university', color: '#1d976c' },
    'crypto': { label: 'Crypto', icon: 'fas fa-chart-line', color: '#f7931a' },
    'darknet': { label: 'Shadow', icon: 'fas fa-user-secret', color: '#1a1a1a' }
};

function renderHomeScreen() {
    $('#home-grid').empty();
    
    installedApps.forEach(appId => {
        const app = allApps[appId];
        if (app) {
            const html = `
                <div class="home-icon" onclick="openApp('${appId}')">
                    <div class="icon-bg" style="background: ${app.color}">
                        <i class="${app.icon}"></i>
                    </div>
                    <span>${app.label}</span>
                </div>
            `;
            $('#home-grid').append(html);
        }
    });
}
