// atBat Selection
function atBatUpdate () {
    console.log($("#MainContent_atBatIndexField").val())
    makeServerRequest("update-at-bat", $("#MainContent_atBatIndexField").val());
}
function playerUpdate() {
    console.log($("#MainContent_playerIndexField").val())
    makeServerRequest("update-player", $("#MainContent_playerIndexField").val());
}

// Batstube and atBat List Box
function openBatsTube() {
    if($("#MainContent_atBatTable tbody tr.selected").length == 0)
	{
		alert("Please select an at-bat!");
	}
	else
	{
		batstubeWindow = window.open("batstube.aspx", '_blank');
		batstubeWindow.focus();
	}
}

$(document).on("click", "#showVideosButton", function(){
   openBatsTube(); 
});

$(document).on("click", "#playAllButton", function () {
    makeServerRequest("play-all", $("#MainContent_atBatTable tbody tr").length);
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
});
// Open Player Selection Modal
function openModal() {
    $("#showPlayerModal").modal();
}
function openPTeamModal() {
    $("#showPTeamModal").modal();
}
function openBTeamModal() {
    $("#showBTeamModal").modal();
}
function openDatesModal() {
    $("#showDatesModal").modal();
}
// Collapse Status Icon Behavior
$(document).on('shown.bs.collapse', '#selectPitcherPanel, #selectBatterPanel', function () {
    $(this).prev().find('.fa').removeClass("fa-caret-right").addClass("fa-caret-down");
});

$(document).on('hidden.bs.collapse', '#selectPitcherPanel, #selectBatterPanel', function () {
    $(this).prev().find('.fa').removeClass("fa-caret-down").addClass("fa-caret-right");
});

$(document).on("dblclick", "table.listbox-replacement-clickable tbody tr", function (event) {
    $(this).toggleClass("selected");
    console.log("DOUBLE!!");

    var attrs = getTableAttributes(this);
    setTableValues(this, attrs, true);

    if (attrs.selected && attrs.selectFn) {
        window[attrs.selectFn]();
    }

    if (attrs.dblclickFn && attrs.selected) {
        window[attrs.dblclickFn]();
    }

    if (attrs.selected && attrs.postback == "double") {
        __doPostBack();
    }

});

function setTableValues(target, attrs, double_clicked) {
    if (!attrs.multiple & attrs.selected) {
        $(target).siblings().removeClass("selected");
    }

    if (attrs.multiple & !double_clicked) {
        attrs.valField.val(attrs.values.join(';'));
        attrs.iField.val(attrs.indeces.join(';'));
    } else {
        attrs.valField.val(unescape(attrs.value));
        attrs.iField.val(attrs.index);
    }
}

// -----------------------------
// Server Asynchronious Callback 
// -----------------------------

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];
    
    if(splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }
    
    switch(actionFlag) {
      case "update-at-bat":   
        console.log("UPDATED!");
        break;
      default: 
        console.log("Default!");
    };	
};
// -----------------------------
