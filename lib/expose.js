/*
expose, v0.1.3
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
    if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
      module.exports = lib;
    }
    if (typeof define !== "undefined" && define !== null ? define.amd : void 0) {
      define(lib_name, [], function () {
        return lib;
      });
    }
    if (typeof window === 'object') {
      noConflict(window, lib, lib_name);
    } else if (typeof global === 'object') {
      noConflict(global, lib, lib_name);
    }
  };

  expose(expose, 'expose');
})();