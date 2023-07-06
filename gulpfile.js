var gulp = require('gulp'),
    markdown = require('gulp-remarkable'),
    frontMatter = require('gulp-front-matter'),
    layout = require('gulp-layout');

gulp.task('Build Markdown CV', function () {
    return gulp.src('./output/*.md')
        .pipe(frontMatter())
        .pipe(markdown({
            html: true
        }))
        .pipe(layout(function (file) {
            return file.frontMatter;
        }))
        .pipe(gulp.dest('./output'));
});

gulp.task('default', function() {
    gulp.watch('src/output/*.md', gulp.series('Build Markdown CV'));
});