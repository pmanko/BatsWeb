$(function() {
	if(typeof showModal != 'undefined'){
	 $("#changeSelectionModal").modal('show');
    };
	
});


function callparkdetail() {
    var url = 'breakdownparkdetail.aspx';
    var win = window.open(url, '_blank');
    win.focus();
    //   event.preventDefault();
}



// -----------------------------
// Server Asynchronious Callback 
// -----------------------------

// request flags:
// od - one click dates

// pt - set pitcher team
// bt - set batter team

// lr - player list refresh
// lc - player list changed
// po - player button ok
// sp - select pitcher
// sb - select batter


// pa - pitcher - select all
// ba - batter - select all

// tt - change to pitch types
// tr - change to pitch results

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];
    
    if(splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }
    
    if(actionFlag == 'od') {
        oneClickDateSelectionSuccess(splitArgs[1]);
    } 
    else if (actionFlag=='pt' || actionFlag == 'bt') {
        teamSelectionSuccess(splitArgs[1], actionFlag);
    }
    else if (actionFlag == 'pa') {
        pitcherAllSelectionSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'ba') {
        batterAllSelectionSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'lr') {
        playerListRefreshSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'tt' || actionFlag == 'tr') {        
        $("#MainContent_previousSzoneImage").attr("src", "/breakdownpreviousszone.aspx?timestamp=" + new Date().getTime());
    }
    else if (actionFlag == 'pb') {        
        openPreviousModalSuccess(splitArgs[1]);
    }
    else if (actionFlag == 'po') {
        playerSelectedSuccess(splitArgs[1]);
    }
	
	
};
// -----------------------------

// -----------------------------
// Selection Modal

// Pitcher - select all
$(document).on("click", "#pitcherAllButton,#batterAllButton", function(event){
   // Selects all pitchers
   var requestFlag = $(this).data("playerType")+"a";
   CallServer(requestFlag, ""); 
});

// Batter - select all


// One-Click Dates
$(document).on("click", "#oneClickDate button", function(event) {
    // Calls server with one-click date parameter and request type flag
	// console.log($(this).data('dateFlag'));
    var requestFlag = "od";
	CallServer(requestFlag + $(this).data('dateFlag'), "");

});

function oneClickDateSelectionSuccess(dateRange) {
    if(dateRange == "ALL") {
		$("#MainContent_allEndRadioButton").prop("checked", true);
		$("#MainContent_allStartRadioButton").prop("checked", true);
	}
	else {
	
		var dates = dateRange.split(";");
		console.log(dates);

		$("#MainContent_startDateTextBox").val(dates[0]);
		$("#MainContent_startDateRadioButton").prop("checked", true);

		$("#MainContent_endDateTextBox").val(dates[1]);
		$("#MainContent_endDateRadioButton").prop("checked", true);

	}
	$("#oneClickDateModal").modal('hide');
}

// Team Selection
$(document).on("click", "#teamSelectionOkButton", function(event) {
    // Calls server with one-click date parameter and request type flag
	// console.log($(this).data('dateFlag'));
    var requestFlag = "";
    var modalType = $("#teamSelectionModal #modalType").text();
    
    
    
    console.log(modalType);
    console.log($('#MainContent_pTeamDropDownList :selected').text());
    
    if(modalType=="pitcher")
        requestFlag = 'pt';
    else if (modalType=="batter")
        requestFlag = 'bt';
        
	CallServer(requestFlag + $('#MainContent_pTeamDropDownList :selected').text(), "");

});

$(document).on('show.bs.modal', '#teamSelectionModal', function (event) {
  // Set Modal Type - either pitcher or batter
  var button = $(event.relatedTarget); // Button that triggered the modal
  var type = button.data('modalType'); // Extract info from data-* attributes
  

  var modal = $(this);
  modal.find('#modalType').text(type);
  
})

// Player Selection
$(document).on('change', "#MainContent_teamDropDownList", function(event) {
    CallServer('lr'+$(this).val())    
});

// $(document).on('change', "#MainContent_playerListBox", function(event) {
//     var type = $("#playerSelectionModal").data("type");
//     console.log(type);
//     console.log($(this).val() + " | " + $(this).find("option:selected").text());
//     
//     CallServer('lc'+$(this).val()+','+$(this).find("option:selected").text());    
// });

$(document).on('show.bs.modal', '#playerSelectionModal', function (event) {
  // Set Modal Type - either pitcher or batter
  var button = $(event.relatedTarget); // Button that triggered the modal
  var type = button.data('modalType');// Extract info from data-* attributes
  

  var modal = $(this);
  modal.data("type", type);

  if(type == 'pitcher')
    CallServer('sp');
  else
    CallServer('sb');
    
  CallServer('lr'+$("#MainContent_teamDropDownList").val())
  
});

$(document).on('click', "#selectPlayerButton", function(event){
    var selectedPlayerInfo;
    
    // Deceide which player value to select
    if($("#MainContent_playerListBox").val() == null) {
        selectedPlayerInfo = "located;" + $("#MainContent_locatePlayerTextBox").val()       
    } else {
        selectedPlayerInfo = "selected;" + $("#MainContent_playerListBox").val()+','+$("#MainContent_playerListBox").find("option:selected").text()
    }
    
    CallServer("po"+ selectedPlayerInfo); 
});

// Pitch Buttons
$(document).on("click", "#previousResultsButton", function(event){

    CallServer("tr");
});

$(document).on("click", "#previousButton", function(event){

    CallServer("pb");
});

$(document).on("click", "#previousTypesButton", function(event){
    CallServer("tt");
});

// Success Callbacks
function teamSelectionSuccess(selectedTeam, typeFlag) {
    console.log("CLOSE: " + selectedTeam);
    if(typeFlag == 'pt')
        $("#MainContent_pitcherSelectionTextBox").val(selectedTeam);
    else 
        $("#MainContent_batterSelectionTextBox").val(selectedTeam);
    $("#teamSelectionModal").modal("hide");
}

function pitcherAllSelectionSuccess(pitcherVal) {
    $("#MainContent_pitcherSelectionTextBox").val(pitcherVal);
}

function batterAllSelectionSuccess(batterVal) {
    $("#MainContent_batterSelectionTextBox").val(batterVal);
}

function playerListRefreshSuccess(players) {
    console.log(players.split(';'))
    $("#MainContent_playerListBox").empty();
    $.each(players.split(';'), function(i, playerString) {
        console.log(playerString);
        var splitPlayer = playerString.split(',');
        if(splitPlayer.length > 1)
            $('#MainContent_playerListBox').append( $('<option></option>').val(splitPlayer[0]).html(unescape(splitPlayer[1].replace(/ /g, "%A0"))));
    });
}

function openPreviousModalSuccess(listData) {
    $.each(listData.split(';'), function(i, listItem) {
        $('#MainContent_previousListBox').append($('<option></option>').val(listItem).html(listItem));
    });   
    

    $("#previousModal").modal();
}

function playerSelectedSuccess(players) {
    console.log(players.split(';'))
    var playersSplit = players.split(';')
    $("#MainContent_pitcherSelectionTextBox").val(playersSplit[0]);
    $("#MainContent_batterSelectionTextBox").val(playersSplit[1]);
 
    $("#playerSelectionModal").modal('hide');   
}
