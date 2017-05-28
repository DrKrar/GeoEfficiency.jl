
<a id='[Physics-module]-1'></a>

# [Physics module]

<a id='GeoEfficiency.Point' href='#GeoEfficiency.Point'>#</a>
**`GeoEfficiency.Point`** &mdash; *Type*.



```
Point(Height::Real, Rho::Real)
```

construct and return a `Point` source that can be a source of itself or an `anchor point` of a source.

`Height` : point height relative to the detector.

`Rho` : point off axis relative to the detector axis of symmetry.

**Note please**

Each detector type give interpretation to the height in a different way as follow:

  * for `CylDetector` the point source `height` is consider to be measured from the detector `face surface`.
  * for `BoreDetector` the point source `height` is consider to be measured from the `detector middle`, +ve value are above the detector center while -ve are below.
  * for `WellDetector` the point source `height` is considered to be measured from the detector `hole surface`.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L12-L31' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.source' href='#GeoEfficiency.source'>#</a>
**`GeoEfficiency.source`** &mdash; *Function*.



```
source(;isPoint=false)
```

return a tuple describing the source (`anchorPnt`, `SrcRadius`, `SrcLength`) based on the user input to the `console`.

`aPnt` : the source anchoring point.

`SrcRadius` : source radius.

`SrcLength` : source length.

If `isPoint` is true both `SrcRadius` and `SrcLength` are set to zero.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L83-L95' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Detector' href='#GeoEfficiency.Detector'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Type*.



```
RadiationDetector()
```

or	 	Detector()

construct and return an object of the RadiationDetector type (`CylDetector`, `BoreDetector` or `WellDetector`) according to the input from the console.

**Note please**

  * this methode aquire all required information from the `console` and will prompt user on invalid data.
  * if any method with argument(s) take an `invalid` argument it would throw an error.
  * if the value the last argument is `zero` of a method with `more` than one argument it behave as a missing argument.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L264-L279' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real)
```

or	 	Detector(CryRadius::Real)

return cylindrical detector with CryLength` equal to zero.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L296-L302' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real)
```

or	 	Detector(CryRadius::Real, CryLength::Real)

return cylindrical detector.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L305-L311' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

or	 	Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)

return bore-hole or cylindrical detector if `HoleRadius` = 0.0


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L314-L320' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

return well-type or bore-hole or cylindrical detector according to the arguments.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L325-L330' class='documenter-source'>source</a><br>


```
RadiationDetector(detector::RadiationDetector)
Detector(detector::RadiationDetector)
```

return just the inputed detector


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L335-L340' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.CylDetector' href='#GeoEfficiency.CylDetector'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Type*.



```
CylDetector(CryRadius::Real, CryLength::Real)
```

return a `cylindrical` detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L126-L134' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.BoreDetector' href='#GeoEfficiency.BoreDetector'>#</a>
**`GeoEfficiency.BoreDetector`** &mdash; *Type*.



```
BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

return a `bore-hole` detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.

`HoleRadius` : the detector hole radius.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L173-L183' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.WellDetector' href='#GeoEfficiency.WellDetector'>#</a>
**`GeoEfficiency.WellDetector`** &mdash; *Type*.



```
WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

return a Well-Type detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.

`HoleRadius` : the detector hole radius.

`HoleDepth` : the detector hole length.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L216-L228' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.RadiationDetector' href='#GeoEfficiency.RadiationDetector'>#</a>
**`GeoEfficiency.RadiationDetector`** &mdash; *Type*.



```
RadiationDetector()
```

or	 	Detector()

construct and return an object of the RadiationDetector type (`CylDetector`, `BoreDetector` or `WellDetector`) according to the input from the console.

**Note please**

  * this methode aquire all required information from the `console` and will prompt user on invalid data.
  * if any method with argument(s) take an `invalid` argument it would throw an error.
  * if the value the last argument is `zero` of a method with `more` than one argument it behave as a missing argument.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L264-L279' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real)
```

or	 	Detector(CryRadius::Real)

return cylindrical detector with CryLength` equal to zero.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L296-L302' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real)
```

or	 	Detector(CryRadius::Real, CryLength::Real)

return cylindrical detector.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L305-L311' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

or	 	Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)

return bore-hole or cylindrical detector if `HoleRadius` = 0.0


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L314-L320' class='documenter-source'>source</a><br>


```
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

return well-type or bore-hole or cylindrical detector according to the arguments.


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L325-L330' class='documenter-source'>source</a><br>


```
RadiationDetector(detector::RadiationDetector)
Detector(detector::RadiationDetector)
```

return just the inputed detector


<a target='_blank' href='https://github.com/JuliaLang/julia/tree/7a05f686a27d9e070efb523b51420f90d9310e43/base/docs/Docs.jl#L335-L340' class='documenter-source'>source</a><br>

