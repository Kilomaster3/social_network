$(document).on('turbolinks:load', function() {
  $('.like-button').click((like) =>{
    let postId = like.target.id.replace('like_count_', '');
    let newLikesCount = parseInt($(like.target).text()) + 1;
    $(like.target).text(newLikesCount);

    $('[id*="like_count_"]').each((index,  like) => {
      if(like.target){
        $('[id*="like_button_"]').text(newLikesCount)
      }
    });

    $.ajax({
      type: 'POST',
      url: `/posts/${postId}/likes`,
      data: {
        post: { id: postId }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      }
    });
  });
});
