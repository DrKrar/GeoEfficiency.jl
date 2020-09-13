
<a id='Physics-Model-1'></a>

# Physics Model


Geometrical efficiency of radioactive source measurement is a type of detection efficiency. A fully describe a radioactive source measurement at the most basic level three component should be provided. 


  * radioactive detector description
  * radiation source description
  * relative position of the source to detector.


this section will discus how to instruct the program to construct each of the aforementioned component.


<a id='Detector-1'></a>

# Detector


Currently, only cylindrical-like types of detectors are supported.  


<a id='Cylindrical-Detector-1'></a>

## Cylindrical Detector


To construct a **cylinder** detector type `CylDetector(CryRadius, CryLength)`

<a id='GeoEfficiency.CylDetector' href='#GeoEfficiency.CylDetector'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Type*.



```
CylDetector(CryRadius::Real, CryLength::Real)
```

construct and return a `cylindrical` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.

!!! warning "Invalid Arguments"
    both `CryRadius` and `CryLength` should be `positive`, while `CryLength` can also be set to **`zero`**.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L167-L180' class='documenter-source'>source</a><br>


To construct a planer **cylinder**  detector or **Disc** `CylDetector(CryRadius)`

<a id='GeoEfficiency.CylDetector-Tuple{Real}' href='#GeoEfficiency.CylDetector-Tuple{Real}'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Method*.



```
CylDetector(CryRadius::Real)
```

construct and return a `cylindrical` (really `disk`) detector with crystal length equal to **`zero`**.

**see also:** [`CylDetector(CryRadius::Real, CryLength::Real)`](Physics_Model.md#GeoEfficiency.CylDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L194-L203' class='documenter-source'>source</a><br>


user may also just type `CylDetector()` to enter dimension from the console.

<a id='GeoEfficiency.CylDetector-Tuple{}' href='#GeoEfficiency.CylDetector-Tuple{}'>#</a>
**`GeoEfficiency.CylDetector`** &mdash; *Method*.



```
CylDetector()
```

construct and return a `cylindrical` detector according to the input from the `console`.

**see also:** [`CylDetector(CryRadius::Real, CryLength::Real)`](Physics_Model.md#GeoEfficiency.CylDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L207-L216' class='documenter-source'>source</a><br>


!!! note
    the position of the source is reported relative to the detector anchoring point,  for a cylinder detector it is taking as a point in the plain surface nearest to the source  which lies on the detector axis of symmetry.



<a id='Bore-hole-Detector-1'></a>

## Bore-hole Detector


To construct a bore-hole detector type `BoreDetector(CryRadius, CryLength, HoleRadius)`. 

<a id='GeoEfficiency.BoreDetector' href='#GeoEfficiency.BoreDetector'>#</a>
**`GeoEfficiency.BoreDetector`** &mdash; *Type*.



```
BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

construct and return a `bore-hole` detector of the given crystal dimensions:-

  * `CryRadius` : the detector crystal radius.
  * `CryLength` : the detector crystal length.
  * `HoleRadius` : the detector hole radius.

!!! warning "Invalid Arguments"
    `CryRadius` and `CryLength`, `HoleRadius` should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L230-L245' class='documenter-source'>source</a><br>


user may also just type `BoreDetector()` to enter dimension from the console.

<a id='GeoEfficiency.BoreDetector-Tuple{}' href='#GeoEfficiency.BoreDetector-Tuple{}'>#</a>
**`GeoEfficiency.BoreDetector`** &mdash; *Method*.



```
BoreDetector()
```

construct and return a `bore-hole` detector according to the input from the `console`.

**see also:** [`BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)`](Physics_Model.md#GeoEfficiency.BoreDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L261-L270' class='documenter-source'>source</a><br>


!!! note
    the position of the source is reported relative to the detector anchoring point,  for a bore-hole detector it is taking as the middle point of its axis of symmetry.



<a id='Well-type-Detector-1'></a>

## Well-type Detector

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

!!! warning "Invalid Arguments"
    all arguments should be `positive` numbers, also  `CryRadius` should be greater than `HoleRadius` and  `CryLength` should be greater than  `HoleDepth`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L285-L302' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.WellDetector-Tuple{}' href='#GeoEfficiency.WellDetector-Tuple{}'>#</a>
**`GeoEfficiency.WellDetector`** &mdash; *Method*.



```
WellDetector()
```

construct and return a Well-Type detector according to the input from the `console`.

**see also:** [`WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)`](Physics_Model.md#GeoEfficiency.WellDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L320-L329' class='documenter-source'>source</a><br>


!!! note
    the position of the source is reported relative to the detector anchoring point,  for well-type detector it is taking as the point detector hole surface that  lies on the detector axis of symmetry.



!!! note
    to let the program determine the detector type as well as dimension just type `Detector()`



<a id='Source-1'></a>

# Source

<a id='GeoEfficiency.source' href='#GeoEfficiency.source'>#</a>
**`GeoEfficiency.source`** &mdash; *Function*.



```
source(anchorPnt::Point = Point())
```

return a tuple that describe the source (`anchorPnt`, `SrcRadius`, `SrcLength`) according to  the input from the `console`.

  * `anchorPnt` : the source anchoring point. if it is missing the user is prompt   to input it via the `console`.
  * `SrcRadius` : source radius.
  * `SrcLength` : source length.

!!! warning "Point/Cylinder Source"



```
if source type set to point source, both `SrcRadius` and `SrcLength` are set to zero. 
for more information **see also:** [`typeofSrc()`](@ref) and [`typeofSrc(x::Int)`](@ref).
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L103-L119' class='documenter-source'>source</a><br>


