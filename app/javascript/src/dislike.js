$(document).on('turbolinks:load', function() {
  $('.dislike-button').click((dislike) =>{
    let postId = dislike.currentTarget.id.replace('dislike_button_', '');

    $.ajax({
      type: 'POST',
      url: `/posts/${postId}/dislikes`,
      data: {
        post: { id: postId }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      },
      success: (data) => {
        alert('Dislike added')
        let counter = $('#dislike_count_' + postId)[0];
        $(counter).text(data.dislikes_count)
      },
      error: (xhr) => {
        alert(xhr.responseJSON.error)
      }
    });
  });
});
