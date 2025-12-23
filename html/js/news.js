window.addEventListener('message', function(event) {
    if (event.data.action === "updateWeather") {
        $('#weather-icon').attr('class', 'fas ' + event.data.icon);
        $('#weather-temp').text(event.data.temp);
        $('#weather-desc').text(event.data.desc);
        $('#weather-widget').css('background', event.data.bg);
    }

    if (event.data.action === "receiveNews") {
        const news = event.data.data;
        $('#news-feed').prepend(`
            <div class="news-card animated fadeIn">
                <h3 style="font-size: 16px; margin: 0;">${news.title}</h3>
                <p style="font-size: 12px; color: #888;">Reported by ${news.author} at ${news.time}</p>
            </div>
        `);
        // Play a news notification sound
        playSound("NEWS_TICKER", 0.5);
    }
});
