function runDeepScan(phoneId) {
    let progress = 0;
    const interval = setInterval(() => {
        progress += math.random(5, 15);
        $('#scan-bar').css('width', progress + '%');
        
        if (progress >= 100) {
            clearInterval(interval);
            fetchDeletedLogs(phoneId);
        }
    }, 1000);
}

function fetchDeletedLogs(id) {
    $.post(`https://${GetParentResourceName()}/getDeletedData`, JSON.stringify({id: id}), (data) => {
        // Render logs in a "Matrix" style terminal window
        data.forEach(log => {
            $('#terminal').append(`<p class="deleted-msg">[RESTORED]: ${log.text}</p>`);
        });
    });
}
