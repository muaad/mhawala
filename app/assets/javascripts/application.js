// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require jquery.infinite-pages
//= require jquery-1.11.1.min
//= require jquery_ujs
//= require arjuna
//= require tasks
//= require users
//= require payments
//= require exchange_rates
//= require jquery.editabletable
//= require moment.min
//= require jquery-ui.custom.min
//= require fullcalendar.min
//= require jquery.checkboxes
//= require jquery.datetimepicker
// require dropzone
//= require owl-carousel-plugin
//= require owl-carousel
//= require jquery.flot.min
//= require jquery.dataTables
//= require DT_bootstrap
//= require jquery.flot.tooltip.min
//= require jquery.flot.spline
//= require jquery.flot.pie.min
//= require jquery.flot.resize
//= require jquery.flot.grow
//= require jquery.print
//= require xcharts.min
//= require d3.v3.min
//= require cal-heatmap.min
// require underscore.1.5.2.min
//= require raphael-min
//= require morris.min
//= require morris-script
// require_tree .
//= require_self

$(function() {
	$('#example').dataTable( {
	    "aaSorting": [[ 4, "desc" ]]
	} );

	$('.datetimepicker').datetimepicker();
})