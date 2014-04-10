$(document).ready(function() {
  if($("#invitation_company_name").length > 0) {
    var autocomplete = $("#invitation_company_name").autocomplete({
      minLength: 3,
      source: function(request, response) {
        $.getJSON("/companies.json", {
          company: {
            name: $("#invitation_company_name").val()
          }
        }, response);
      },
    });

    autocomplete.data( "autocomplete" )._renderItem = function( ul, item ) {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a>" + item.name + "<br />" + item.creator_name + ' &lt;' + item.creator_email + '&gt;' + "</a>" )
        .appendTo(ul);
    };

    autocomplete.data("autocomplete")._renderMenu = function(ul, items) {
      var self = this;
      ul.append($("<li><strong>These similar companies already exist:</strong></li>"));
      ul.append("<br />");
      $.each( items, function( index, item ) {
        self._renderItem( ul, item );
      });
    };
  }
});

