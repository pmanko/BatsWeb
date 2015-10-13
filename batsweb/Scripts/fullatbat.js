$(document).on("click", "#show_videos", function (event) {
    var vid_paths = $("#vid_paths").val();
    //var vid_titles = $("#vid_titles").val();

    //alert(vid_paths.length + "|" + vid_titles.length);
    //console.log(vid_paths);
    //console.log(vid_titles);


    var url = 'batstube.aspx';
    //var url = 'Vids.html#?paths=' + vid_paths + '&titles=' + vid_titles;
    //var form = $('<form action="' + url + '" method="get" target="_blank">' +
    //  '<input type="hidden" name="paths" value="' + vid_paths.replace(/"/, '') + '" />' +
    //  '<input type="hidden" name="titles" value="' + vid_titles.replace(/"/, '') + '" />' +
    //  '</form>');
    //$('body').append(form);
    //form.submit();
    //if (vid_paths.length == 0) {
        alert(vid_paths);
    //} else {
        var win = window.open(url, '_blank');
        win.focus();
    //}
    event.preventDefault();
});