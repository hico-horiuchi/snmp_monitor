<% if @server %>
  location.reload( true )
<% else %>
  alert( '登録できませんでした。' )
<% end %>
