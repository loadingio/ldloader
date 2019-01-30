# ldCover

vanilla popup / dialog library.


## Usage

TBD.

## Spec. and structure

A simple ldCover popup are built with following html structure:

 * .ldcv          - topmost, fullscreen container
   * .base        - control the overall size and position for this box ( could be omit )
     *  .inner     - dialog container. constraint size. transition animation goes here


one can decorate ldCover widgets by adding classes over the outmost element. following classes are defined by default:

 * .ldcv.bare:
   - no covered bk.
   - custom position for .ldcv > .base
   - overflow: visible for .ldcv > .base > .inner (why?)

 * .ldcv.transform-center
   - by default .base is centered with margin: auto. this needs us to provide width/height for .base.
   - with transform-center, .base is centered with left: 50%, top: 50% + transform: translate(-50%,-50%), which don't need width/height to be provided anymore.
   - NOTE: this might causes content to be blur, so use it carefully.


## Todo

 * implement all this nice transitional effect:
   - https://tympanus.net/Development/ModalWindowEffects/
   - https://tympanus.net/Development/PageTransitions/


## License

MIT
