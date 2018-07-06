var VidApp = angular.module('VidApp', ['ngRoute']);
VidApp.controller('VideoCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {


    $scope.model = {
        currentVideo: undefined
    };

    $scope.angleChoice = {
        mainOnly: true
    };

    $scope.videos = [];
    $scope.model.currentVideo = null;

    //console.log(videoPaths);
    //console.log(videoTitles);

    // KeyDown Events
    $(document).on("keydown", function (event) {
        if (preventKeys == true) {
            return;
        }
        else
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


    $scope.setupVideos = function (x) {
        $scope.sentVideos = [];
        //console.log('load');
        console.log('load=' + videoPaths);

        //if (pathsChanged) {
        //    console.log(newPaths);
        //    for (var i = 0; i < newPaths.length; i++) {
        //        if (newPaths[i] != "") {
        //            //console.log($.trim(videoTitles[i]).length);
        //            if (!$scope.angleChoice.mainOnly || $.trim(videoTitles[i]).length > 1) {
        //                $scope.sentVideos.push(
        //                    {
        //                        path: newPaths[i].trim().replace(/\s+/g, "/").replace(),
        //                        title: videoTitles[i]
        //                    }
        //                );
        //            }

        //        }
        //    };
        //}
        //else
        //{ 
        for (var i = 0; i < videoPaths.length; i++) {
            if (videoPaths[i] != "") {
                //console.log($.trim(videoTitles[i]).length);
                if (!$scope.angleChoice.mainOnly || $.trim(videoTitles[i]).length > 1) {
                    $scope.sentVideos.push(
                        {
                            path: videoPaths[i].trim().replace(/\s+/g, "/").replace(),
                            title: videoTitles[i]
                        }
                    );
                }

            }
        };
       // }
    };
    $scope.setupVideos();
    $scope.model.currentVideo = $scope.sentVideos[0];

    videojs("main_vid", { "controls": true, "autoplay": false, "preload": "auto", techOrder: ["html5", "flash"] }, function () {
        this.trigger("loadstart");
        this.src([{ type: "video/mp4", src: $scope.model.currentVideo.path }]);
        this.errorDisplay.close();
        this.play();

        this.on('pause', function () {
            $scope.$apply(function () {
                //$scope.checkChanged();
                //console.log($scope.sentVideos);
               // var myvid = videojs('main_vid');
                var tm = Math.round(videojs('main_vid').currentTime());
            //    console.log(tm);
           //     console.log($scope.model.currentVideo.path.substr($scope.model.currentVideo.path.lastIndexOf(',') + 1));
                if (tm == $scope.model.currentVideo.path.substr($scope.model.currentVideo.path.lastIndexOf(',') + 1)) {
                    //var next_vid_index = ($scope.sentVideos.indexOf($scope.model.currentVideo) + 1) % $scope.sentVideos.length;
                    var next_vid_index = ($scope.myIndexOf($scope.model.currentVideo) + 1) % $scope.sentVideos.length;
                    //console.log('pause' + next_vid_index);
                    $scope.setCurrentVideo($scope.sentVideos[next_vid_index]);
                }
            });
        });

        this.on('ended', function () {
            $scope.$apply(function () {
                //var jsonArray = angular.toJson($scope.sentVideos);
                //console.log(jsonArray.indexOf(angular.toJson($scope.model.currentVideo))); 
                var next_vid_index = ($scope.myIndexOf($scope.model.currentVideo) + 1) % $scope.sentVideos.length;
                //console.log('end' + next_vid_index);
                $scope.setCurrentVideo($scope.sentVideos[next_vid_index]);
            });
        });
    });

    $scope.checkChanged = function () {
        if (pathsChanged == true) {
            //newPaths = newPaths.split(';');
            $scope.setupVideos();
            pathsChanged = false;
        }
    }

    $scope.myIndexOf = function (o) {
        for (var i = 0; i < $scope.sentVideos.length; i++) {
            if ($scope.sentVideos[i].path == o.path && $scope.sentVideos[i].title == o.title) {
                return i;
            }
        }
        return -1;
    }

    $scope.setCurrentVideo = function (newVid) {
        $scope.checkChanged();
        //if (pathsChanged == true) {
        //    //newPaths = newPaths.split(';');
        //    $scope.setupVideos();
        //    pathsChanged = false;
        //}
        $scope.model.currentVideo = newVid;

        videojs("main_vid").ready(function () {
            var myvid = this;
            var currentRate = myvid.playbackRate();
            //console.log(pathsChanged);
            myvid.errorDisplay.close();

            myvid.src([{ type: "video/mp4", src: newVid.path }]);
            myvid.addClass("embed-responsive-item");

            myvid.defaultPlaybackRate = currentRate;
            myvid.play();
            this.playbackRate(currentRate);
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

    $scope.setStart = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;
            var changeTime = Math.round(myvid.currentTime());
            var holdPath, holdIndex;
            for (var i = 0; i < videoPaths.length; i++) {
                if ($scope.model.currentVideo.path == videoPaths[i]) {
                    holdPath = videoPaths[i];
                    $scope.model.currentVideo.path = holdPath.substring(0, holdPath.indexOf('=') + 1) + changeTime + holdPath.substring(holdPath.indexOf(','));
                    videoPaths[i] = holdPath.substring(0, holdPath.indexOf('=') + 1) + changeTime + holdPath.substring(holdPath.indexOf(','));
                    break;
                }
            }
            console.log(videoPaths);
        });
    };


    $scope.setEnd = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;
            var changeTime = Math.round(myvid.currentTime());
            var holdPath, holdIndex;
            for (var i = 0; i < videoPaths.length; i++) {
                if ($scope.model.currentVideo.path == videoPaths[i]) {
                    holdPath = videoPaths[i];
                    $scope.model.currentVideo.path = holdPath.substring(0, holdPath.indexOf(',') + 1) + changeTime;
                    videoPaths[i] = holdPath.substring(0, holdPath.indexOf(',') + 1) + changeTime;
                    break;
                }
            }
            console.log(videoPaths);
        });
    };

    $scope.moveDown = function () {
        videojs("main_vid").ready(function () {
            console.log(videoPaths);
            console.log($scope.model.currentVideo.path);
            var holdPath, holdTitle, holdIndex;
            for (var i = 0; i < videoPaths.length; i++) {
                if ($scope.model.currentVideo.path == videoPaths[i]) {
                    if (i == videoPaths.length - 2) {
                        return;
                    }
                    holdPath = videoPaths[i];
                    holdTitle = videoTitles[i];
                    holdIndex = i;
                    break;
                }
            }
            videoPaths[holdIndex] = videoPaths[i + 1];
            videoTitles[holdIndex] = videoTitles[i + 1];
            videoPaths[holdIndex + 1] = holdPath;
            videoTitles[holdIndex + 1] = holdTitle;
            $scope.setupVideos();
            var myvid = this;
            myvid.play();
            myvid.pause();
        });
    };

    $scope.moveUp = function () {
        videojs("main_vid").ready(function () {
            var holdPath, holdTitle, holdIndex;
            for (var i = 0; i < videoPaths.length; i++) {
                if ($scope.model.currentVideo.path == videoPaths[i]) {
                    if (i == 0) {
                        return;
                    }
                    holdPath = videoPaths[i];
                    holdTitle = videoTitles[i];
                    holdIndex = i;
                    break;
                }
            }
            videoPaths[holdIndex] = videoPaths[i - 1];
            videoTitles[holdIndex] = videoTitles[i - 1];
            videoPaths[holdIndex - 1] = holdPath;
            videoTitles[holdIndex - 1] = holdTitle;
            $scope.setupVideos();
            var myvid = this;
            myvid.play();
            myvid.pause();
        });
    };

    $scope.removeClip = function () {
        videojs("main_vid").ready(function () {
            for (var i = 0; i < videoPaths.length; i++) {
                if ($scope.model.currentVideo.path == videoPaths[i]) {
                    videoPaths.splice(i, 1)
                    videoTitles.splice(i, 1)
                    break;
                }
            }
            $scope.setupVideos();
            var myvid = this;
            myvid.play();
            myvid.currentTime(myvid.src().substring(myvid.src().indexOf(',') + 1));
            //myvid.pause();
            console.log(videoPaths)
        });
    };

}]);

