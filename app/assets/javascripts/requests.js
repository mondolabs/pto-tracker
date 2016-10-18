var REQUESTS = {
	onLoad: function(){  
		$('.datepicker').datepicker({
		  format: 'mm/dd/yyyy',
		  autoclose: true,
		  startDate: REQUESTS.getToday(),
		  daysOfWeekDisabled: [0,6],
		  todayButton: true
		});
	},
	getToday: function(){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1;
		var yyyy = today.getFullYear();
		if(dd<10) {
		    dd='0'+dd
		} 
		if(mm<10) {
		    mm='0'+mm
		} 
		today = mm+'/'+dd+'/'+yyyy;
		return today
	}
}	

$( document ).on('turbolinks:load', function() {
	REQUESTS.onLoad();
});