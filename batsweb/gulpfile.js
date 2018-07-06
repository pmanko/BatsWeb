var gulp = require('gulp');
var sass = require('gulp-sass');
var browserify = require('gulp-browserify');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-minify-css');
var watch = require('gulp-watch');
var del = require('del');
var config = {
    bootstrapDir: './node_modules/bootstrap-sass',
    customThemeDir: './Theme'
};

var outputLocation = 'dist';

gulp.task('clean', function () {
    del.sync([outputLocation + '/**']);
});

gulp.task('vendor-scripts', function () {
    var vendorSources = {
        jquery: ['node_modules/jquery/dist/jquery.min.js',
	            'node_modules/jquery-validation/dist/jquery.validate.min.js',
	            'node_modules/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js', 
				'node_modules/jquery-ui/jquery-ui.js'
        ],
		jquery_ui_styles: ['node_modules/jquery-ui/themes/ui-lightness'],
        angular: ['node_modules/angular/angular.js', 'node_modules/angular-route/angular-route.js'],
        videojs: ['node_modules/video.js/dist/video.js', 'node_modules/videojs-flash/dist/videojs-flash.js'],
        videojsflash: ["node_modules/video.js/dist/video-js.swf"],
        videojscss: ["node_modules/video.js/dist/video-js.min.css"],
        videojsfonts: ["node_modules/video.js/dist/font"],
        fontawesomecss: ["node_modules/components-font-awesome/css/font-awesome.min.css"],
        fontawesome: ["node_modules/components-font-awesome/fonts"]
    }

    gulp.src(vendorSources.jquery)
		.pipe(concat('jquery.bundle.min.js'))
		.pipe(gulp.dest(outputLocation + '/scripts/'));

    gulp.src(vendorSources.angular)
        .pipe(concat('angular.bundle.min.js'))
        .pipe(gulp.dest(outputLocation + '/scripts/'));

    gulp.src(vendorSources.videojs)
        .pipe(concat('videojs.bundle.min.js'))
        .pipe(gulp.dest(outputLocation + '/scripts/'));

    gulp.src(vendorSources.videojsflash)
        .pipe(gulp.dest(outputLocation + '/swf/'));

    gulp.src(vendorSources.videojscss)
        .pipe(gulp.dest(outputLocation + '/styles/'));

	gulp.src(vendorSources.jquery_ui_styles)
		.pipe(gulp.dest(outputLocation + '/styles/'));

    gulp.src(vendorSources.videojsfonts + "/*")
        .pipe(gulp.dest(outputLocation + '/styles/font/'));
        
    gulp.src(vendorSources.fontawesomecss)
        .pipe(gulp.dest(outputLocation + '/styles/'));

    gulp.src(vendorSources.fontawesome + "/*")
        .pipe(gulp.dest(outputLocation + '/fonts/'));

});


gulp.task('scripts', function () {
    gulp.src(['Scripts/**/*.js', 'Scripts/*.js'])
        .pipe(browserify())
        .pipe(gulp.dest(outputLocation + '/scripts/'))
})

gulp.task('styles', function () {
    gulp.src(['Styles/*.css'])
        .pipe(minifyCSS())
        .pipe(gulp.dest(outputLocation + '/styles/'))
})

gulp.task('bootstrap-fonts', function () {
    return gulp.src(config.bootstrapDir + '/assets/fonts/**/*')
    .pipe(gulp.dest(outputLocation + '/fonts'));
});

gulp.task('bootstrap-stylesheets', function () {
    return gulp.src('./Styles/app.scss')
    .pipe(sass({
        includePaths: [config.bootstrapDir + '/assets/stylesheets', config.customThemeDir + '/stylesheets'],
    }))
    .pipe(gulp.dest(outputLocation + '/styles/'));
});

gulp.task('bootstrap-scripts', function () {
    gulp.src(config.bootstrapDir + '/assets/javascripts/bootstrap.min.js')
    .pipe(gulp.dest(outputLocation + '/scripts/'));
});

gulp.task('bootstrap', ['bootstrap-stylesheets', 'bootstrap-fonts', 'bootstrap-scripts'], function () { });

gulp.task('default', ['clean', 'vendor-scripts', 'styles', 'scripts', 'bootstrap'], function () { });

gulp.task('watch', function () {
    gulp.watch(config.customThemeDir + '/stylesheets/*scss', 'bootstrap-stylesheets');
    gulp.watch('Styles/*.css', [styles]);
    gulp.watch("Scripts/**/*.js", [scripts]);

});

