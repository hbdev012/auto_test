$(document).ready(function() {
  displayAllotmentFields();
  toggleLateCheckoutFields();

  $('.allocation-types input:radio').live('change', function() { displayAllotmentFields(); });

  $('#accommodation_product_room_detail_late_check_out').live('change', function() { toggleLateCheckoutFields(); })
  if($('#accommodation_product_room_detail_amenities').length > 0) { $('#accommodation_product_room_detail_amenities').multiselect(); }

  // Weekend Rate "Same as other days"
  $('.weekend-rate').each(function() { displayWeekendRateFields($(this).find('.field > :checkbox')); });
  $('.weekend-rate > .field > :checkbox').live('change', function(evt) { displayWeekendRateFields(evt.target); });

  // Saty / Pay offers "Available"
  $('.stay-pay').each(function() { displayStayPayFields($(this).find('.field > :checkbox')); });
  $('.stay-pay > .field > :checkbox').live('change', function(evt) { displayStayPayFields(evt.target); });
});

function displayAllotmentFields() {
  var allotmentFields = $('.allotment-type-fields');

  if ($('#accommodation_product_allocation_type_allotment:checked').val() == 'allotment') {
    allotmentFields.show();
  } else {
    allotmentFields.hide();
  };
}

function displayStayPayFields(checkbox) {
  var stay_pay = $(checkbox).closest('.stay-pay');

  if($(checkbox).is(':checked')) {
    $(stay_pay).find('.add_nested_fields').show();
    $(checkbox).closest('.stay-pay').find('.stay-pay-offers :input').removeAttr('disabled');
  } else {
    $(stay_pay).find('.remove_nested_fields').trigger('click');
    $(stay_pay).find('.add_nested_fields').hide();
    $(stay_pay).find('.stay-pay-offers :input:visible').attr('disabled', 'disabled');
  }
}

function displayWeekendRateFields(checkbox) {
  var weekend_rate = $(checkbox).closest('.weekend-rate');

  if($(checkbox).is(':checked')) {
    $(weekend_rate).find('.remove_nested_fields').trigger('click');
    $(weekend_rate).find('.add_nested_fields').hide();
    $(weekend_rate).find('.weekend-rate-fields :input:visible').attr('disabled', 'disabled');
  } else {
    $(weekend_rate).find('.add_nested_fields').show();
    $(checkbox).closest('.weekend-rate').find('.weekend-rate-fields :input').removeAttr('disabled');
  }
}


function toggleLateCheckoutFields() {
  var lateCheckoutFields = $('.late-check-out .field :input');

  if ($('#accommodation_product_room_detail_late_check_out').is(':checked')) {
    lateCheckoutFields.attr('disabled', null)
  } else {
    lateCheckoutFields.attr('disabled', 'disabled')
  };
}
