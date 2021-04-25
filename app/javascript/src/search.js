const ready = function () {
  const engine = new Bloodhound({
    datumTokenizer: function (d) {
      console.log(d);
      return Bloodhound.tokenizers.whitespace(d.title);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '../search/typeahead/%QUERY'
    }
  });

  const promise = engine.initialize();

  promise
    .done(function () {
      console.log('success');
    })
    .fail(function () {
      console.log('error')
    });

  $("#term").typeahead(null, {
    name: "post",
    displayKey: "content",
    source: engine.ttAdapter()
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);
