var VidApp = angular.module('VidApp', ['ngRoute']);

VidApp.controller('PathCtrl', ['$scope', function ($scope) {
    $scope.sentVideos = [];
    for (var i = 0; i < videoPaths.length; i++) {
        if (videoPaths[i] != "") {
            $scope.sentVideos.push(
                {
                    path: videoPaths[i],
                    title: videoTitles[i]
                }
            );

        }
    };


}]);

VidApp.controller('VideoCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {
    var paths = $location.search().paths;
    var titles = $location.search().titles;
    var network_path = false;

    $scope.model = {
        currentVideo: undefined
    };



    if (paths) {
        path = paths.split(',');
        network_path = true;
    }       
    else
        paths = ["/Images/1288A.mp4", "/Images/1289A.mp4", "/Images/1290A.mp4", "/Images/1291A.mp4"];
    
    if (titles)
        titles = titles.split(',');
    else
        titles = ["Example Video 1", "Example Video 2", "Example Video 3", "Example Video 4"];

    alert(paths);

    $scope.videos = [];
    $scope.currentVideo = null;


    for (var i = 0; i < paths.length; i++) {
        if (paths[i].replace(/ /g, '') != "") {
            if (network_path) {
                vid_info = {
                    path: "/Content" + paths[i].replace(/ /g, '').replace(/"/, '').replace(/\\/g, "/").split("MAJORS")[1],
                    title: titles[i].trim()
                }
            } else {
                vid_info = {
                    path: paths[i],
                    title: titles[i].trim()
                }
            }
            $scope.videos.push(vid_info);

        }            
    }

    $scope.model.currentVideo = $scope.videos[0];

    videojs("main_vid", { }, function () {
        this.src([{ type: "video/mp4", src: $scope.model.currentVideo.path }]);
        this.height("auto");
        this.width("auto");
        this.play();

        this.on('ended', function () {
            $scope.$apply(function () {
                var next_vid_index = ($scope.videos.indexOf($scope.model.currentVideo) + 1) % $scope.videos.length;
                $scope.setCurrentVideo($scope.videos[next_vid_index]);

            });
        });
    });


    $scope.setCurrentVideo = function (newVid) {
        $scope.model.currentVideo = newVid;

        videojs("main_vid").ready(function () {
            var myvid = this;

            this.src([{ type: "video/mp4", src: newVid.path }]);
            this.addClass("embed-responsive-item");
            this.play();
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

            this.play();
        });
    };

    $scope.pause = function () {
        videojs("main_vid").ready(function () {
            var myvid = this;

            this.pause();
        });
    };

    $scope.GetClass = function (val) {
        console.log(val);
        var ret;
        console.log(val == $scope.model.currentVideo)
        if (val == $scope.model.currentVideo)
            ret = 'active';
        else
            ret = '';
        console.log(ret);
        return ret;
    };
}]);

