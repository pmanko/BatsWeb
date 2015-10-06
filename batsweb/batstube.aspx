<%@ Page Title="" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="batsweb.batstube" Language="C#"%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<link href="//vjs.zencdn.net/4.12/video-js.css" rel="stylesheet">
	<script src="//vjs.zencdn.net/4.12/video.js"></script>

	<link type="text/css" href="Styles/batstube.css" rel="stylesheet" />

	<script>
		var videoPaths = "<%= Session["video-paths"] %>".split(',');
		var videoTitles = "<%= Session["video-titles"] %>".split(',');
	</script>
	<script src="Scripts/batstube_app.js"></script> 

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<div class="container body-content" ng-app="VidApp">
		<div class="jumbotron">
			<div class="input-group">
				<input type="text" class="form-control input-lg" placeholder="Search videos..." ng-model="query">
				<span class="input-group-btn">
					<button class="btn btn-default btn-lg" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
				</span>
			</div>
		</div>

        <div class="row" ng-controller="PathCtrl">
            <div  class="col-lg-12">
				<div  class="list-group">
					<div class='list-group-item' ng-repeat="v in sentVideos">
						{{v.title}}  {{v.path}}
					</div>
				</div>
            </div>
        </div>
        
		<div class='row' ng-controller="VideoCtrl">         
			<div class='col-lg-9 col-lg-push-3'>
				<div class='row'>
					<div class='col-lg-12'>
						<div class='embed-responsive embed-responsive-16by9'>
							<video id="main_vid" class='embed-responsive-item video-js vjs-default-skin' controls>
								<source src="{{currentVideo.path}}" type="video/mp4">
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
						</div>
					</div>
				</div>
				<br />
			</div>

			<div class='col-lg-3 col-lg-pull-9'>
				<div  class="panel  panel-default" id='playlist'>
					<div class="panel-heading">My Playlist</div>

					<div class="list-group">
						<a class='list-group-item' ng-repeat="video in videos" ng-class="{ active: video == model.currentVideo }" ng-click="setCurrentVideo(video)">
							<h4>{{video.title}}</h4>
							<p>{{video.path.substring(video.path.lastIndexOf('/')+1)}}</p>
						</a>
					</div>
				</div>
			</div>
		</div>

	    <hr />
	</div>
</asp:Content>


