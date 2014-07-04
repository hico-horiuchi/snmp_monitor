$( '.modal-form' ).html( '<%= escape_javascript( render partial: 'servers/delete' ) %>' )
$( '#modal-form' ).modal()
