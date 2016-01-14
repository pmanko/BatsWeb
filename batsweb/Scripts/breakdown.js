$(function() {
	if(showModal){
	 $("#changeSelectionModal").modal('show');
	 };
	
});

$(document).on("click", "#oneClickDate button", function(event) {
	console.log($(this).data('dateFlag'));

	CallServer($(this).data('dateFlag'), "");

});

function GetServerData(arg, context) {

	if(arg == "ALL") {
		$("#MainContent_allEndRadioButton").prop("checked", true);
		$("#MainContent_allStartRadioButton").prop("checked", true);
	}
	else {
	
		var dates = arg.split(";");
		console.log(dates);

		$("#MainContent_startDateTextBox").val(dates[0]);
		$("#MainContent_startDateRadioButton").prop("checked", true);

		$("#MainContent_endDateTextBox").val(dates[1]);
		$("#MainContent_endDateRadioButton").prop("checked", true);

	}
	$("#oneClickDateModal").modal('hide');
	
};