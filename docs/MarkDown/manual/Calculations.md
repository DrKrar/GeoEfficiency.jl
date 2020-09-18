
<a id='Calculations-1'></a>

# Calculations


calculation of the geometrical efficiency can be done via a call to the function `geoEff`.

<a id='GeoEfficiency.geoEff' href='#GeoEfficiency.geoEff'>#</a>
**`GeoEfficiency.geoEff`** &mdash; *Function*.



```
geoEff(detector::Detector, aPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)::Float64
```

return the `geometrical efficiency` for a source (`point`, `disk` or `cylinder`) with  the detector `detector`. 

**Arguments**

  * `detector` can be any of the leaf detectors types (`CylDetector`, `BoreDetector`, `WellDetector`).
  * `aPNT`: a point represent the anchoring point of the source.
  * `SrcRadius`: Radius of the source.
  * `srcHeight`:  the height of an upright cylinder source.

**Throw**

  * an `InValidGeometry` if the point location is invalide.
  * an `NotImplementedError` if source-to-detector geometry not supported yet.

!!! warning
    the point height of `aPnt` is measured differently for different detectors types. for the details, please refer to each detector entry.


!!! note
      * if `SrcLength` equal to `zero`; the method return Geometrical Efficiency of a disc   source of Radius = `SrcRadius` and center at the point `aPNT`.
      * if both `SrcRadius` and `SrcLength` equal to `zero`;   the method returns the Geometrical Efficiency of a point source at the anchoring point.


**Example**

  * to obtain the efficiency of a `cylindrical` detector of crystal radius `2.0` cm for axial    source cylinder of radius `1.0` cm and height `2.5` cm on the detector surface.

```julia-repl
julia> using GeoEfficiency

julia> geoEff(CylDetector(2.0), Point(0.0), 1.0, 2.5)
0.2923777934922748
```

  * to obtain the efficiency for a `bore-hole` detector of crystal radius of `2.0` and height of `3.0` with    hole radius of `1.5` cm for axial source cylinder of radius `1.0` cm and height `2.5` cm starting from detector center.

```julia-repl
julia> using GeoEfficiency

julia> newDet = BoreDetector(2.0, 3.0, 1.5);

julia> geoEff(newDet, Point(0.0), 1.0, 2.5)
0.5678174038944723
```

  * to obtain the efficiency for a `well-type` detector of crystal radius of `2.0` cm and    height `3.0` cm with hole radius of `1.5` cm and depth of `1.0` cm for axial source cylinder of    radius `1.0` cm and height `2.5` cm at the hole surface.

```julia-repl
julia> using GeoEfficiency

julia> newDet = WellDetector(2.0, 3.0, 1.5, 1.0);

julia> geoEff(newDet, Point(0.0), 1.0, 2.5)
0.4669614527701105
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/83c258218fa45f7e9d609e92c59890d2f293ff91/src/Calculations.jl#L229-L296' class='documenter-source'>source</a><br>


!!! note "Information"
    the function has another method `geoEff()` that prompt the user to input a source and a detector via the `console`.


