$(document).on("click", "#show_videos", function (event) {
	if($("#MainContent_ListBox1").val() == null)
	{
		alert("Please select an at-bat");
	}
	else
	{
		batstubeWindow = window.open("batstube.aspx", '_blank');
		batstubeWindow.focus();
	}

    event.preventDefault();
});

// $(document).on("click", "#click_test", function(event) {
// 	alert("HI");
// 	console.log("Sup");
// 	$(this).closest(".panel").parent().hide();
// });