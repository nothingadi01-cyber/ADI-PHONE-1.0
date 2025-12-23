function postToSocial(caption) {
    const currentPhoto = localStorage.getItem('last_captured_photo');
    
    $.post(`https://${GetParentResourceName()}/socialPost`, JSON.stringify({
        image: currentPhoto,
        text: caption,
        timestamp: new Date().getTime()
    }), function(success) {
        if(success) {
            alert("Posted to Adi-Gram!");
            loadSocialFeed(); // Refresh the app
        }
    });
}
