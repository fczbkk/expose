module.exports = (config) ->
  config.set
    basePath: '.'
    # reportSlowerThan: 100
    reporters: [
      'mocha'
    ]
    frameworks: [
      'jasmine'
    ]
    browsers: [
      # 'Chrome'
      # 'Firefox'
      # 'Safari'
      # 'Opera'
      'PhantomJS'
    ]
    files: [
      'temp/**/*.js'
      'test/**/*.js'
    ]
