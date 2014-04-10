$(document).ready(function() {
  if($("#company_name").length > 0) {
    var autocomplete = $("#company_name").autocomplete({
      minLength: 3,
      source: function(request, response) {
        $.getJSON("/companies.json", {
          company: {
            country: $("#company_country").val(),
            name:    $("#company_name").val(),
            _type:   $("input[name='company[_type]']:checked").val()
          }
        }, response);
      },

      search: function(event, ui) {
        $('div#company-results').html('')
      },

      select: function(event, ui) {
        // Do we have a selectable menu item?
        if(typeof(ui.item) != 'undefined') {
          var selected_company = $("<div id='selected-company'>");
          var deselect_link    = $('<a>This is not my company</a>');

          deselect_link.click(function() {
            $('#company_id').val('');
            $('#company_name').val('');
            $("#company-form").show();

            $('#selected-company').remove();
          });

          selected_company.append('<p>' + ui.item.name + "<br />" + ui.item.country + '</p>');
          selected_company.append(deselect_link);

          $("#company-form").hide().after(selected_company);
          $('#company_id').val(ui.item._id)
        } else {
          return false;
        }
      }
    });

    autocomplete.data( "autocomplete" )._renderItem = function( ul, item ) {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a>" + item.name + ", " + item.country + "</a>" )
        .appendTo(ul);
    };

    autocomplete.data("autocomplete")._renderMenu = function(ul, items) {
      var self = this;
      var none_of_these_is_link = $("<a id='reject-companies'>No, none of these are my company</a>")
      $.each( items, function( index, item ) {
        self._renderItem( ul, item );
      });
      ul.append("<br />");
      ul.append($("<li>").append(none_of_these_is_link));
    };
  }
});

