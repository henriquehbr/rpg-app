var gulp = require("gulp");
var pug = require("gulp-pug");
var stylus = require("gulp-stylus");
var coffee = require("gulp-coffee");
var uglifyjs = require("gulp-uglify");

// Compile .pug files (Pug templates) from "src" to "dist"
gulp.task("pug", function buildHTML() {
	return gulp.src("src/*.pug")
		.pipe(pug())
		.pipe(gulp.dest("dist"))
});

// Compile .styl files (Stylus stylesheets) from "src" to "dist"
gulp.task("stylus", function () {
	return gulp.src("src/css/*.styl")
		.pipe(stylus({
			compress: true
		}))
		.pipe(gulp.dest("dist/css"));
});

// Compile .coffee files (Coffeescript scripts) and uglify the js output from "src" to "dist"
gulp.task("coffee", function () {
	return gulp.src("src/js/*.coffee")
		.pipe(coffee())
		.pipe(uglifyjs())
		.pipe(gulp.dest("dist/js"));
});

// Compile Pug templates, stylus stylesheets and Coffeescript scripts at once
gulp.task("build", gulp.parallel("pug", "stylus", "coffee"));

// Watch for any file change on the "src" directory
gulp.task("watch", function () {
	gulp.watch("src/*.pug", gulp.parallel("pug"));
	gulp.watch("src/css/*.styl", gulp.parallel("stylus"));
	gulp.watch("src/js/*.coffee", gulp.parallel("coffee"));
});

// Run the build task and watch for file changes
gulp.task("default", gulp.parallel("build", "watch"));