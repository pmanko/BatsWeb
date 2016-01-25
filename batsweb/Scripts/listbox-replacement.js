// -----------------------------
// List Box Replacement
// -----------------------------
$(document).on('click', 'table.listbox-replacement-clickable tbody tr', function(event){
    var myTable = $(this).closest("table");
    var lbVal = $(this).find("td:first").html();
    var lbField = $(myTable.data("targetField"));
    var postback = myTable.data("postback");
    var multiple = myTable.data("multiple");


    console.log(lbVal);
    console.log(postback);
    console.log(lbField);
    console.log(multiple);
        

    $(this).toggleClass("selected");
    
    if(!multiple & $(this).hasClass("selected")) {
        $(this).siblings().removeClass("selected");
    }
    
    if(multiple) {
        var combinedVals = $(this).parent().children(".selected").map(function(){ return $(this).text() }).get();
        lbField.val(combinedVals);
    } else {
        lbField.val(unescape(lbVal));
    }
    
    

    if(postback) {
    __doPostBack();   
    }

});

function populateListboxTable(tableId, rowData) {
  
    $.each(rowData.split(";"), function(i, row){
        console.log(i);
        if(row != "") {                
            $(tableId + ' tbody').append('<tr><td></td></tr>');
            $(tableId + ' tbody tr:last td:first').html(unescape(row));
        }
        
    });
  
}

