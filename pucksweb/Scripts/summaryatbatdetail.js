$(function() {
    makeServerRequest('reload-pitch-list')
});

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

    if(splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }

    if (actionFlag == 'reload-pitch-list') {
        populateListboxTable("#pitchListTable", splitArgs[1])
    }
    else if (actionFlag == 'szone') {
        szoneClick(splitArgs[1]);
    }
};
// -----------------------------

$(document).on("click", "#playAllButton", function () {
    makeServerRequest("play-all");
    openBatsTube();
});

$(document).on('click', '#szoneImagebtn', function (events) {
    pos_x = events.offsetX ? (events.offsetX) : events.pageX - document.getElementById("szoneImagebtn").offsetLeft;
    pos_y = events.offsetY ? (events.offsetY) : events.pageY - document.getElementById("szoneImagebtn").offsetTop;
    makeServerRequest(pos_x, pos_y);
});

function szoneClick(result) {
    if (result = "play")
        openBatsTube();
    else
        alert(result);
}
