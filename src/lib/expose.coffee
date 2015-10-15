expose = (lib, lib_name) ->

  # helper function used when exposing to browser
  noConflict = (root) ->
    original_lib = root[lib_name]

    lib.noConflict = ->
      root[lib_name] = original_lib
      lib

    root[lib_name] = lib


  # Node.js
  if module?.exports
    module.exports = lib

  # AMD / RequireJS
  if define?.amd
    define lib_name, [], -> lib

  # windowed browser
  if typeof window is 'object'
    noConflict window, lib, lib_name

  # headless browser (e.g. Phantom)
  else if typeof global is 'object'
    noConflict global, lib, lib_name

  return


# expose self
expose expose, 'expose'
