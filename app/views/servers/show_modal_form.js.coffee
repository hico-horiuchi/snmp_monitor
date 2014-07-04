$( '.modal-form' ).html( '<%= escape_javascript( render partial: 'servers/form' ) %>' )
$( '#modal-form' ).modal()
