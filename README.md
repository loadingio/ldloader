# ldLoader

handy library to manipulate loader's state.


## Usage

create an object for each loader you want to use:

````
    var ldld = new ldLoader(config);
````


config includes following options:

 * root: element for your loader. default null
   - could be css selector, element, or array of css selectors/elements.
   - ldLoader will create one automatically if omitted, and append it under container.
   - if root is an array, ldLoader instance will work on every element in the array.
 * container: where root should be put in. default null.
   - will be root.parentNode if omitted.
   - will be document.body if both root and container is omitted.
 * class-name: additional class over root. default '' and is optional.
   - you can also add classes directly onto the root element you provided.
 * active-class: class added to root when loader is toggled on. default 'running'.
   - useful when working with different css libraries.
 * inactive-class: class added to root when loader is toggled off. default is null.
 * auto-z: update root's z-index automatically. default true.
 * base-z: the minimal z-index of root. default 10000.
   - with auto-z, ldLoader keeps track of all loaders' z-index and always use larger z-index for newly toggled loaders. base-z is then used as a base value for all auto-z loaders.
 * ctrl: custom animation control unit. should at least contains a member function "step(t)".
   - step(t): will be invoked repeatedly by requestAnimationFrame during loading period. context (aka this) will be root.
 * atomic: default true. when atomic is false, you will need N ldLoader.off() call to dismiss ldLoader if there was already N ldLoader.on() call.

Methods:
 * on(delay): toggle loader on. return promise. (if delay is provided, on then resolve after delay(ms). )
 * off(delay): toggle loader off. (if delay is provided, resolve after delay(ms), then off. )
 * is-on: return true if loader is running, else false.
 * toggle(state,delay): toggle loader based on state(true/false). toggle according to current state if state is omitted. return promise ( delay behavior according to whether it's on or off )
 * on(event, cb): listen to events, including: ( TBD? conflict with on(delay) )
   - toggle.on
   - toggle.off

## Styling and Structure

There is no constraint about how ldLoader's DOM structure should be. Basically it contains an element for loader, and the element's parent in which the loader is shown. You control all the animation and effects based on ```active-class``` toggled by ldLoader.

For convenience, ldLoader is shipped with some builtin css for simple usage:

 * .ldld.bare - rotating double ring, placed at where it should be.
 * .ldld.default - rotating double ring centered in it's container. container should have style position: relatve/absolute/fixed.
 * .ldld.full - dimed full screen blocking loader, with rotating double ring in the middle.
 * size modifier for .ldld.bare  and .ldld.default:
   * .sm - 16 x 16
   * .em-1 - 1em x 1em ( useful in button )
   * .em-2 - 2em x 2em
 * color modifier:
   * without color modifier, it will `currentColor` by default.
   * .ldld.light - rgba(255,255,255,.5)
   * .ldld.dark - rgba(0,0,0,.5)

You can also use ldLoader along with ```loading-btn``` and ```loading.css```:

```
    <div class="btn ld-ext-right">
      Load
      <div class="ld ld-ball ld-bounce"></div>
    </div>
    <script>
      var ldld = new ldLoader({root: ".ld-ext-right"});
      ldld.on(); ldld.off(1000);
    </script>
```
 

## License

MIT
