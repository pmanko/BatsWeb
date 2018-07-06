
function pageLoad(sender, args) {
    var j = 0;
    var result = $("#MainContent_visField").val().split(";");
    //for (i = 0; i < (result.length - 1) * 5; i++) {
    //    j = i % 5;
    //    var b = document.getElementById("visButton" + (i + 1));
    //    b.style.display = 'block';
    //    if (j == 1) {
    //        if (result[Math.trunc(i / 5)].split(",")[j] < 0)
    //            b.style.color = 'red';
    //        else
    //            b.style.color = 'blue';
    //    }
    //    b.innerHTML = result[Math.trunc(i / 5)].split(",")[j];
    //}
    //var result = $("#MainContent_homeField").val().split(";")
    //for (i = 0; i < (result.length - 1) * 5; i++) {
    //    j = i % 5;
    //    var b = document.getElementById("homeButton" + (i + 1));
    //    b.style.display = 'block';
    //    if (j == 1) {
    //        if (result[Math.trunc(i / 5)].split(",")[j] < 0)
    //            b.style.color = 'red';
    //        else
    //            b.style.color = 'blue';
    //    }
    //    b.innerHTML = result[Math.trunc(i / 5)].split(",")[j];
    //}
    console.log(result);
    var finish = new Array(result.length - 1)
    for (i = 0; i < result.length - 1; i++) {
        finish[i] = result[i].split(",");
    }
    console.log(finish);
    $('#example').DataTable({
        paging: false,
        info: false,
        searching: false,
        data: finish,
        columns: [
            { title: "Name" },
            { title: "Even" },
            { title: "Team 5% Chance" },
            { title: "Opp 5% Chance" },
            { title: "+/-" }
        ]
    });
}

$(document).on('click', '#example td', function (e) {
    var table = $('#example').DataTable();
    var row_clicked = table.cell(this).index().row;
    col_clicked = table.cell(this).index().column;
    makeServerRequest('vis-player', row_clicked + "," + col_clicked);
});

function visButton(num, num2) {
    //   document.getElementById('MainContent_toiIndexField').value = "";
    //document.getElementById('lblPlayerName').innerHTML = document.getElementById('Button' + num).innerHTML;
    $("#toiModal").modal();
    makeServerRequest('vis-player', num + "," + num2);
}

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
};
