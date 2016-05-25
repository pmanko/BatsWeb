var batstubeWindow;
// ezvideofull
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


function videoUpdate() {
    makeServerRequest("update-video", $("#MainContent_videoIndexField").val());
};

$(document).on("click", "#showVideosButton", function () {
    openBatsTube();
});
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
        case "update-video":
            console.log("UPDATED!");
            break;
        default:
        console.log("Default!");
    };
};
// -----------------------------

// -----------------------------
// Callback Functions
// -----------------------------
