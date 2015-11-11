﻿var gulp = require('gulp');
var sass = require('gulp-sass');
var browserify = require('gulp-browserify');
var concat = require('gulp-concat');
var minifyCSS = require('gulp-minify-css');
// var watch = require('gulp-watch');
var del = require('del');
var config = {
    bootstrapDir: './bower_components/bootstrap-sass',
    customThemeDir: './Theme'
};

var outputLocation = 'dist';

gulp.task('clean', function () {
    del.sync([outputLocation + '/**']);
});

gulp.task('vendor-scripts', function () {
    var vendorSources = {
        jquery: ['bower_components/jquery/dist/jquery.min.js',
	            'bower_components/jquery-validation/dist/jquery.validate.min.js',
	            'bower_components/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js',
                'bower_components/angular/angular.js', 'bower_components/angular-route/angular-route.js']
    }

    gulp.src(vendorSources.jquery)
		.pipe(concat('vendor.bundle.min.js'))
		.pipe(gulp.dest(outputLocation + '/scripts/'));
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

