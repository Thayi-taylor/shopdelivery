$(document).ready(function() {
    $('#routeForm').on('submit', function(event) {
        var start = $('#start').val();
        var end = $('#end').val();

        if (!start || !end) {
            alert('출발지와 도착지를 모두 입력해주세요.');
            event.preventDefault();
        }
    });
});