//$(document).ready(function () {
$( document ).on('turbolinks:load', function() {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

});

//$( document ).on('turbolinks:load', function() {