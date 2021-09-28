# Change Log

## v2.0.1

 - remove deprecated `ldLoader`


## v2.0.0

 - fix bug: `root` or `container` params with `NodeList` value are not treated as array, which should.
 - support `zmgr` directly in object.
 - use zmgr fallback instead of old zstack to simplify code logic
 - rename `ldloader` zmgr api ( from `set-zmgr` to `zmgr` )
 - rename `ldld.js`, `ldld.css` to `index.js`, `index.css`, including minimized version.


## v1.2.1

 - deprecate `ldLoader`. use `ldloader` instead.
 - use livescript to wrap code instead of manually do it.
 - organize `demo` to `web` folder.


## v1.2.0

 - add `setZmgr` for managing z-index globally.
 - fix bug: when `auto-z` is set to true, z value isn't calculated correctly.


## v1.1.1

 - only release `dist` files


## v1.1.0

 - use semantic delay
 - fix bug: for non-atomic loader, count should never small than 0
 - add `cancel` api

