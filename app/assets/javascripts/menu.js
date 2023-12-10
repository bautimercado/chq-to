document.addEventListener("DOMContentLoaded", function() {
    const userMenu = document.getElementById("userMenu");

    $("#userDropdown").on("click", function() {
        $("#userMenu").toggleClass("hidden");
    });


    $(document).on("click", function(event) {
        if (!$(event.target).closest("#userDropdown, #userMenu").length) {
            $("#userMenu").addClass("hidden");
        }
    });
});