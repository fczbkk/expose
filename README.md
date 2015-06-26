# Expose

JavaScript helper for exposing objects to global namespace.

Depending on current environment, it will:

- use `module.exports` in NodeJS
- use `define.AMD` in RequireJS / AMD
- use `window` in browser
- use `global` in headless browser (e.g. PhantomJS)

It will also provide `noConflict()` method for easy global namespace resolution.

## How to use it

```javascript
// original JS library
var OriginalLibrary = {...};

(function () {

  // your JS library defined in anonymous namespace
  var Library = {...};

  // expose Library into global namespace under the name MyLibrary
  expose(Library, 'OriginalLibrary');

})();

// your library is now exposed into global namespace under selected name
Library;          // -> undefined
OriginalLibrary;  // -> your library

// if you need, you can restore the original library
// and expose your own under a new name
var MyLibrary = OriginalLibrary.noConflict();

OriginalLibrary;  // -> original library
MyLibrary;        // -> your library
```


## Bug reports, feature requests and contact

If you found any bugs, if you have feature requests or any questions, please, either [file an issue at GitHub](https://github.com/fczbkk/expose/issues) or send me an e-mail at [riki@fczbkk.com](mailto:riki@fczbkk.com).

## License

Element Monitor is published under the [MIT license](LICENSE.txt).
