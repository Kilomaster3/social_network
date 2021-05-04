$(document).on('turbolinks:load', function() {
  $('.dislike-button').click((dislike) =>{
    let postId = dislike.target.id.replace('dislike_count_', '');
    let newDislikesCount = parseInt($(dislike.target).text()) + 1;
    $(dislike.target).text(newDislikesCount);

    $('[id*="dislike_count_"]').each((index,  dislike) => {
      if(dislike.target){
        $('[id*="dislike_button_"]').text(newDislikesCount)
      }
    });

    $.ajax({
      type: 'POST',
      url: `/posts/${postId}/dislikes`,
      data: {
        post: { id: postId }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      }
    });
  });
});
