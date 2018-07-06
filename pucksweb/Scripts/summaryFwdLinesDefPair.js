var batstubeWindow;
var toiName;
var closeLines = false;

function pageLoad(sender, args) {
    populateListboxTable("#defEven", $("#MainContent_defEvenField").val());
    populateListboxTable("#defSh", $("#MainContent_defShField").val());
    populateListboxTable("#fwdEven", $("#MainContent_fwdEvenField").val());
    populateListboxTable("#fwdPp", $("#MainContent_fwdPpField").val());
}

// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
}
// toi Selection
function toiUpdate() {
 //   makeServerRequest("update-toi", $("#MainContent_toiIndexField").val());
}
function toiUpdateDblclick() {
    makeServerRequest("update-toi-dblclick", $("#MainContent_toiIndexField").val());
}

// defEven Selection
function defEvenUpdate() {
    makeServerRequest("def-even", $("#MainContent_defEvenIndexField").val());
    toiName = $("#MainContent_defEvenValueField").val().substr(4, 30);
}
function defEvenUpdateDblclick() {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = $("#MainContent_defEvenValueField").val().substr(4, 30);
    makeServerRequest("def-even", $("#MainContent_defEvenIndexField").val());
}

// defSh Selection
function defShUpdate() {
    makeServerRequest("def-sh", $("#MainContent_defShIndexField").val());
    toiName = $("#MainContent_defShValueField").val().substr(4, 30);
}
function defShUpdateDblclick() {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = $("#MainContent_defShValueField").val().substr(4, 30);
    makeServerRequest("def-sh", $("#MainContent_defShIndexField").val());
}

// fwdEven Selection
function fwdEvenUpdate() {
    makeServerRequest("fwd-even", $("#MainContent_fwdEvenIndexField").val());
    toiName = $("#MainContent_fwdEvenValueField").val().substr(4, 30);
}
function fwdEvenUpdateDblclick() {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = $("#MainContent_fwdEvenValueField").val().substr(4, 30);
    makeServerRequest("fwd-even", $("#MainContent_fwdEvenIndexField").val());
}

// fwdPp Selection
function fwdPpUpdate() {
    makeServerRequest("fwd-pp", $("#MainContent_fwdPpIndexField").val());
    toiName = $("#MainContent_fwdPpValueField").val().substr(4, 30);
}
function fwdPpUpdateDblclick() {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = $("#MainContent_fwdPpValueField").val().substr(4, 30);
    makeServerRequest("fwd-pp", $("#MainContent_fwdPpIndexField").val());
}


// oppLines Selection

function linesUpdate() {
    makeServerRequest("opp-toi", $("#MainContent_linesIndexField").val());
}
function linesUpdateDblclick() {
    $("#toiModal").modal();
    var str = $("#MainContent_linesValueField").val();
    var name = str.replace(/&nbsp;/g, ' ');
    document.getElementById('lblPlayerName').innerHTML = name.substr(16, 50);
    makeServerRequest("opp-toi", $("#MainContent_linesIndexField").val());
}

$(document).on("click", "#btnDefToi", function (event) {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = toiName;
});

$(document).on("click", "#btnFwdToi", function (event) {
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = toiName;

});
$(document).on("click", "#btnDefOppLines", function (event) {
    makeServerRequest('def-opp');
    window.scrollTo(0, document.body.scrollHeight);
});

$(document).on("click", "#btnFwdOppLines", function (event) {
    makeServerRequest('fwd-opp');
    window.scrollTo(0, document.body.scrollHeight);
});

$(document).on("click", "#btnOppShifts", function (event) {
    $("#toiModal").modal();
    var str = $("#MainContent_linesValueField").val();
    var name = str.replace(/&nbsp;/g, ' ');
    document.getElementById('lblPlayerName').innerHTML = name.substr(16, 50);
});

$(function () {
    $('#oppLines').on('shown.bs.collapse', function (e) {
        window.scrollTo(0, document.body.scrollHeight);
    });
});

$(function () {
    $('#oppLines').on('hide.bs.collapse', function (e) {
        if (closeLines == false)
            e.preventDefault();
    });
});

$(document).on("click", "#toiClose", function (event) {
    closeLines = true;
    $('#oppLines').collapse('hide');
    closeLines = false;
});

$(document).on('click', '.btn-async-request', function (events) {
    if ($(this).data("actionFlag") == 'from-toi') {
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

    if (actionFlag == 'def-even' || actionFlag == 'def-sh' || actionFlag == 'fwd-even' || actionFlag == 'fwd-pp' || actionFlag == 'opp-toi') {
        $('#toiTable tbody').empty();
        populateListboxTable("#toiTable", splitArgs[1]);
    }
    else if (actionFlag == 'def-opp' || actionFlag == 'fwd-opp') {
        $('#linesTable tbody').empty();
        populateListboxTable("#linesTable", splitArgs[1]);
    }
};