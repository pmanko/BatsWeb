var batstubeWindow;
var tabOpenTop;
var tabOpenBottom;
var mouseIsDown = false;
var startX, endX, startY, endY;
var rectX, rectY, rectH, rectW;
// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
}

function pageLoad(sender, args) {
    canvas = document.getElementById("canvas");
    context = canvas.getContext("2d");
    canvas.addEventListener("mousedown", mouseDown, false);
    canvas.addEventListener("mousemove", mouseXY, false);
    canvas.addEventListener("mouseup", mouseUp, false);
    canvas.addEventListener("touchstart", touchDown, false);
    canvas.addEventListener("touchmove", touchXY, false);
    canvas.addEventListener("touchend", touchUp, false);
    canvas.addEventListener("touchcancel", touchUp, false);
    d = new Date();
    $("#rinkImagebtn").attr("src", "goalieAnalysisRink.aspx?" + d.getTime());
}
// play Selection
function playUpdate() {
    //  console.log("playindexfield: " + $("#MainContent_playIndexField").val())
    makeServerRequest("update-play", $("#MainContent_playIndexField").val());
}
function playUpdateDblclick() {
    //  console.log("playindexfield: " + $("#MainContent_playIndexField").val())
    makeServerRequest("update-play-dblclick", $("#MainContent_playIndexField").val());
}

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];
    if (splitArgs.length > 2) {
        batstubeWindow.close();
        alert(splitArgs[2]);
        return;
    }

    if (actionFlag == 'od') {
        oneClickDateSelectionSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'pt' || actionFlag == 'ot') {
        teamSelectionSuccess(splitArgs[1], actionFlag);
    }
    else if (actionFlag == 'oo' || actionFlag == 'oe' || actionFlag == 'oa' || actionFlag == 'om' || actionFlag == 'ow' || actionFlag == 'oc' || actionFlag == 'op') {
        opponentAllSelectionSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'lr') {
        playerListRefreshSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'tt' || actionFlag == 'tr') {
        $("#MainContent_previousSzoneImage").attr("src", "/breakdownpreviousszone.aspx?timestamp=" + new Date().getTime());
    }
    else if (actionFlag == 'nt' || actionFlag == 'nr') {
        $("#MainContent_nextSzoneImage").attr("src", "/breakdownnextszone.aspx?timestamp=" + new Date().getTime());
    }
    else if (actionFlag == 'pb') {
        openPreviousModalSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'nb') {
        openNextModalSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'po') {
        playerSelectedSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'shot-loc') {
        shotLocations(splitArgs[1]);
    }
    //else if (actionFlag == 'team-sl' || actionFlag == 'ind-sl' || actionFlag == 'opp-sl') {
    //    showSL();
    //}
};
// -----------------------------

$(document).on("click", "#btnOppAll,#btnEastConf,#btnWestConf,#btnEastAtl,#btnWestCent,#btnEastMetro,#btnWestPac", function (event) {
    // Selects all pitchers
    var requestFlag = "o" + $(this).data("playerType");
    makeServerRequest(requestFlag, "");
});


// One-Click Dates
$(document).on("click", "#oneClickDate button", function (event) {
    // Calls server with one-click date parameter and request type flag
    // console.log($(this).data('dateFlag'));
    var requestFlag = "od";
    makeServerRequest(requestFlag, $(this).data('dateFlag'));

});

function oneClickDateSelectionSuccess(dateRange) {
    if (dateRange == "ALL") {
        $("#MainContent_rbEndAll").prop("checked", true);
        $("#MainContent_rbStartAll").prop("checked", true);
    }
    else {
        var dates = dateRange.split(";");
        $("#MainContent_startDateTextBox").val(dates[0]);
        $("#MainContent_rbStartDate").prop("checked", true);
        $("#MainContent_endDateTextBox").val(dates[1]);
        $("#MainContent_rbEndDate").prop("checked", true);
    }
}

// Team Selection
$(document).on("click", "#btnTeamSelectionOK", function (event) {
    // Calls server with one-click date parameter and request type flag
    // console.log($(this).data('dateFlag'));
    //var requestFlag = "";
    var modalType = $("#teamSelectionModal #modalType").text();

    // console.log(modalType);
    //console.log($('#MainContent_pTeamDropDownList :selected').text());

    if (modalType == "player")
        requestFlag = 'pt';
    else if (modalType == "opponent")
        requestFlag = 'ot';

    makeServerRequest(requestFlag, $('#MainContent_ddTeam :selected').text());
});

