// Function to upload a photo taken with the phone camera
function uploadToGallery(imageData) {
    // We send the raw data to an external provider (like Imgur or a custom API)
    fetch('https://api.yourserver.com/upload', {
        method: 'POST',
        body: JSON.stringify({ image: imageData })
    })
    .then(res => res.json())
    .then(data => {
        const permanentLink = data.link;
        // Save this link to the SQL database via Lua
        $.post(`https://${GetParentResourceName()}/savePhotoLink`, JSON.stringify({
            url: permanentLink
        }));
    });
}
