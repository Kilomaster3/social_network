$(function() {
  $('#new_room_message').on('ajax:success', function() {
    $(this).find('input[type="text"]').val('');
  });
});
