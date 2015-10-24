function setEditable() {
  $('#example').editableTableWidget(); 
  var elem = null;
  $('#example td.editable').on('change', function(evt, newValue) {
    var token = $('meta[name=csrf-token]').attr("content");
    var id = $(this).data('id');
    var url = "/exchange_rates/" + id;
    elem = $(this);
    var data = {};

    if ( elem.hasClass( "buying" ) ) {
    	data = { exchange_rate: { buying: newValue }, _method:'put', authenticity_token: token}
    }
    else if ( elem.hasClass( "selling" ) ) {
    	data = { exchange_rate: { selling: newValue }, _method:'put', authenticity_token: token}
    };

    $.ajax({
      type: "PUT",
      url: url,
      dataType: 'json',
      data: data,
      success: function(data, textStatus, jqXhr) {
        console.log("Buying ", data.buying)
        console.log("Selling ", data.selling)
      }
    });
  });
}

$(function() {
	$('#toggle_exchange_rates').change(function(e) {
	  if (this.checked) {
	    $('.exchange_rates_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.exchange_rates_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-exchange_rates').click(function(){
	  if ($(".exchange_rates_table input:checked").length < 1)
	  {
	    alert("You have not selected any exchange_rates to be deleted.");
	    return false;
	  }
	  else
	  {
	    exchange_rates_array = []
	    $(".exchange_rates_table input:checked").each(function(){
	      exchange_rates_array.push($(this).attr('value'))
	    });
	    $('#delete_exchange_rates').val(exchange_rates_array);
	    // contact_num = ("#exchange_rates_table input:checked").length;
	    $('#delete_exchange_rate_modal #lbl-msg').html('You are about to delete '+String(exchange_rates_array.length)+' exchange rates');
	    $('#delete_exchange_rate_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-exchange_rate').click(function(){
	  if ($(".exchange_rates_table input:checked").length < 1)
	  {
	    alert("You have not selected any exchange_rate to be edited.");
	    return false;
	  }
	  else if ($(".exchange_rates_table input:checked").length > 1)
	  {
	    alert("You have selected more than one exchange rate. You can only edit one exchange rate at a time.");
	    return false;
	  }
	  else
	  {
	    exchange_rates_array = []
	    $(".exchange_rates_table input:checked").each(function(){
	      exchange_rates_array.push($(this).attr('value'))
	    });
	  	var id = exchange_rates_array[0];
	  	document.location = '/exchange_rates/' + id + '/edit'
	  }
	});

	setEditable();
});