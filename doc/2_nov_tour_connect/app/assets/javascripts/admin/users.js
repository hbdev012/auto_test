$(document).ready(function() {
  $('.reject-button').click(function(evt) {
    evt.preventDefault();

    var dialog = $("<div id=\"dialog\" title=\"Provide a reason for rejection (Optional)\"><form><div><textarea rows=\"8\" name=\"reason\" id=\"reason\" cols=\"36\"></textarea></div></form><p>Are you sure you want to reject this user? This cannot be undone. Click OK to continue.</p></div>");

    $(dialog).dialog({
      autoOpen: true,
      buttons: {
        OK: function() {
          // Submit the form with the rejection.
          var form = $(evt.target).parents('form');
          $.ajax({
            data: $.merge(form.serializeArray(), $(this).find('form').serializeArray()),
            dataType: 'script',
            type: 'POST',
            url: form.attr('action')
          });
        },
        Cancel: function() {
          $(this).dialog("close");
        }
      },
      height: 230,
      modal: true,
      width: 300
    });
  });
});
