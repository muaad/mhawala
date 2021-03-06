function userRecord(element, data) {
	var userType = element.split("_")[0];
	$(element).each(function() {
	   var elem = $(this);

	   // Save current value of element
	   elem.data('oldVal', elem.val());

	   // Look for changes in the value
	   elem.bind("propertychange change click keyup input paste", function(event){
	      // If value has changed...
	      if (elem.data('oldVal') != elem.val()) {
	       // Updated stored value
	       var nameField = $(userType + '_name');
	       var emailField = $(userType + '_email');
	       var sentFromField = $('#payment_sent_from');
	       var sentToField = $('#payment_sent_to');
	       nameField.val("");
	       emailField.val("");
	       elem.data('oldVal', elem.val());
	       var phone = elem.data('oldVal');

	       for (var i = data.length - 1; i >= 0; i--) {
	       	if (data[i].phone_number === phone){
	       		record = data[i];
	       		if (record != null) {
	       			var nameField = $(userType + '_name');
	       			var emailField = $(userType + '_email');
			        var sentFromField = $('#payment_sent_from');
			        var sentToField = $('#payment_sent_to');
	       			nameField.val(record.name);
	       			emailField.val(record.email);
	       			if (userType === "#sender") {
	       				sentFromField.val(record.last_location);
	       			} else{
	       				sentToField.val(record.last_location);
	       			};
	       		}
	       	}
	       };
	     }
	   });
	 });
}

$(function() {
	$('#toggle_payments').change(function(e) {
	  if (this.checked) {
	    $('.payments_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.payments_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("payments") >= 0
	if (window.location.pathname === "/payments/new" || editPage) {
		$.get('/users.json', function(data) {
			userRecord('#sender_phone_number', data);
			userRecord('#recipient_phone_number', data);
		});
	}

	$('#delete-payments').click(function(){
	  if ($(".payments_table input:checked").length < 1)
	  {
	    alert("You have not selected any payments to be deleted.");
	    return false;
	  }
	  else
	  {
	    payments_array = []
	    $(".payments_table input:checked").each(function(){
	      payments_array.push($(this).attr('value'))
	    });
	    $('#delete_payments').val(payments_array);
	    // contact_num = ("#payments_table input:checked").length;
	    $('#delete_payment_modal #lbl-msg').html('You are about to delete '+String(payments_array.length)+' payments');
	    $('#delete_payment_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-payment').click(function(){
	  if ($(".payments_table input:checked").length < 1)
	  {
	    alert("You have not selected any payment to be edited.");
	    return false;
	  }
	  else if ($(".payments_table input:checked").length > 1)
	  {
	    alert("You have selected more than one payment. You can only edit one payment at a time.");
	    return false;
	  }
	  else
	  {
	    payments_array = []
	    $(".payments_table input:checked").each(function(){
	      payments_array.push($(this).attr('value'))
	    });
	  	var id = payments_array[0];
	  	document.location = '/payments/' + id + '/edit'
	  }
	});

	$("#withdrawal_currency").change(function() {
		if ($("#from_currency").val() != $("#withdrawal_currency").val()) {
			var fromCurrency = $("#from_currency").val();
			var toCurrency = $("#withdrawal_currency").val();
			var toCity = $("#city").val();
      $.ajax({
        type: "GET",
        url: '/currencies/' + fromCurrency + '/exchange?to_currency=' + toCurrency + '&amount=' + $("#amount").val() + '&city=' + toCity,
        dataType: 'json',
        success: function(data, textStatus, jqXhr) {
        	var converted_value = data.converted_value;
        	if (converted_value.startsWith("You haven't set the exchange rate for")) {
        		converted_value += " <a class='btn btn-sm btn-success' href='/exchange_rates/new?currency_one=" + fromCurrency + "&currency_two=" + toCurrency + "&city=" + toCity + "'><div class='fa fa-plus'> Set it now here."
        	};
          $("#converted-value").html(converted_value);
        }
      });
    }
    else {
    	$("#converted-value").html($("#amount").val());
    }
	})

	$('#printReceipt').click(function(){
	     $(".receipt").printThis();
	});
});