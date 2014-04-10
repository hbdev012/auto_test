$(function() {
  // Get rid of the removal link on the first contact of each contact group.
  $('.contact-group .contacts .fields:first-child a.remove_nested_fields').remove();

  $('input.contact-group-name').live('change', function() {
    $(this).closest('fieldset').attr('id', $(this).val().toLowerCase().replace(' ', '-') + '-contact-group')
  });

  $('form').live('nested:fieldAdded', function(evt) {
    var field        = evt.field;
    var parent_field = $(field).parent().closest('.fields[data-nested-form-id]');

    if($(parent_field).length > 0) {
      var contact_group_id = $(parent_field).attr('data-nested-form-id');
      var inputs = $(field).find(':input');

      for(var i = 0; i < inputs.length; i++) {
        var name_partial = "[contact_groups_attributes][" + contact_group_id + "]";
alert(name_partial);
        $(inputs[i]).attr('name', $(inputs[i]).attr('name').replace(/\[contact_groups_attributes\]\[.*?\]/, name_partial));
      }
    }
  });
});
