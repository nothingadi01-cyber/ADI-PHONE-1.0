let inputCode = "";
const masterCode = "1234"; // This would be fetched from the database

function pressKey(num) {
    if (inputCode.length < 4) {
        inputCode += num;
        updateDots();
        
        if (inputCode.length === 4) {
            verifyPasscode();
        }
    }
}

function verifyPasscode() {
    if (inputCode === masterCode) {
        // Success
        $.post(`https://${GetParentResourceName()}/unlockByPasscode`, JSON.stringify({ success: true }));
        $('#passcode-screen').fadeOut();
        resetPasscode();
    } else {
        // Fail: Shake animation
        $('.dots-container').addClass('shake');
        setTimeout(() => { 
            $('.dots-container').removeClass('shake'); 
            resetPasscode();
        }, 500);
    }
}

function updateDots() {
    let dots = document.querySelectorAll('.dot');
    dots.forEach((dot, index) => {
        if (index < inputCode.length) dot.classList.add('filled');
        else dot.classList.remove('filled');
    });
}

function resetPasscode() {
    inputCode = "";
    updateDots();
}
