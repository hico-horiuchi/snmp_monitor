<% if @server %>
  location.reload( true )
<% else %>
  alert( 'Could not save changes.' )
<% end %>
