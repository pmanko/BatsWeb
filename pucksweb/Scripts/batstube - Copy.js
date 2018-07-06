var changePaths;
var myPlayer;
function pageLoad(sender, args) {
    myPlayer = videojs("main_vid");
    myPlayer.on('loadstart', function () {
        //console.log('yo');
        document.getElementById("lblStart").innerHTML = (myPlayer.src().substring((myPlayer.src().indexOf('=') + 1), myPlayer.src().indexOf(',')));
        document.getElementById("lblEnd").innerHTML = (myPlayer.src().substring((myPlayer.src().indexOf(',') + 1)));

    });
    //console.log(myPlayer.src());
    //console.log(myPlayer.src().indexOf('='));
    //console.log(myPlayer.src().substring((myPlayer.src().indexOf('=') + 1), myPlayer.src().indexOf(',')));
}

$(document).on("click", "#btnShare", function (event) {
    $("#shareModal").modal();
    makeServerRequest('share-playlist', videoPaths.join(';') + '~' + videoTitles.join(';'));
});

//$(document).on("click", "#btnSetStart", function (event) {
function setStart() {
    //makeServerRequest('set-start', videoPaths[getVidIndex()]+ ';' + myPlayer.currentTime() + '+' + videoPaths.join(';'));
    document.getElementById('lblStart').innerHTML = Math.round(myPlayer.currentTime());
    //pathsChanged = true;
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

//function moveUp() {
//    makeServerRequest('move-up', videoPaths[getVidIndex()] + '+' + videoPaths.join(';') + '~' + videoTitles.join(';'));
//    pathsChanged = true;
//}

//function moveDown() {
//    makeServerRequest('move-down', videoPaths[getVidIndex()] + '+' + videoPaths.join(';') + '~' + videoTitles.join(';'));
//    pathsChanged = true;
//}

//function removeClip() {
//    makeServerRequest('remove-clip', videoPaths[getVidIndex()] + '+' + videoPaths.join(';') + '~' + videoTitles.join(';'));
//    pathsChanged = true;
//}

function addClips() {
    console.log(document.getElementById("tbAdd").value);
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
        // $("#MainContent_tbShare").val(splitArgs[1]);
    }
    //else if (actionFlag == 'set-start') {
    //    videoPaths = splitArgs[1].split(';');
    //    console.log(videoPaths);
    //}
    //else if (actionFlag == 'set-end') {
    //    videoPaths = splitArgs[1].split(';');
    //    console.log(videoPaths);
    //}
    //else if (actionFlag == 'move-up') {
    //    videoPaths = splitArgs[1].substring(0, splitArgs[1].indexOf('~')).split(';');
    //    videoTitles = splitArgs[1].substring(splitArgs[1].indexOf('~') + 1).split(';');
    //    //console.log(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //    myPlayer.play();
    //    myPlayer.currentTime(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //}
    //else if (actionFlag == 'move-down') {
    //    videoPaths = splitArgs[1].substring(0, splitArgs[1].indexOf('~')).split(';');
    //    videoTitles = splitArgs[1].substring(splitArgs[1].indexOf('~') + 1).split(';');
    //    //console.log(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //    myPlayer.play();
    //    myPlayer.currentTime(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //}
    //else if (actionFlag == 'remove-clip') {
    //    videoPaths = splitArgs[1].substring(0, splitArgs[1].indexOf('~')).split(';');
    //    videoTitles = splitArgs[1].substring(splitArgs[1].indexOf('~') + 1).split(';');
    //    //console.log(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //    myPlayer.play();
    //    myPlayer.currentTime(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
    //}
    else if (actionFlag == 'add-clips') {
        console.log(splitArgs[1]);
        videoPaths = splitArgs[1].substring(0, splitArgs[1].indexOf('~')).split(';');
        videoTitles = splitArgs[1].substring(splitArgs[1].indexOf('~') + 1).split(';');
        myPlayer.play();
        myPlayer.currentTime(myPlayer.src().substring(myPlayer.src().indexOf(',') + 1));
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