<a id='Source-Anchoring-Point-1'></a>

# Source Anchoring Point

<a id='GeoEfficiency.Point' href='#GeoEfficiency.Point'>#</a>
**`GeoEfficiency.Point`** &mdash; *Type*.



```
Point(Height::Real, Rho::Real)
```

construct and return a `Point` source. The `Point` can be used as either a source by itself or an `anchor point` of a higher dimension source.

  * `Height` : point height relative to the detector surface.
  * `Rho` : point off-axis relative to the detector axis of symmetry.

!!! warning "Interpretation of `Height`"
    Each detector type give different interpretation to the `Height` as follow:-

      * for `CylDetector` the point source `height` is consider to be measured   from the detector `face surface`.
      * for `BoreDetector` the point source `height` is consider to be measured   from the `detector middle`, +ve value are above the detector center while -ve are below.
      * for `WellDetector` the point source `height` is considered to be measured   from the detector `hole surface`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L16-L36' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Point-Tuple{Real}' href='#GeoEfficiency.Point-Tuple{Real}'>#</a>
**`GeoEfficiency.Point`** &mdash; *Method*.



```
Point(Height::Real)
```

construct and return an `axial point`.

**see also:** [`Point(Height::Real, Rho::Real)`](Physics_Model.md#GeoEfficiency.Point).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L44-L53' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Point-Tuple{}' href='#GeoEfficiency.Point-Tuple{}'>#</a>
**`GeoEfficiency.Point`** &mdash; *Method*.



```
Point()
```

construct and return a `point`. prompt to input information via the `console`. 

**see also:** [`Point(Height::Real, Rho::Real)`](Physics_Model.md#GeoEfficiency.Point).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L56-L65' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Point-Tuple{Real,Point}' href='#GeoEfficiency.Point-Tuple{Real,Point}'>#</a>
**`GeoEfficiency.Point`** &mdash; *Method*.



```
Point(xHeight::Real, aPnt::Point)
```

construct and return a `point` that has the same off-axis distance as `aPnt` but of new  height `xHeight`. 

**see also:** [`Point(Height::Real, Rho::Real)`](Physics_Model.md#GeoEfficiency.Point)


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L73-L82' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Point-Tuple{Point,Real}' href='#GeoEfficiency.Point-Tuple{Point,Real}'>#</a>
**`GeoEfficiency.Point`** &mdash; *Method*.



```
Point(aPnt::Point, xRho::Real)
```

construct and return a `point` that has the same height as `aPnt` but of new  off-axis distance `Rho`. 

**see also:** [`Point(Height::Real, Rho::Real)`](Physics_Model.md#GeoEfficiency.Point).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e8925d8b7d972949bce978a3d769d7ab73a9ab38/src/Physics_Model.jl#L85-L94' class='documenter-source'>source</a><br>

