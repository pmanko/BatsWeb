<%@ Page Title="" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="pucksweb.batstube" Language="C#"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="/dist/styles/video-js.min.css" rel="stylesheet" type="text/css">

	<link type="text/css" href="/Styles/batstube.css" rel="stylesheet" />

    <script src="/dist/scripts/videojs.bundle.min.js"></script>
	
	<script>
	    var videoPaths = '<%= HttpUtility.JavaScriptStringEncode((string)Session["video-paths"]) %>'.split(';');
	    var changePaths = '<%= HttpUtility.JavaScriptStringEncode((string)Session["video-paths"]) %>';
	    var videoTitles = '<%= HttpUtility.JavaScriptStringEncode((string)Session["video-titles"]) %>'.split(';');
	    //var BAM = '<%= HttpUtility.JavaScriptStringEncode((string)Session["BAM"]) %>'; 
	</script>
	<script>
	    var pathsChanged = false;
	    var preventKeys = false;
	</script>
	<script src="/Scripts/batstube_app.js"></script> 
	<script src="/Scripts/download.js"></script> 
    <script type="text/javascript" src="Scripts/batstube.js"></script> 
    <script>
        $(document).on("click", "#btnDownload", function (event) {
            //do_dl();
            //var cutTimes = [];
            document.getElementById("btnDownload").innerHTML = "Downloading...";
            document.getElementById("btnDownload").disabled = true;
            var downloads = [];
            for (var i = 0; i < videoPaths.length - 1; i++) {
                //cutTimes.push(videoPaths[i].substring(videoPaths[i].lastIndexOf("/") + 1, videoPaths[i].length).replace(",",";"));
                //if (i > 0) {
                //    if (videoPaths[i].substring(0, videoPaths[i].indexOf("#")) != videoPaths[i - 1].substring(0, videoPaths[i - 1].indexOf("#"))) {
                //        downloads.push({
                //            download: videoPaths[i].substring(0, videoPaths[i].indexOf("#")),
                //            filename: videoTitles[i].trim()
                //        });
                //    }
                //}
                //else {
                    downloads.push({
                        download: videoPaths[i].substring(0, videoPaths[i].indexOf("#")),
                        filename: videoTitles[i].trim()
                    });
              //  }
            }
            download_files(downloads);
            //var a = window.document.createElement('a'); 
            //a.href = window.URL.createObjectURL(new Blob([cutTimes], { type: 'text/csv' }));
            //a.download = 'cut.txt';

            //// Append anchor to body.
            //document.body.appendChild(a);
            //a.click();

            //// Remove anchor from body
            //document.body.removeChild(a);
        });
    </script>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<div class="container body-content" ng-app="VidApp">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="main_video">
		<div class='row' ng-controller="VideoCtrl">         
			<div class='col-lg-9 col-lg-push-3'>
				<div class='row'>
					<div class='col-lg-12'>
						<div class='embed-responsive embed-responsive-16by9'>
							<video id="main_vid" class='embed-responsive-item video-js vjs-default-skin vjs-big-play-centered'>
								<source src="" type="video/mp4">
								<p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
							</video>
						</div>
					</div>
				</div>
				<br />
				<div class='row'>
					<div class='col-lg-12'>
						<div class='text-center'>
							<button type="button" class="btn btn-default btn-lg" id='step-back' ng-click="stepBack()">
								<span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span> Step Back
							</button>
							<button type="button" class="btn btn-default btn-lg" id='pause' ng-click="pause()">
								<span class="glyphicon glyphicon-pause" aria-hidden="true"></span> Pause
							</button>
							<button type="button" class="btn btn-default btn-lg" id='slow' ng-click="slow()">
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true" data-toggle="button" aria-pressed="false"></span> Slow
							</button>
							<button type="button" class="btn btn-default btn-lg" id='play' ng-click="play()">
								<span class="glyphicon glyphicon-play" aria-hidden="true" data-toggle="button" aria-pressed="false"></span> Play
							</button>
							<button type="button" class="btn btn-default btn-lg" id='step-forward' ng-click="stepForward()">
								Step Forward
								<span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
							</button>
							<button type="button" class="btn btn-primary btn-lg" id='playlist-mode' data-toggle="collapse" data-target="#playlistCollapse">
                                <span class="glyphicon glyphicon-menu-down" aria-hidden="true" data-toggle="button" aria-pressed="false"></span> Playlist Mode
							</button>
						</div>
					</div>
				</div>
                <div class="collapse" id="playlistCollapse">
				    <div class='row'>
					    <div class='col-lg-10 col-lg-offset-1'>
						    <div class='text-center'>
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <div class="input-group">
                                            <span class="input-group-btn">
							                    <button type="button" class="btn btn-default btn-md" id='btnSetStart' ng-click="setStart()" onclick="setStart()">
								                    <span class="glyphicon glyphicon-time" aria-hidden="true"></span> Set Start
							                    </button>
                                            </span>
                                            <label id="lblStart" class="form-control"></label>
						                </div>
						            </div>
                                    <div class="btn-group" role="group">
                                        <div class="input-group">
                                            <span class="input-group-btn">
							                    <button type="button" class="btn btn-default btn-md" id='btnSetEnd' ng-click="setEnd()" onclick="setEnd()">
								                    <span class="glyphicon glyphicon-time" aria-hidden="true"></span> Set End
							                    </button>
                                            </span>
                                            <label id="lblEnd" class="form-control"></label>
						                </div>
						            </div>
                                    <div class="btn-group" role="group">
							            <button type="button" class="btn btn-default btn-md" id='btnMoveUp' ng-click="moveUp()">
								            <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span> Move Up
							            </button>
						            </div>
                                    <div class="btn-group" role="group">
							            <button type="button" class="btn btn-default btn-md" id='btnMoveDown' ng-click="moveDown()">
								            <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span> Move Down
							            </button>
						            </div>
						        </div>
					        </div>
					    </div>
				    </div>
				    <div class='row'>
					    <div class='col-lg-12'>
						    <div class='text-center'>
							    <button type="button" class="btn btn-primary btn-md" data-toggle="modal" data-target="#addClipsModal">
								    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Clips
							    </button>
							    <button type="button" class="btn btn-danger btn-md" id='btnRemoveClip' ng-click="removeClip()">
								    <span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span> Remove Clip
							    </button>
						    </div>
					    </div>
				    </div>
			    </div>
				<br />
			</div>

			<div class='col-lg-3 col-lg-pull-9'>
				<div  class="panel  panel-default" id='playlist'>
					<div class="panel-heading">
                        <div class='panel-title'>My Playlist</div>                        
                        <div class='checkbox checkbox-primary'>
                            <input id='angleCheckbox' type="checkbox" ng-model="angleChoice.mainOnly" ng-change="setupVideos()">
                            <label for='angleCheckbox'>Main Angle Only</label> 
                        </div>
					</div>
					<div class="list-group" id="tester">
						<a class='list-group-item' ng-repeat="video in sentVideos" ng-class="{ active: video.path == model.currentVideo.path && video.title == model.currentVideo.title }" ng-click="setCurrentVideo(video)">
						<%--<a class='list-group-item' ng-repeat="video in sentVideos" ng-class="{ active: video == model.currentVideo }" ng-click="setCurrentVideo(video)">--%>
							<h4>{{video.title}}</h4>
						</a>
					</div>
