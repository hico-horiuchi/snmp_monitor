<% if @server %>
  location.reload( true )
<% else %>
  alert( '更新できませんでした。' )
<% end %>
