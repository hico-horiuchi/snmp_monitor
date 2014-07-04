<% if @server %>
  location.href="/servers"
<% else %>
  locatiton.reload( true )
<% end %>