$(document).on('show.bs.modal', '#teamSelectionModal', function (event) {
    // Set Modal Type - either pitcher or batter
    var button = $(event.relatedTarget); // Button that triggered the modal
    var type = button.data('modalType'); // Extract info from data-* attributes
    var modal = $(this);
    modal.find('#modalType').text(type);
})

// Player Selection
$(document).on('change', "#MainContent_ddPlayerTeam", function (event) {
    makeServerRequest('lr', $(this).val())
});

$(document).on('show.bs.modal', '#playerSelectionModal', function (event) {
    // Set Modal Type - either pitcher or batter
    $("#MainContent_locatePlayerTextBox").val("");

    makeServerRequest('sp');

    makeServerRequest('lr', $("#MainContent_ddPlayerTeam").val())

});

$(document).on('click', "#btnSelectPlayerOK", function (event) {
    var selectedPlayerInfo;
    // Decide which player value to select
    if (!$("#MainContent_playerValueField").val()) {
        selectedPlayerInfo = "located;" + $("#MainContent_locatePlayerTextBox").val()
    } else {
        var pIndex = parseInt($("#MainContent_playerIndexField").val()) + 1
        selectedPlayerInfo = "selected;" + pIndex + ',' + $("#MainContent_playerValueField").val()
    }
    makeServerRequest("po", selectedPlayerInfo);
    $("#MainContent_playerValueField").val("");
});

// Success Callbacks
function teamSelectionSuccess(selectedTeam, typeFlag) {
    //console.log("CLOSE: " + selectedTeam);
    if (typeFlag == 'pt')
        $("#MainContent_lblCurrentPlayer").val(selectedTeam);
    else
        $("#MainContent_lblCurrentOpponent").val(selectedTeam);
    $("#teamSelectionModal").modal("hide");
}

function opponentAllSelectionSuccess(opponentVal) {
    $("#MainContent_lblCurrentOpponent").val(opponentVal);
}

function playerListRefreshSuccess(players) {
    // console.log(players.split(';'))
    $("#playerTable tbody").empty();
    $.each(players.split(';'), function (i, playerString) {
        //    var splitPlayer = playerString.split(',');
        //    if (splitPlayer.length > 1) {
        $("#playerTable tbody").append('<tr><td></td></tr>');
        $("#playerTable tbody tr:last td:first").html(unescape(playerString));
        //         $("#playerTable tbody tr:last td:first").data("val", splitPlayer[0]);
        //    }

    });


}

