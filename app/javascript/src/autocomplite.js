$(function() {
  $('#tag-autocomplete').autocomplete({
    source: '/tags',
    minLength: 2
  })
});
