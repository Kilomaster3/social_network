const bindSendMessageListeners = () => {
  $(document).on('turbolinks:load', () =>
    $(document).on('ajax:success', function() {
      $(this).find('input[type="text"]').val('');
    })
  );
};

export default bindSendMessageListeners;
