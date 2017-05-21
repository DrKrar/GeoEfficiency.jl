# Release notes for GeoEfficiency Package

### Version 0.86-Dev
* When batch taking arrguments. Any of the arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array`, `srcLengths_array` element type should be float64. If any of them have Real element type it should converted float64 to using `float` befor passing to the `batch` function.

### Version 0.85
* Detector() can be used to constructe a new detector.