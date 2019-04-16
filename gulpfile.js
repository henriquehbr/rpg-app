var gulp = require("gulp");
var pug = require("gulp-pug");
var stylus = require("gulp-stylus");
var coffee = require("gulp-coffee");
var terser = require("gulp-terser");

// Compile the index .pug file from "src" to "/" 
gulp.task("pug-index", function () {
	return gulp.src("src/index.pug")
		.pipe(pug())
		.pipe(gulp.dest("."))
});

// Compile .pug files (Pug templates) from "src" to "dist"
gulp.task("pug", function () {
	return gulp.src(["src/*.pug", "!src/index.pug"])
		.pipe(pug())
		.pipe(gulp.dest("dist"))
});

// Compile .styl files (Stylus stylesheets) from "src" to "dist"
gulp.task("stylus", function () {
	return gulp.src("src/css/[^_]*.styl")
		.pipe(stylus({
			compress: true
		}))
		.pipe(gulp.dest("dist/css"));
});

// Compile .coffee files (Coffeescript scripts) and minify the js output from "src" to "dist"
gulp.task("coffee", function () {
	return gulp.src("src/js/*.coffee")
		.pipe(coffee())
		.pipe(terser())
		.pipe(gulp.dest("dist/js"));
});

// Compile Pug templates, stylus stylesheets and Coffeescript scripts at once
gulp.task("build", gulp.parallel("pug-index", "pug", "stylus", "coffee"));

// Watch for any file change on the "src" directory
gulp.task("watch", function () {
	gulp.watch("src/index.pug", gulp.parallel("pug-index"));
	gulp.watch(["src/*.pug", "!src/index.pug"], gulp.parallel("pug"));
	gulp.watch("src/css/*.styl", gulp.parallel("stylus"));
	gulp.watch("src/js/*.coffee", gulp.parallel("coffee"));
});

// Run the build task and watch for file changes
gulp.task("default", gulp.parallel("build", "watch"));