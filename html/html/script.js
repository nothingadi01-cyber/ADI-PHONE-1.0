window.addEventListener('message', function(event) {
    if (event.data.action === "updateCrypto") {
        const priceElement = document.getElementById('live-price');
        const trend = document.getElementById('price-trend');
        const oldPrice = parseFloat(priceElement.innerText.replace('$', ''));
        const newPrice = event.data.price;

        priceElement.innerText = "$" + newPrice.toLocaleString();

        if (newPrice > oldPrice) {
            trend.innerText = "▲ MARKET RISING";
            trend.className = "trend-up";
        } else {
            trend.innerText = "▼ MARKET CRASHING";
            trend.className = "trend-down";
        }
    }
});