<%--                    <button type="button" class="btn btn-lg btn-block btn-success" id="btnDownload">Download Clips</button>
                    <div class="progress">
                      <div class="progress-bar progress-bar-success" id="theBar" role="progressbar" aria-valuenow="0"
                      aria-valuemin="0" aria-valuemax="100" style="width:0%">
                      </div>
                    </div>--%>
                    <button type="button" class="btn btn-lg btn-block btn-info" id="btnShare">Share Playlist</button>
				</div>
			</div>
		</div>
		</div>
	    <hr />

        <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Online Playlist</h4>
                <small><label>Share this link</label></small>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-md-12">
                          <div class="input-group" style="width:100%">
                              <asp:TextBox ID="tbShare" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                          </div>
                      </div>
                  </div>
              </div>
            </div>
          </div>
        </div>

        <div class="modal fade" id="addClipsModal" tabindex="-1" role="dialog" aria-labelledby="addClipsModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addClipsModalLabel">Add Playlist</h4>
                <small><label>Put the link to the playlist you wish to add</label></small>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-xs-9">
                          <div class="input-group" style="width:100%">
                              <input type="text" class="form-control" id="tbAdd">
                              <%--<asp:TextBox ID="tbAdd" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>--%>
                          </div>
                      </div>
                      <div class="col-md-3">
					      <button type="button" class="btn btn-primary btn-md" id='btnAddPlaylist' onclick="addClips()" data-toggle="modal" data-target="#addClipsModal">
						     <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Clips
					      </button>
                      </div>
                  </div>
              </div>
            </div>
          </div>
        </div>
	</div>
</asp:Content>


