function openAppSwitcher() {
    $(".active-app").addClass("minimized");
    $(".app-switcher-view").fadeIn(200);
    // Display snapshots of all currently "running" apps
    renderAppSnapshots();
}
