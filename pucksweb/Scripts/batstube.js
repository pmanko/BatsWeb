var myPlayer;
function pageLoad(sender, args) {
    if (window.navigator.userAgent.indexOf("Edge") > -1)
        console.log('edge');
    myPlayer = videojs("main_vid");
    myPlayer.on('loadstart', function () {
        document.getElementById("lblStart").innerHTML = (myPlayer.src().substring((myPlayer.src().indexOf('=') + 1), myPlayer.src().indexOf(',')));
        document.getElementById("lblEnd").innerHTML = (myPlayer.src().substring((myPlayer.src().indexOf(',') + 1)));
    });
}

$(document).on("click", "#btnShare", function (event) {
    $("#shareModal").modal();
    makeServerRequest('share-playlist', videoPaths.join(';') + '~' + videoTitles.join(';'));
});

function setStart() {
    document.getElementById('lblStart').innerHTML = Math.round(myPlayer.currentTime());
}

function setEnd() {
    document.getElementById('lblEnd').innerHTML = Math.round(myPlayer.currentTime());
}

function getVidIndex() {
    var doc = document.getElementById('tester');
    for (var i = 0; i < doc.children.length; i++) {
        if (doc.children[i].className.includes("active")) {
            return i;
            break;
        }
    }
}

function addClips() {
    makeServerRequest('add-clips', document.getElementById("tbAdd").value + '+' + videoPaths.join(';') + '~' + videoTitles.join(';'));
    pathsChanged = true;
}

function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];

    if (splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }

    if (actionFlag == 'share-playlist') {
        document.getElementById('tbShare').value = splitArgs[1];
    }
    else if (actionFlag == 'add-clips') {
        if (splitArgs[1] == "ERROR") {
            alert("No playlist exists with that name")
        }
        else {
            videoPaths = splitArgs[1].substring(0, splitArgs[1].indexOf('~')).split(';');
            videoTitles = splitArgs[1].substring(splitArgs[1].indexOf('~') + 1).split(';');
            myPlayer.play();
            myPlayer.pause();
            myPlayer.currentTime(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
        }
    }
}

$(function () {
    $('#addClipsModal').on('shown.bs.modal', function (e) {
        preventKeys = true;
    });
});

$(function () {
    $('#addClipsModal').on('hidden.bs.modal', function (e) {
        preventKeys = false;
    });
});

