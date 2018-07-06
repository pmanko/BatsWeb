var batstubeWindow;
// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
}

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];

    if (splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }

    if (actionFlag == 'park') {
        szoneClick(splitArgs[1]);
    }
};
// -----------------------------

$(document).on('click', '#parkImagebtn', function (events) {
    pos_x = events.offsetX ? (events.offsetX) : events.pageX - document.getElementById("parkImagebtn").offsetLeft;
    pos_y = events.offsetY ? (events.offsetY) : events.pageY - document.getElementById("parkImagebtn").offsetTop;
    makeServerRequest(pos_x, pos_y);
});

function szoneClick(result) {
    if (result = "play")
        openBatsTube();
    else
        alert(result);
}