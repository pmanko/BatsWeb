var bamWindow;

function openBam() {
    console.log("Opening BAM");
    //bamWindow = window.open("https://CoachingVideoSEA:PzSdfYXHiSA@cvmds.bamnetworks.com/mlbam/2016/10/23/487629/coaching_video/cv_1208687883_1200K.mp4", '_blank');
    bamWindow = window.open("http://www.google.com", '_blank');
}

$(document).on("click", "#login", function () {
    login_data = $("#MainContent_teamDropDownList").val().toUpperCase() + ',' + $("#MainContent_first_name").val().toUpperCase() + ',' + $("#MainContent_last_name").val().toUpperCase() + ',' + $("#MainContent_password").val();
    makeServerRequest("login", login_data);
 
    event.preventDefault();
});

function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];

    switch (actionFlag) {
        case 'login':
            if (splitArgs[1] == 'success') {
                returnUrl = getUrlParameter("ReturnUrl")
                window.location = (returnUrl === undefined ? 'mainmenu.aspx' : returnUrl);
                openBam();
            } else {
                alert("Sorry! Your login failed - please check your name and password and try again.");
            }
            break;
        default:
            console.log("Default!");
    };
};
// -----------------------------