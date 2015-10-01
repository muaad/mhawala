$(function() {
	$('#example').dataTable( {
	    // "aaSorting": [[ 4, "desc" ]],
	    // "bSort": false
	    // { 'bSortable': false, 'aTargets': [ 1 ] }
	    // "sDom" : "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
	    //         "sPaginationType" : "bootstrap",
	    //         "oLanguage" : {
	    //             "sLengthMenu" : "_MENU_ records per page"
	    //         },
	    "aoColumnDefs" : [ {
	        "bSortable" : false,
	        "aTargets" : [ "no-sort" ]
	    } ]
	} );

	$('.datetimepicker').datetimepicker();

	$('#toggle_users').change(function(e) {
	  if (this.checked) {
	    $('.users_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.users_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-users').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    alert("You have not selected any users to be deleted.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	    $('#delete_users').val(users_array);
	    // contact_num = ("#users_table input:checked").length;
	    $('#delete_modal #lbl-msg').html('You are about to delete '+String(users_array.length)+' users');
	    $('#delete_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	if (window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("users") >= 0) {
		var userID = $('#user_id').attr('value')
		$.get('/users/'+ userID + '.json', function(data) {
			$('select[name="user[user_type]"] option[value="'+ data.user_type +'"]').attr('selected', 'selected');
			$("#is_admin").prop('checked', data.is_admin);
		})
	}

	$('#edit-user').click(function(){
	  if ($(".users_table input:checked").length < 1)
	  {
	    alert("You have not selected any user to be edited.");
	    return false;
	  }
	  else if ($(".users_table input:checked").length > 1)
	  {
	    alert("You have selected more than one user. You can only edit one user at a time.");
	    return false;
	  }
	  else
	  {
	    users_array = []
	    $(".users_table input:checked").each(function(){
	      users_array.push($(this).attr('value'))
	    });
	  	var id = users_array[0];
	  	document.location = '/users/' + id + '/edit'
	  }
	});
});