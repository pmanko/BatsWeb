var batstubeWindow;
var closeToi = false;
var ddFlag = false;
var mouseIsDown = false;
var startX, endX, startY, endY;
var hRectX, hRectY, hRectH, hRectW;
var vRectX, vRectY, vRectH, vRectW;

function pageLoad(sender, args) {
    homeCanvas = document.getElementById("homeCanvas");
    visCanvas = document.getElementById("visCanvas");
    homeContext = homeCanvas.getContext("2d");
    visContext = visCanvas.getContext("2d");
    homeCanvas.addEventListener("mousedown", mouseDown, false);
    homeCanvas.addEventListener("mousemove", mouseXY, false);
    homeCanvas.addEventListener("mouseup", mouseUp, false);
    homeCanvas.addEventListener("touchstart", touchDown, false);
    homeCanvas.addEventListener("touchmove", touchXY, false);
    homeCanvas.addEventListener("touchend", touchUp, false);
    homeCanvas.addEventListener("touchcancel", touchUp, false);
    visCanvas.addEventListener("mousedown", mouseDown, false);
    visCanvas.addEventListener("mousemove", mouseXY, false);
    visCanvas.addEventListener("mouseup", mouseUp, false);
    visCanvas.addEventListener("touchstart", touchDown, false);
    visCanvas.addEventListener("touchmove", touchXY, false);
    visCanvas.addEventListener("touchend", touchUp, false);
    visCanvas.addEventListener("touchcancel", touchUp, false);
    d = new Date();
    document.getElementById('MainContent_playIndexField').value = "";
    $("#homeRinkImagebtn").attr("src", "homeSummaryRink.aspx?" + d.getTime());
    $("#visRinkImagebtn").attr("src", "visSummaryRink.aspx?" + d.getTime());
    var table = document.getElementById('MainContent_gamesTable');
    var s = $("#MainContent_gamesIndexField").val();
    s++;
    console.log(ddFlag);
    if (ddFlag == false) {
        table.rows[s].click();
        table.rows[s].scrollIntoView();
        ddFlag = true;
    }
}

// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
}

function dropdownflag() {
    ddFlag = true;
}

// play Selection
function playUpdate() {
    //  console.log("playindexfield: " + $("#MainContent_playIndexField").val())
    //deprecated - not useful
  //  makeServerRequest("update-play", $("#MainContent_playIndexField").val());
}
function playUpdateDblclick() {
    makeServerRequest("update-play-dblclick", $("#MainContent_playIndexField").val());
    //setTimeout(function(){
    //    openBatsTube();
    //}, 500);
}

// goals Selection
function goalsUpdate() {
    //makeServerRequest("update-goals", $("#MainContent_goalsIndexField").val());
}
function goalsUpdateDblclick() {
    makeServerRequest("update-goals-dblclick", $("#MainContent_goalsIndexField").val());
}

// toi Selection
function toiUpdate() {
    //makeServerRequest("update-toi", $("#MainContent_toiIndexField").val());
}
function toiUpdateDblclick() {
    makeServerRequest("update-toi-dblclick", $("#MainContent_toiIndexField").val());
}

//toi buttons

$(document).on("click", "#visPP", function (event) {
    document.getElementById('lblPlayerName').innerHTML = '';
    $("#toiModal").modal();
    makeServerRequest('vis-pp');
});

$(document).on("click", "#visSH", function (event) {
    document.getElementById('lblPlayerName').innerHTML = '';
    $("#toiModal").modal();
    makeServerRequest('vis-sh');
});

$(document).on("click", "#homePP", function (event) {
    document.getElementById('lblPlayerName').innerHTML = '';
    $("#toiModal").modal();
    makeServerRequest('home-pp');
});

$(document).on("click", "#homeSH", function (event) {
    document.getElementById('lblPlayerName').innerHTML = '';
    $("#toiModal").modal();
    makeServerRequest('home-sh');
});

$(document).on("click", "#homeTOI", function (event) {
    makeServerRequest('home-toi');
});

$(document).on("click", "#visTOI", function (event) {
    makeServerRequest('vis-toi');
});

$(function () {
    $('#toiCollapse').on('shown.bs.collapse', function (e) {
        window.scrollTo(0, document.body.scrollHeight);
    });
});

$(function () {
    $('#gameReport').on('shown.bs.collapse', function (e) {
        window.scrollTo(0, document.body.scrollHeight);
    });
});

$(function () {
    $('#toiCollapse').on('hide.bs.collapse', function (e) {
        if(closeToi == false)
            e.preventDefault();
    });
});

$(document).on("click", "#btnPlayerGameValue", function (event) {
    batstubeWindow = window.open("playerGameValue.aspx", '_blank');
    batstubeWindow.focus();
});

