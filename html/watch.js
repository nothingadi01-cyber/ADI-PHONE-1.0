window.addEventListener('message', function(event) {
    if (event.data.action === "openWatch") {
        $(".watch-container").fadeIn(200);
        $("#health-bar").css("width", event.data.health + "%");
        $("#armor-bar").css("width", event.data.armor + "%");
        $("#watch-time").text(event.data.time);
    } else if (event.data.action === "closeWatch") {
        $(".watch-container").fadeOut(200);
    }
});
