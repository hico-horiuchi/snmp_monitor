<% if @server %>
  location.reload( true )
<% else %>
  alert( 'Could not register server.' )
<% end %>
