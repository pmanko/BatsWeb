// Batstube - Open Window
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

// Open Player Selection Modal
function openModal() {
    $("#showPlayerModal").modal();
}


// Collapse Status Icon Behavior
$(document).on('shown.bs.collapse', '#selectPitcherPanel, #selectBatterPanel', function () {
    $(this).prev().find('.fa').removeClass("fa-caret-right").addClass("fa-caret-down");
});

$(document).on('hidden.bs.collapse', '#selectPitcherPanel, #selectBatterPanel', function () {
    $(this).prev().find('.fa').removeClass("fa-caret-down").addClass("fa-caret-right");
});