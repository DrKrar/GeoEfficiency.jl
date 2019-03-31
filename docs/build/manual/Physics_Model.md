
<a id='Physics_Module-1'></a>

# Physics_Module

<a id='GeoEfficiency.Point' href='#GeoEfficiency.Point'>#</a>
**`GeoEfficiency.Point`** &mdash; *Type*.



```julia
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



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L18-L37' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.source' href='#GeoEfficiency.source'>#</a>
**`GeoEfficiency.source`** &mdash; *Function*.



```julia
source(anchorPnt::Point = Point())
```

return a tuple that describe the source (`anchorPnt`, `SrcRadius`, `SrcLength`) according to  the input from the `console`.

  * `anchorPnt` : the source anchoring point. if it is missing the user is prompt   to input it via the `console`.
  * `SrcRadius` : source radius.
  * `SrcLength` : source length.

!!! warning
    If the global variable `srcType` is set to $srcPoint$, both `SrcRadius` and `SrcLength`  are set to zero.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L100-L115' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.CylDetector' href='#GeoEfficiency.CylDetector'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Type*.



```julia
CylDetector(CryRadius::Real, CryLength::Real)
```

construct and return a `cylindrical` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.

!!! warning
    both `CryRadius` and `CryLength` should be `positive`, while `CryLength` can also be set to **`zero`**.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L160-L172' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.BoreDetector' href='#GeoEfficiency.BoreDetector'>#</a>
**`GeoEfficiency.BoreDetector`** &mdash; *Type*.



```julia
BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

construct and return a `bore-hole` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.
  * `HoleRadius` : the detector hole radius.

!!! warning
    `CryRadius` and `CryLength`, `HoleRadius` should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L220-L234' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.WellDetector' href='#GeoEfficiency.WellDetector'>#</a>
**`GeoEfficiency.WellDetector`** &mdash; *Type*.



```julia
WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

construct and return a `Well-Type` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.
  * `HoleRadius` : the detector hole radius.
  * `HoleDepth` : the detector hole length.

!!! warning
    all arguments should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius` and  `CryLength` should be greater than  `HoleDepth`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L273-L289' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.RadiationDetector' href='#GeoEfficiency.RadiationDetector'>#</a>
**`GeoEfficiency.RadiationDetector`** &mdash; *Type*.



abstract super-supertype of all detectors types


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L142' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Detector' href='#GeoEfficiency.Detector'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Type*.



```julia
Detector
```

abstract supertype of all detectors types of cylidericalish shapes. also can be used to construct any leaf type.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/170767107041c25c1b27b1db64cbef507f9688da/src/Physics_Model.jl#L145-L152' class='documenter-source'>source</a><br>

