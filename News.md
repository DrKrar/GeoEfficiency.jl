# GeoEfficiency Package Release Notes

### Version 0.8.8-dev 
 *  now the function `calcN` will not terminate if a calculation error happened.
 *  creat the spectial function `CONFIG` to configure the package.
 *  label the function `CONFIG` as experimental and should not used interactively.
 *  support for julia 0.4 and julia 0.5 dropped.
 
 
### Version 0.8.7
 *  new function `about()` give information about the sofftware Package.
 *  new function `SetSrcToPoint()` to set source type.
 *  function `source()`, now did not take keyword argument insteade it depened on the global variable `isPoint`. 
 *  function source(), now can take a point as its anchor poiint and if missing ask for one from the console.
 *  `RadiationDetector()` is unexported now. still `Detector()` is available. 


### Version 0.8.6
 *  When `batch` taking arrguments, all the arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array`, `srcLengths_array` element type should be float64. If any of them have Real element type it should be converted to `float64` using `float` before passing it to the `batch` function.

### Version 0.8.5
 *  `Detector()` can be used to constructe a new detector.
