var batstubeWindow;
// Game Selection
// * For now, uses traditional post-backs
//function gamesUpdate() {
//    console.log($("#MainContent_gamesIndexField").val())
//    makeServerRequest("update-game", $("#MainContent_gamesIndexField").val());
//}

// -----------------------------
// Table-Bound Functions
// -----------------------------

// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
	batstubeWindow.focus();
}

function openAtBatDetail() {
    batstubeWindow = window.open("summaryatbatdetail.aspx", '_blank');
    batstubeWindow.focus();
}

// Inning Row Selected
//      On a single click, data is set --> code behind, so that all the vars and video paths are set
//      On a double click, batstube is opened
function inningRowSelected() {
    makeServerRequest("inning-selected", $("#MainContent_inningSummaryIndexField").val());
};

// -----------------------------
// Event Bindings
// -----------------------------


// -----------------------------
// Server Asynchronious Callback
//  * Calls to makeServerRequest 
//  * are handled in GetServerData 
//  * after server callback is 
//  * finished, using same action
//  * flag
// -----------------------------

// Play Home


// Play Vis
// Play Full
// From Selected
$(document).on('click', '.btn-async-request', function (events) {
    makeServerRequest($(this).data("actionFlag"));
    openBatsTube();
});

// Show Detail
$(document).on('click', '#atBatDetail', function (events) {
    makeServerRequest($(this).data("actionFlag"));
    if ($("#MainContent_inningSummaryIndexField").val()) {
        openAtBatDetail();
    }
    
});

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
      default:
        console.log("Default!");
    };
};
// -----------------------------
