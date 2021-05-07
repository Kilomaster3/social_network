(function() {
  let change_visibility;

  change_visibility = function(status) {
    console.log(status);
    if (status === "Publish via") {
      return $(".published-field").show();
    } else {
      return $(".published-field").hide();
    }
  };

  $(function() {
    change_visibility($("#post_status :selected").text());
    $("#post_status").on("change", function(e) {
      return change_visibility($(this).find(":selected").text());
    });
  });

}).call(this);
