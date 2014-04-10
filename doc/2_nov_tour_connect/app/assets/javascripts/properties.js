$(document).ready(function() {
  // Ensure field elements have data attribute for double-nested forms
  if ($('#contact-groups').length > 0) {
    var fields = $('#contact-groups').children('.fields')

    for(var i = 0; i < fields.length; i++) { 
      $(fields[i]).attr('data-nested-form-id', i); 
    }
  }

  $('.use-corporate > :input[type=checkbox]').live('change', function() {
    $(this).closest('.corporate-information-fields').find('fieldset').slideToggle();
  });

  $('.use-corporate > :input[type=checkbox]:not(:checked)').each(function() {
    $(this).closest('.corporate-information-fields').find('fieldset').show();
  });

  if($('#accommodation_amenities').length > 0) {
    $('#accommodation_amenities').multiselect();
  }

  $('#add-amenity').live('ajax:before', function(event, elements){
    var newAmenity = $('#new_amenity').val();

    var params = $.param({ name: newAmenity });
    var base_url = $(this).attr('href').split('?')[0];

    $(this).attr('href', base_url + '?' + params);
    $('#new_amenity').val('');
  });

  // Percent/Amount select box toggle
  $('.percent-amount-selector').each(function() { display_currency($(this).children('select')); });
  $('.percent-amount-selector > select').live('change', function(evt) { display_currency(evt.target); });

  // Combinable offer checkbox enables text area
  $('.combinable-offer').each(function() { display_combinable_textarea($(this).children('input[type=checkbox]')); });
  $('.combinable-offer').live('change', function(evt) { display_combinable_textarea(evt.target); });

  // Ensure infant/child policy ages coincide.
  $('#infant_age_to').live('change', function(evt) {
    $('#children_age_from').val($(evt.target).val());
  });

  // If there are unopened nested fields, open them.
  $("form a.add_nested_fields").closest('form').bind('nested:fieldAdded', function(event) {
    $(event.field).find('a.add_nested_fields').click();
  });

  // Display appropriate rate-type field
  $('.bonus-offer-rate-type').each(function() { display_rate_type_field($(this).children('select')); });
  $('.bonus-offer-rate-type').live('change', function(evt) { display_rate_type_field(evt.target); });
  // Display appropriate rate field
  $('.bonus-offer-rate').each(function() { display_rate_field($(this).children('select')); });
  $('.bonus-offer-rate').live('change', function(evt) { display_rate_field(evt.target); });

  build_subnav();

  if($('.seasons .gap').length > 0) {
    $('#gap-message').show();
  };

});

function build_subnav() {
  if($('#property-nav').length > 0) {
    var current_step = $('#step').val();
    var nav_item = $('#property-nav').children('li#' + current_step + '_nav');

    var subnav = $("<ul>");
    $('.content > form > h2, .content > form div.corporate-information-fields > h2').each(function() {
      var subnav_item = $("<li><a href=\"#" + $(this).attr('id') + "\">" + $(this).children('.header-text').html() + "</a><div class=\"status not-filled\"></div></li>");
      $(subnav).append(subnav_item);
    });

    $(nav_item).append(subnav);
  }
}

function display_combinable_textarea(checkbox) {
  if($(checkbox).is(':checked')) {
    $(checkbox).siblings('textarea').removeAttr('disabled');
  } else {
    $(checkbox).siblings('textarea').attr('disabled', 'disabled');
  }
}

function display_currency(select) {
  if($(select).val() == 'percentage') {
    $(select).siblings('.type-percent').show();
    $(select).siblings('.type-currency').hide();
  } else {
    $(select).siblings('.type-percent').hide();
    $(select).siblings('.type-currency').show();
  }
}

function display_rate_type_field(select) {
  if($(select).val() == 'Per night') {
    $(select).siblings('.per-number-of-guests').hide();
  } else {
    $(select).siblings('.per-number-of-guests').show();
  }
}

function display_rate_field(select) {
  if($(select).val() == 'Discount') {
    $(select).siblings('.rate-amount').hide();
    $(select).siblings('.rate-discount').show();
  } else if ($(select).val() == 'Rate Amount'){
    $(select).siblings('.rate-discount').hide();
    $(select).siblings('.rate-amount').show();
  } else {
    $(select).siblings('.rate-amount').hide();
    $(select).siblings('.rate-discount').hide();
  }
}
