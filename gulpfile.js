var gulp			= require('gulp'),
	sass			= require('gulp-ruby-sass'),
	autoprefixer	= require('gulp-autoprefixer'),
	minifycss		= require('gulp-minify-css'),
	rename			= require('gulp-rename'),
	del				= require('del');

var	exercises				= './',
	exercises_scss			= exercises + 'scss/',
	exercises_css			= exercises + 'css/';

// Styles
gulp.task('styles', function() {
	return gulp.src( exercises_scss + '*.scss')
		.pipe(sass({style: 'expanded'}))
		.on('error', function(err) { console.log(err.message); })
		.pipe(gulp.dest( exercises_css ));
});

// Clean
gulp.task('clean', function() {
	del([
		exercises_css + '*.css',
		exercises_css + '*.map'
	], function( err ) {
		console.log( 'Exercise files deleted.' );
	});
});

// Default
gulp.task('default', ['clean'], function() {
	gulp.start('styles');
});