function playerSelectedSuccess(player) {
    $("#MainContent_lblCurrentPlayer").val(player);

    $("#playerSelectionModal").modal('hide');
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

$(document).on('click', '.btn-async-request', function (events) {
    console.log($(this).data("actionFlag"));
    if ($(this).data("actionFlag") == 'play-sel')
        makeServerRequest("play-rink", rectX + "," + rectY + ',' + rectW + ',' + rectH);
    else
        makeServerRequest($(this).data("actionFlag"));
    openBatsTube();
});

function playField(num) {
    makeServerRequest("play-field", num);
    openBatsTube();
}

function selectDate(flag) {
    var rb;
    if (flag == "S") {
        rb = document.getElementById('MainContent_rbStartDate');
        rb.checked = true;
    }
    else if (flag == "D") {
        rb = document.getElementById('MainContent_rbEndDate');
        rb.checked = true;
    }
}

//$("#MainContent_locatePlayerTextBox").keyup(function (event) {
//    console.log('enter');
//    if (event.keyCode == 13) {
//        console.log('enter');
//       // $("#id_of_button").click();
//    }
//});

function EnterEvent(e) {
    if (e.keyCode == 13) {
        console.log('enter');
        return false;
    }
}

$(document).on("click", "#changeClose", function (event) {
    $('#changeSelectionCollapse').collapse('hide');
});

function openChances() {
    $("#chancesModal").modal('show');
}

$(document).on("click", "#btnTopLeft", function (event) {
    makeServerRequest("top-left");
    openBatsTube();
});

$(document).on("click", "#btnTopCenter", function (event) {
    makeServerRequest("top-center");
    openBatsTube();
});

$(document).on("click", "#btnTopRight", function (event) {
    makeServerRequest("top-right");
    openBatsTube();
});

$(document).on("click", "#btnBotLeft", function (event) {
    makeServerRequest("bottom-left");
    openBatsTube();
});

$(document).on("click", "#btnBotCenter", function (event) {
    makeServerRequest("bottom-center");
    openBatsTube();
});

$(document).on("click", "#btnBotRight", function (event) {
    makeServerRequest("bottom-right");
    openBatsTube();
});

function mouseDown(eve) {
    mouseIsDown = true;
    var pos = getMousePos(canvas, eve);
    startX = endX = pos.x;
    startY = endY = pos.y;
    drawSquare();
}

function touchDown(eve) {
    mouseIsDown = true;
    if (!e)
        var e = event;
    e.preventDefault();
    var rect = canvas.getBoundingClientRect();
    //startX = endX = Math.round(e.targetTouches[0].pageX - oWrapper.offsetLeft);
    startX = endX = Math.round(e.targetTouches[0].pageX - (rect.left + window.pageXOffset));
    //startY = endY = Math.round(e.targetTouches[0].pageY - oWrapper.offsetTop);
    startY = endY = Math.round(e.targetTouches[0].pageY - (rect.top + window.pageYOffset));
    drawSquare();
}

function touchXY(e) {
    if (mouseIsDown) {
        if (!e)
            var e = event;
        e.preventDefault();
        var rect = canvas.getBoundingClientRect();
        //endX = Math.round(e.targetTouches[0].pageX - oWrapper.offsetLeft);
        endX = Math.round(e.targetTouches[0].pageX - (rect.left + window.pageXOffset));
        //endY = Math.round(e.targetTouches[0].pageY - oWrapper.offsetTop);
        endY = Math.round(e.targetTouches[0].pageY - (rect.top + window.pageYOffset));
        drawSquare();
    }
}

function touchUp() {
   //$("#MainContent_lblLocation").val(oWrapper.offsetLeft + ';' + oWrapper.offsetTop);
    mouseIsDown = false;
    if (startX == endX && startY == endY) {
        makeServerRequest("play-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        openBatsTube();
    }
    else {
        makeServerRequest("store-rink", rectX + "," + rectY + ',' + rectW + ',' + rectH);
    }
}

function mouseXY(eve) {
    if (mouseIsDown) {
        var pos = getMousePos(canvas, eve);
        endX = pos.x;
        endY = pos.y;
        drawSquare();
    }
}

function mouseUp(eve) {
    mouseIsDown = false;
    var pos = getMousePos(canvas, eve);
    endX = pos.x;
    endY = pos.y;
    if (startX == endX && startY == endY) {
        makeServerRequest("play-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        openBatsTube();
    }
    else {
        drawSquare();
        makeServerRequest("store-rink", rectX + "," + rectY + ',' + rectW + ',' + rectH);
    }
}

function drawSquare() {
    // creating a square
    var w = endX - startX;
    var h = endY - startY;
    var offsetX = (w < 0) ? w : 0;
    var offsetY = (h < 0) ? h : 0;
    var width = Math.abs(w);
    var height = Math.abs(h);
    context.clearRect(0, 0, canvas.width, canvas.height);

    context.beginPath();
    context.rect(startX + offsetX, startY + offsetY, width, height);
    rectX = Math.round(startX + offsetX);
    rectY = Math.round(startY + offsetY);
    rectW = width;
    rectH = height;
    context.lineWidth = 1;
    context.strokeStyle = 'blue';
    context.stroke();

}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    //console.log(evt.clientX + "," + evt.clientY);
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}

$(document).on("click", "#btnRbdSprayChart", function (event) {
    d = new Date();
    $("#rbdImagebtn").attr("src", "goalieAnalysisRbdRink.aspx?" + d.getTime());
    $("#rbdModal").modal('show');
});

function hideShotLines(cb) {
    makeServerRequest('cb-hide', cb.checked);
    d = new Date();
    $("#rbdImagebtn").attr("src", "goalieAnalysisRbdRink.aspx?" + d.getTime());
}