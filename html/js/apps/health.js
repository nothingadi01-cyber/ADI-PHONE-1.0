window.addEventListener('message', function(event) {
    if (event.data.action === "updateBioLink") {
        const stats = event.data.data;
        
        // Update circular progress bars
        updateCircle('hp-ring', stats.hp);
        updateCircle('food-ring', stats.food);
        updateCircle('water-ring', stats.water);

        if (stats.hp < 20) {
            $('#health-warning').text("CRITICAL: SEEK MEDICAL AID").addClass('blink');
        }
    }
});

function updateCircle(id, value) {
    const circle = document.getElementById(id);
    const radius = circle.r.baseVal.value;
    const circumference = 2 * Math.PI * radius;
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = circumference - (value / 100) * circumference;
}
