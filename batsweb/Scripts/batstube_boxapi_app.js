var VidApp = angular.module('VidApp', ['ngRoute']);

VidApp.controller('VideoCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {
    $scope.model = {
        currentVideo: undefined
    };
    
    $scope.angleChoice = {
        mainOnly : true
    };

    $scope.model.currentVideo = null;

    // console.log(videoPaths);
    // console.log(videoTitles);


    // KeyDown Events
    $(document).on("keydown", function (event) {

        if (event.which == 32) { // SPACE
            event.preventDefault();
            $scope.pause();
        }
        else if (event.which == 37 || event.which == 65) { // LEFT
            event.preventDefault();
            $scope.stepBack();
        }
        else if (event.which == 38 || event.which == 87) { // UP
            event.preventDefault();
            $scope.play();
        }
        else if (event.which == 39 || event.which == 68) { // RIGHT
            event.preventDefault();
            $scope.stepForward();
        }

        else if (event.which == 40 || event.which == 83) { // DOWN
            event.preventDefault();
            $scope.slow();
        }

    });



    $scope.preSetupVideos = function () {
        $scope.sentVideos = [];
        for (var i = 0; i < videoPaths.length; i++) {
            if (videoPaths[i] != "") {
                // console.log($.trim(videoTitles[i]).length);
                if(!$scope.angleChoice.mainOnly || $.trim(videoTitles[i]).length > 1) {
                    $scope.sentVideos.push(
                        {
                            path: videoPaths[i].trim().replace(/\s+/g, "/"),
                            title: videoTitles[i]
                        }
                    );                    
                }

            }
        };        
    };
    
    $scope.translateVideos = function(callback) {
        $scope.method = 'POST';
        $scope.url = '//vids4.sydexsports.net/translate';
        
        // console.log($scope.sentVideos);
        
        $http({method: $scope.method, url: $scope.url, data: $scope.sentVideos}).
        then(function(response) {
            $scope.status = response.status;
            $scope.data = response.data;
            
            // console.log("SUCCESS!!!");
            // console.log($scope.status);
            // console.log($scope.data);
            
            $scope.sentVideos = $scope.data;
            
            $scope.sentVideos.sort(function(a,b) {return (a.order > b.order) ? 1 : ((b.order > a.order) ? -1 : 0);} ); 

            callback()
            // $scope.startVideos();
        }, function(response) {
            // console.log("FAILURE!");
            $scope.data = response.data || "Request failed";
            $scope.status = response.status;

            // console.log($scope.status);
            // console.log($scope.data);

        });        
    }
    
    $scope.translatePath = function(path, callback) {
        $scope.method = 'POST';
        $scope.url = '//vids4.sydexsports.net/translateone';
        
        $http({method: $scope.method, url: $scope.url, data: { path: path} }).
        then(function(response) {
            $scope.status = response.status;
            $scope.data = response.data;
            
            // console.log("2 SUCCESS!!!");
            // console.log($scope.status);
            // console.log($scope.data);
                       
            callback($scope.data);
            // $scope.startVideos();
        }, function(response) {
            console.log("FAILURE!");
            $scope.data = response.data || "Request failed";
            $scope.status = response.status;

            // console.log($scope.status);
            // console.log($scope.data);

        });        

    }
    
    $scope.startVideos = function() {
        $scope.model.currentVideo = $scope.sentVideos[0];
         
        $scope.translatePath($scope.model.currentVideo.path, function(newPath) {
            videojs("main_vid", { "controls": true, "autoplay": false, "preload": "auto",  techOrder: ["html5", "flash"] }, function () {
                this.trigger("loadstart");
                this.src([{ type: "video/mp4", src: newPath }]);
                this.play();
                
                this.on('ended', function () {
                    $scope.$apply(function () {                    
                        var next_vid_index = ($scope.sentVideos.indexOf($scope.model.currentVideo) + 1) % $scope.sentVideos.length;
                        
                        //console.log("LENGTH:" + $scope.sentVideos.length);
                        //console.log("current: " + ($scope.sentVideos.indexOf($scope.model.currentVideo)));
                        $scope.setCurrentVideo($scope.sentVideos[next_vid_index]);
                        //console.log("NEXT: " + next_vid_index);

                    });
                });
            });            
        });                  
        

    };
    
    $scope.setupVideos = function() {

        $scope.preSetupVideos();
        $scope.setCurrentVideo($scope.sentVideos[0]);     
    }
    

    
    $scope.preSetupVideos();
    $scope.startVideos(); 
    
    $scope.setCurrentVideo = function (newVid) {
        $scope.model.currentVideo = newVid;

        videojs("main_vid").ready(function () {
            
            var myvid = this;
            var currentRate = myvid.playbackRate();
            //console.log(currentRate);            
            myvid.errorDisplay.close();
            
            $scope.translatePath(newVid.path, function(newPath){
                myvid.src([{ type: "video/mp4", src: newPath }]);
                myvid.addClass("embed-responsive-item");
        
                myvid.defaultPlaybackRate = currentRate;
                myvid.play();
                myvid.playbackRate(currentRate);
            });
            
        });
            
    };

    $scope.stepForward = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;
            var fps = 29;
            var frameLength = 1 / fps;

            myvid.pause();

            myvid.currentTime(myvid.currentTime() + frameLength);
        });

    };

    $scope.stepBack = function () {
        videojs("main_vid").ready(function () { 
            var myvid = this;   
            var fps = 29;
            var frameLength = 1 / fps;

            myvid.pause();

            myvid.currentTime(myvid.currentTime() - frameLength);
        });
    };

    $scope.play = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;
            this.defaultPlaybackRate = 1.0;
            myvid.play();
	
            myvid.playbackRate(1.0);
        });
    };

    $scope.slow = function () {
        videojs("main_vid").ready(function () {
            this.defaultPlaybackRate = 0.25;
            this.play();
            this.playbackRate(0.25);

        });
    }

    $scope.pause = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;

            if (myvid.paused()) {
                myvid.play();
            } else {
                myvid.pause();
            }
        });
    };
}]);

