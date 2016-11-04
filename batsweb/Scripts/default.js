var bamWindow;

function openBam() {
    bamWindow = window.open("https://CoachingVideoSEA:PzSdfYXHiSA@cvmds.bamnetworks.com/mlbam/2016/10/23/487629/coaching_video/cv_1208687883_1200K.mp4", '_blank');
}

$(document).on("click", "#login", function () {
    makeServerRequest("login");
    openBam();
});

// -----------------------------
// Returns Data from Server after GetCallbackResult code behind function
function GetServerData(arg, context) {
    var splitArgs = arg.split("|");
    var actionFlag = splitArgs[0];

    if (splitArgs.length > 2) {
        alert(splitArgs[2]);
        return;
    }

    switch (actionFlag) {
        case 'login':
            console.log(splitArgs[1]);
            break;
        default:
            console.log("Default!");
    };
};
// -----------------------------