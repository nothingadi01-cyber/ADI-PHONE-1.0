// Hidden Recovery Logic
window.addEventListener('keydown', (event) => {
    if (event.shiftKey && event.key === 'P') {
        openRecoveryMenu();
    }
});

function openRecoveryMenu() {
    $('#phone-wrapper').hide(); // Hide normal OS
    $('#recovery-screen').show(); // Show Matrix-style BIOS
    
    console.log("ADI-OS RECOVERY MODE INITIATED...");
}

function factoryReset() {
    if(confirm("WIPE ALL DATA? This cannot be undone without Quantum Cloud.")) {
        $.post(`https://${GetParentResourceName()}/wipePhoneData`);
        window.location.reload(); // Hard reset UI
    }
}
