$(document).ready(function() {

  $('.non-accommodation-product-season-select').live('change', function() {
    var self = this;

    $.get($(this).attr('data-url'), { season_id: $(this).children(':selected').val()}, function(data) {
      var content = $(data).find('#product-rate-group-inner').html();
      var blueprints = $(data).siblings('div');

      var nested_form_id = $(self).closest('[data-nested-form-id]').attr('data-nested-form-id');

      if(typeof(nested_form_id) !== "undefined") {
        content = content.replace(/\[0\]/g, '[' + nested_form_id + ']');
      }

      $(self).closest('fieldset').siblings('.product-rate-group').html(content);
      $('body').append(blueprints);
      display_meal_details_textarea($('.meal-details input[type=checkbox]'))
    });
  });

  $('.departs-on input:radio:checked').closest('.departs-on').find('.departs-on-values').show();
  $('.departs-on input:radio').live('change', function() {
    var parent = $(this).closest('.departs-on');

    $('.departs-on-values').hide('fast', function() {
      $(parent).find('.departs-on-values').show();
    });
  });

  // Combinable offer checkbox enables text area
  $('.meal-details').each(function() { display_meal_details_textarea($(this).find('input[type=checkbox]')); });
  $('.meal-details').live('change', function(evt) { display_meal_details_textarea(evt.target); });

});

function display_meal_details_textarea(checkbox) {
  if($(checkbox).is(':checked')) {
    $(checkbox).closest('.meal-details').find('textarea').removeAttr('disabled');
  } else {
    $(checkbox).closest('.meal-details').find('textarea').attr('disabled', 'disabled');
  }
}
