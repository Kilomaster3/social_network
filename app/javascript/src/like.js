$(document).on('turbolinks:load', function() {
  $('.like-button').click((like) =>{
    let postId = like.currentTarget.id.replace('like_button_', '');

    $.ajax({
      type: 'POST',
      url: `/posts/${postId}/likes`,
      data: {
        post: { id: postId }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      },
      success: (data) => {
        let counter = $('#like_count_' + postId)[0];
        $(counter).text(data.likes_count)
      },
      error: (xhr) => {
        alert(xhr.responseJSON.error)
      }
    });
  });
});
