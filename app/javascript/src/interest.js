$(function(){
  $('[id*="interestCheckbox"]').change(function() {
    let accountId = $('[id*="current_account_id"]').attr('id').replace('current_account_id_', '');
    let interestsCheckboxes = $('[id*="interestCheckbox"]');
    let interestIds = [];

    interestsCheckboxes.each((index,  checkbox) => {
      if (checkbox.checked) {
        interestIds.push(checkbox.id.replace('interestCheckbox', ''));
      }
    });

    $.ajax({
      type: 'patch',
      url: `/account_interests/${accountId}`,
      data: {
        account: { interest_ids: interestIds }
      },
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content
      }
    });
  });
});
