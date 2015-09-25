var VidApp = angular.module('VidApp', ['ngRoute']);

VidApp.controller('VideoCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {


    var paths = $location.search().paths.split(',');
    var titles = $location.search().titles.split(',');
    console.log(paths);
    console.log(titles);

    //var single_path = $location.search().paths.split(',')[0].replace(/ /g, '').replace(/"/, '');

    //var cutoff_location = single_path.indexOf("App_Data");

    //console.log(single_path);

    //$http.get('/Service1.svc/DoWork').
    //    success(function (response) {
    //        $scope.videos = response.d;
    //        $scope.currentVideo = $scope.videos[0]

    //        videojs("main_vid", { }, function () {
    //            this.src([{ type: "video/mp4", src: $scope.currentVideo }]);
    //            this.height("auto");
    //            this.width("auto"); 
    //        });
    //    });

    $scope.videos = [];
    $scope.currentVideo = null;

    for (var i = 0; i < paths.length; i++) {
        if (paths[i].replace(/ /g, '') != "") {
            vid_info = {
                path: "/Content" + paths[i].replace(/ /g, '').replace(/"/, '').replace(/\\/g, "/").split("MAJORS")[1],
                title: titles[i].trim()
            }
            $scope.videos.push(vid_info);

        }            
    }
    //    .map(function (path) {
    //    path
    //});


    console.log($scope.videos);
    $scope.currentVideo = $scope.videos[0];


    videojs("main_vid", { }, function () {
        this.src([{ type: "video/mp4", src: $scope.currentVideo.path }]);
        this.height("auto");
        this.width("auto"); 
    });


    $scope.setCurrentVideo = function (newVid) {
        $scope.currentVideo = newVid
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
}]);