$(document).on("click", "#btnVisFwdLines", function (event) {
    makeServerRequest('vis-fwd');
    batstubeWindow = window.open("summaryFwdLinesDefPairs.aspx", '_blank');
    batstubeWindow.focus();
});

$(document).on("click", "#btnHomeFwdLines", function (event) {
    makeServerRequest('home-fwd');
    batstubeWindow = window.open("summaryFwdLinesDefPairs.aspx", '_blank');
    batstubeWindow.focus();
});


$(document).on("click", "#toiClose", function (event) {
    closeToi = true;
    $('#toiCollapse').collapse('hide');
    closeToi = false;
});

//function ddCustom(dd) {
//    makeServerRequest('dd-custom', dd);
//}
//other buttons

$(document).on("click", "#btnGoals", function (event) {
    var isExpanded = $('#allGoals').attr("aria-expanded");
    if (isExpanded) {
        document.getElementById('MainContent_goalsIndexField').value = "";
        document.getElementById('lblAllGoals').innerHTML = $("#MainContent_gamesValueField").val().substr(0, 9) + " Goals";
        makeServerRequest('show-goals', $("#MainContent_gamesIndexField").val());
    }
});

$(document).on("click", "#btnReset", function (event) {
    document.getElementById('tbNote1').value = "";
    document.getElementById('tbNote2').value = "";
    document.getElementById('tbAuthor').value = "";
});

function playerButton(num) {
 //   document.getElementById('MainContent_toiIndexField').value = "";
    document.getElementById('lblPlayerName').innerHTML = document.getElementById('Button' + num).innerHTML;
    $("#toiModal").modal();
    makeServerRequest('player', num);
}

function handleClick(cb) {
    if (cb.id == 'MainContent_cbPowerGoals')
        makeServerRequest('cb-pp', cb.checked);
    if (cb.id == 'MainContent_cbChanceGoals')
        makeServerRequest('cb-chance', cb.checked);
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function limit(element) {
    var max_chars = 2;

    if (element.value.length > max_chars) {
        element.value = element.value.substr(0, max_chars);
    }
}

$(document).on('click', '.btn-async-request', function (events) {
    if ($(this).data("actionFlag") == 'from-sel' || $(this).data("actionFlag") == 'play-sel') {
        makeServerRequest($(this).data("actionFlag"), $("#MainContent_playIndexField").val());
    }
    else if ($(this).data("actionFlag") == 'play-jump') {
        makeServerRequest($(this).data("actionFlag"), (document.getElementById('period').value + "," + document.getElementById('min').value + ":" + document.getElementById('sec').value));
    }
    else if ($(this).data("actionFlag") == 'goals-selection') {
        makeServerRequest($(this).data("actionFlag"), $("#MainContent_goalsIndexField").val());
    }
    else if ($(this).data("actionFlag") == 'from-toi') {
        makeServerRequest($(this).data("actionFlag"), $("#MainContent_toiIndexField").val());
    }
    else {
        makeServerRequest($(this).data("actionFlag"));
    }
    openBatsTube();
});


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
    else if (actionFlag == 'vis-pp' || actionFlag == 'vis-sh' || actionFlag == 'home-pp' || actionFlag == 'home-sh' || actionFlag == 'player') {
        $('#toiTable tbody').empty();
        populateListboxTable("#toiTable", splitArgs[1]);
    }
    else if (actionFlag == 'home-toi' || actionFlag == 'vis-toi') {
        toiButtons(splitArgs[1]);
    }
    else if (actionFlag == 'show-goals') {
        $('#goalsTable tbody').empty();
        populateListboxTable("#goalsTable", splitArgs[1]);
    }
    else if (actionFlag == 'cb-pp' || actionFlag == 'cb-chance') {
        $('#goalsTable tbody').empty();
        populateListboxTable("#goalsTable", splitArgs[1]);
    }
    else if (actionFlag == 'dd-nhl') {
        console.log(splitArgs[1]);
        $('#playTable tbody').empty();
        populateListboxTable("#playTable", splitArgs[1]);
    }
    else if (actionFlag == 'mx' || actionFlag == 'sm') {
        console.log("MX RETURN:" + splitArgs[1]);
        $("#maxid").val(splitArgs[1]);
    }
    else if (actionFlag == 'update-play-dblclick') {
        console.log("reload");
        //batstubeWindow.location.reload();
        //batstubeWindow.focus();
        //  rinkClick(splitArgs[1]);
    }
};

function toiButtons(result) {
    $(".collapse").collapse('hide');
    for (i = 1; i < result.split(";").length; i++) {
        var b = document.getElementById("Button" + i);
        b.style.display = 'block';
        b.innerHTML = result.split(";")[i - 1];
    }
}

