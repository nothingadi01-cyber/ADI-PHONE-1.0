function transferMoney() {
    const targetPhone = $('#transfer-number').val();
    const amount = $('#transfer-amount').val();

    if (amount > 0 && targetPhone.length > 3) {
        $.post(`https://${GetParentResourceName()}/bankTransfer`, JSON.stringify({
            number: targetPhone,
            amount: parseInt(amount)
        }), function(response) {
            if (response === 'success') {
                showSuccessAnimation();
                updateBalance();
            } else {
                showError("Insufficient Funds or Invalid Number");
            }
        });
    }
}
