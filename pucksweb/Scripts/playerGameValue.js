
function pageLoad(sender, args) {
    var result = $("#MainContent_visField").val().split(";");
    var visFinish = new Array(result.length - 1)
    for (i = 0; i < result.length - 1; i++) {
        visFinish[i] = result[i].split(",");
    }
    $('#vis').DataTable({
        paging: false,
        info: false,
        searching: false,
        data: visFinish,
        columns: [
            { title: "Name" },
            { title: "Even" },
            { title: "Team 5% Chance" },
            { title: "Opp 5% Chance" },
            { title: "+/-" }
        ]
    });
    result = $("#MainContent_homeField").val().split(";");
    var homeFinish = new Array(result.length - 1)
    for (i = 0; i < result.length - 1; i++) {
        homeFinish[i] = result[i].split(",");
    }
    $('#home').DataTable({
        paging: false,
        info: false,
        searching: false,
        data: homeFinish,
        columns: [
            { title: "Name" },
            { title: "Even" },
            { title: "Team 5% Chance" },
            { title: "Opp 5% Chance" },
            { title: "+/-" }
        ]
    });
}

// Open Batstube
function openBatsTube() {
    batstubeWindow = window.open("batstube.aspx", '_blank');
    batstubeWindow.focus();
}

// goals Selection
function goalsUpdate() {
    makeServerRequest("update-goals", $("#MainContent_goalsIndexField").val());
}
function goalsUpdateDblclick() {
    makeServerRequest("update-goals-dblclick", $("#MainContent_goalsIndexField").val());
}

$(document).on('click', '#vis td', function (e) {
    var table = $('#vis').DataTable();
    var row_clicked = table.cell(this).index().row;
    col_clicked = table.cell(this).index().column;
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = table.row(row_clicked).data()[0];
    makeServerRequest('vis-player', row_clicked + "," + col_clicked);
});

$(document).on('click', '#home td', function (e) {
    var table = $('#home').DataTable();
    var row_clicked = table.cell(this).index().row;
    col_clicked = table.cell(this).index().column;
    $("#toiModal").modal();
    document.getElementById('lblPlayerName').innerHTML = table.row(row_clicked).data()[0];
    makeServerRequest('home-player', row_clicked + "," + col_clicked);
});

$(document).on('click', '.btn-async-request', function (events) {
    if ($(this).data("actionFlag") == 'play-sel') {
        makeServerRequest($(this).data("actionFlag"), $("#MainContent_goalsIndexField").val());
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

    if (actionFlag == 'vis-player' || actionFlag == 'home-player') {
        $('#goalsTable tbody').empty();
        populateListboxTable("#goalsTable", splitArgs[1]);
    }
};