// rink clicks

//$(document).on('click', '#visRinkImagebtn', function (events) {
//    pos_x = events.offsetX ? (events.offsetX) : events.pageX - document.getElementById("visRinkImagebtn").offsetLeft;
//    pos_y = events.offsetY ? (events.offsetY) : events.pageY - document.getElementById("visRinkImagebtn").offsetTop;
//    makeServerRequest("vis-rink", pos_x + "," + pos_y);
//    openBatsTube();
//});

$(document).on('click', '#btnHomeSelected', function (events) {
    makeServerRequest("home-rink", hRectX + "," + hRectY + ',' + hRectW + ',' + hRectH);
    openBatsTube();
});

$(document).on('click', '#btnVisSelected', function (events) {
    makeServerRequest("vis-rink", vRectX + "," + vRectY + ',' + vRectW + ',' + vRectH);
    openBatsTube();
});

//$(document).on('click', '#homeRinkImagebtn', function (events) {
//    pos_x = events.offsetX ? (events.offsetX) : events.pageX - document.getElementById("homeRinkImagebtn").offsetLeft;
//    pos_y = events.offsetY ? (events.offsetY) : events.pageY - document.getElementById("homeRinkImagebtn").offsetTop;
//    makeServerRequest("home-rink", pos_x + "," + pos_y);
//    openBatsTube();
//});

function rinkClick(result) {
    if (result = "play")
        openBatsTube();
    else
        alert(result);
}

function touchDown(eve) {
    mouseIsDown = true;
    if (!e)
        var e = event;
    e.preventDefault();
    canvasIP = eve.target;
    var rect = canvasIP.getBoundingClientRect();
    startX = endX = Math.round(e.targetTouches[0].pageX - (rect.left + window.pageXOffset));
    startY = endY = Math.round(e.targetTouches[0].pageY - (rect.top + window.pageYOffset));
    drawSquare();
}

function touchXY(e) {
    if (mouseIsDown) {
        if (!e)
            var e = event;
        e.preventDefault();
        var rect = canvasIP.getBoundingClientRect();
        endX = Math.round(e.targetTouches[0].pageX - (rect.left + window.pageXOffset));
        endY = Math.round(e.targetTouches[0].pageY - (rect.top + window.pageYOffset));
        drawSquare();
    }
}

function touchUp() {
    mouseIsDown = false;
    if (startX == endX && startY == endY) {
        if (canvasIP.id == 'homeCanvas')
            makeServerRequest("home-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        else
            makeServerRequest("vis-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        openBatsTube();
    }
    //else {
    //    makeServerRequest("store-rink", rectX + "," + rectY + ',' + rectW + ',' + rectH);
    //}
}

function mouseDown(eve) {
    canvasIP = eve.target;
    mouseIsDown = true;
    var pos = getMousePos(canvasIP, eve);
    startX = endX = pos.x;
    startY = endY = pos.y;
    drawSquare();
}

function mouseXY(eve) {
    if (mouseIsDown) {
        var pos = getMousePos(canvasIP, eve);
        endX = pos.x;
        endY = pos.y;
        drawSquare();
    }
}

function mouseUp(eve) {
    mouseIsDown = false;
    var pos = getMousePos(canvasIP, eve);
    endX = pos.x;
    endY = pos.y;
    if (startX == endX && startY == endY) {
        if (canvasIP.id == 'homeCanvas')
            makeServerRequest("home-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        else
            makeServerRequest("vis-rink", Math.round(startX) + "," + Math.round(startY) + ',' + 0 + ',' + 0);
        openBatsTube();
    }
    else
        drawSquare();
}

function drawSquare() {
    // creating a square
    var w = endX - startX;
    var h = endY - startY;
    var offsetX = (w < 0) ? w : 0;
    var offsetY = (h < 0) ? h : 0;
    var width = Math.abs(w);
    var height = Math.abs(h);
    if (canvasIP.id == 'homeCanvas')
        context = homeContext;
    else
        context = visContext;
    context.clearRect(0, 0, canvasIP.width, canvasIP.height);

    context.beginPath();
    context.rect(startX + offsetX, startY + offsetY, width, height);
    if (canvasIP.id == 'homeCanvas') {
        hRectX = Math.round(startX + offsetX);
        hRectY = Math.round(startY + offsetY);
        hRectW = width;
        hRectH = height;
    }
    else {
        vRectX = Math.round(startX + offsetX);
        vRectY = Math.round(startY + offsetY);
        vRectW = width;
        vRectH = height;
    }
    context.lineWidth = 1;
    context.strokeStyle = 'blue';
    context.stroke();

}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}
