$(document).on('turbolinks:load', function() {
  $('[id*="commentButton"]').click((comment) =>{
    let comments = comment.target.id.split('_');
    let postId = comments[1];
    let accountId = comments[2];
    let body = $('#commentBody_' + postId).val();


    $.ajax({
      type: 'POST',
      url: `/posts/${postId}/comments`,
      data:{
        comment: {
          post_id: postId,
          account_id: accountId,
          body
        }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      }
    });
  });
});
