/*
expose, v0.1.1
by Riki Fridrich <riki@fczbkk.com> (http://fczbkk.com)
https://github.com/fczbkk/expose/
*/
(function () {
  "use strict";
  var expose;

  expose = function (lib, lib_name) {
    var noConflict;
    noConflict = function (root) {
      var original_lib;
      original_lib = root[lib_name];
      lib.noConflict = function () {
        root[lib_name] = original_lib;
        return lib;
      };
      return root[lib_name] = lib;
    };

    if (typeof window === 'object') {
      noConflict(window, lib, lib_name);
    } else if (typeof global === 'object') {
      noConflict(global, lib, lib_name);
    }
  };

  expose(expose, 'expose');
})();