var VidApp = angular.module('VidApp', ['ngRoute']);

VidApp.controller('VideoCtrl', ['$scope', '$http', '$location', function ($scope, $http, $location) {


    var paths = $location.search().paths;
    var titles = $location.search().titles;
    var network_path = false;

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

    $scope.model = {
        currentVideo: undefined
    };

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
    //    .map(function (path) {
    //    path
    //});


    console.log($scope.videos);
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

