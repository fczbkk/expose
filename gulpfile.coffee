gulp = require 'gulp'
gutil = require 'gulp-util'
rimraf = require 'rimraf'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
concat = require 'gulp-concat'
wrap = require 'gulp-wrap'
karma = require('karma').server
uglify = require 'gulp-uglify'
beautify = require 'gulp-beautify'
stripDebug = require 'gulp-strip-debug'
header = require 'gulp-header'
stripComments = require 'gulp-strip-comments'


banner =
  """
    /*
    <%= pkg.name %>, v<%= pkg.version %>
    by <%= pkg.author %>
    <%= pkg.homepage %>
    */

  """


iife_template =
  '
    (function(){
      "use strict";
      <%= contents %>
    })();
  '


karma_config_file = "#{__dirname}/karma.config.coffee"


gulp.task 'default', ['test', 'watch', 'compile']


gulp.task 'clean', ['cleanLib', 'cleanTest']


gulp.task 'cleanLib', (done) ->
  rimraf './temp', done


gulp.task 'cleanTest', (done) ->
  rimraf './test', done


gulp.task 'compile', ['compileLib', 'compileTest']


gulp.task 'compileLib', ['cleanLib'], ->
  files_list = [
    './src/lib/expose.coffee'
  ]

  gulp.src files_list
    .pipe sourcemaps.init()
    .pipe coffee({bare: true}).on 'error', gutil.log
    .pipe concat 'expose.js'
    .pipe stripDebug()
    .pipe wrap iife_template
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './temp/'


gulp.task 'compileTest', ['cleanTest'], ->
  gulp.src './src/test/**/*.coffee'
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest './test/'


gulp.task 'watch', ['watchLib', 'watchTest']


gulp.task 'watchLib', ->
  gulp.watch './src/lib/**/*.coffee', ['compileLib']


gulp.task 'watchTest', ->
  gulp.watch './src/test/**/*.coffee', ['compileTest']


gulp.task 'run_test', ['compile'], (done) ->
  config =
    configFile: karma_config_file
    singleRun: true
    autoWatch: false
  karma.start config, done


gulp.task 'test', (done) ->
  config =
    configFile: karma_config_file
    singleRun: false
    autoWatch: true
  karma.start config, done


gulp.task 'build', ['compile', 'run_test'], ->
  gulp.src './temp/**/*.js'
    .pipe stripComments()
    # .pipe uglify()
    .pipe beautify {indentSize: 2}
    .pipe header banner, {pkg: require './package.json'}
    .pipe gulp.dest './lib/'
