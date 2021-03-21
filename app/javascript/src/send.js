$( document ).ready(function() {
  $("#new_message").on("ajax:success", function(event) {
    $('#new_message')[0].reset();
    location.reload();
  });
});
