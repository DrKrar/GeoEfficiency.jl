# Release notes for GeoEfficiency Package

### Version 0.8.7-Dev
 *  new function about() give information about the sofftware Package.
 *  new function SetSrcToPoint() to set source type.
 *  function source(), now did not take keyword argument insteade it depened on the global variable `isPoint`. 
 *  function source(), now can take a point as its anchor poiint and if missing ask for one from the console.
 *  RadiationDetector(), is un exported now. still Detector() is available. 


### Version 0.8.6
* When batch taking arrguments. Any of the arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array`, `srcLengths_array` element type should be float64. If any of them have Real element type it should converted float64 to using `float` befor passing to the `batch` function.

### Version 0.8.5
* Detector() can be used to constructe a new detector.