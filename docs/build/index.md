
<a id='GeoEfficiency.jl-1'></a>

# GeoEfficiency.jl


<a id='Functions-1'></a>

## Functions

<a id='GeoEfficiency.Point' href='#GeoEfficiency.Point'>#</a>
**`GeoEfficiency.Point`** &mdash; *Type*.



```
Point(Height::Real, Rho::Real)
```

construct and return a `Point` source that can be used as either a source by itself or an `anchor point` of a higher dimension source.

  * `Height` : point height relative to the detector surface.
  * `Rho` : point off-axis relative to the detector axis of symmetry.

!!! note
    Each detector type give different interpretation to the `height` as follow:- 

      * for `CylDetector` the point source `height` is consider to be measured   from the detector `face surface`.
      * for `BoreDetector` the point source `height` is consider to be measured   from the `detector middle`, +ve value are above the detector center while -ve are below.
      * for `WellDetector` the point source `height` is considered to be measured   from the detector `hole surface`.


<a id='GeoEfficiency.source' href='#GeoEfficiency.source'>#</a>
**`GeoEfficiency.source`** &mdash; *Function*.



```
source(anchorPnt::Point = Point())
```

return a tuple that describe the source (`anchorPnt`, `SrcRadius`, `SrcLength`) according to  the input from the `console`.

  * `anchorPnt` : the source anchoring point. if it is missing the user is prompt   to input it via the `console`.
  * `SrcRadius` : source radius.
  * `SrcLength` : source length.

!!! warning
    If the global variable `srcType` is set to $srcPoint$, both `SrcRadius` and `SrcLength`  are set to zero.


<a id='GeoEfficiency.CylDetector' href='#GeoEfficiency.CylDetector'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Type*.



```
CylDetector(CryRadius::Real, CryLength::Real)
```

construct and return a `cylindrical` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.

!!! warning
    both `CryRadius` and `CryLength` should be `positive`, while `CryLength` can be set to $zero$.


<a id='GeoEfficiency.BoreDetector' href='#GeoEfficiency.BoreDetector'>#</a>
**`GeoEfficiency.BoreDetector`** &mdash; *Type*.



```
BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

construct and return a `bore-hole` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.
  * `HoleRadius` : the detector hole radius.

!!! warning
    `CryRadius` and `CryLength`, `HoleRadius` should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius`.


<a id='GeoEfficiency.WellDetector' href='#GeoEfficiency.WellDetector'>#</a>
**`GeoEfficiency.WellDetector`** &mdash; *Type*.



```
WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

construct and return a `Well-Type` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.
  * `HoleRadius` : the detector hole radius.
  * `HoleDepth` : the detector hole length.

!!! warning
    all arguments should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius` and  `CryLength` should be greater than  `HoleDepth`.



<a id='Manual-1'></a>

## Manual


  * [GeoEfficiency.md]
  * [Physics_Model]
  * [Input_Interface]
  * [Calculations]
  * [Output_Interface]

