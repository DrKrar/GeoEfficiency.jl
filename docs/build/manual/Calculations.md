
<a id='Calculations-1'></a>

# Calculations

<a id='GeoEfficiency.geoEff' href='#GeoEfficiency.geoEff'>#</a>
**`GeoEfficiency.geoEff`** &mdash; *Function*.



```julia
geoEff(detector::Detector, aPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)::Float64
```

return the `geometrical efficiency` for a source (`point`, `disk` or `cylinder`) with  the detector `detector`.  `detector` can be any of the leaf detectors types (`CylDetector`, `BoreDetector`, `WellDetector`).

  * `aPNT`: a point represent the anchoring point of the source.
  * `SrcRadius`: Radius of the source.
  * `srcHeight`:  the height of an upright cylinder source.

**`Throw`** an Error if the source location is inappropriate.

!!! warning
    the point height of `aPnt` is measured differently for different detectors types. for the details, please refer to each detector entry.


!!! note
      * if `SrcLength` equal to $zero$; the method return Geometrical Efficiency of a disc   source of Radius = `SrcRadius` and center at the point `aPNT`.
      * if both `SrcRadius` and `SrcLength` equal to $zero$;   the method returns the Geometrical Efficiency of a point source at the anchoring point.


**Example**

1. to obtain the efficiency of a `cylindrical` detector of crystal radius $2.0$ cm for axial   source cylinder of radius $1.0$ cm and height $2.5$ cm on the detector surface.

```julia-repl
julia> using GeoEfficiency

julia> geoEff(CylDetector(2.0), Point(0.0), 1.0, 2.5)
0.2923777934922748
```

2. to obtain the efficiency for a `bore-hole` detector of crystal radius of $2.0$ and height of $3.0$ with   hole radius of $1.5$ cm for axial source cylinder of radius $1.0$ cm and height $2.5$ cm starting from detector center.

```julia-repl
julia> using GeoEfficiency

julia> newDet = BoreDetector(2.0, 3.0, 1.5);

julia> geoEff(newDet, Point(0.0), 1.0, 2.5)
0.5678174038944723
```

3. to obtain the efficiency for a `well-type` detector of crystal radius of $2.0$ cm and   height $3.0$ cm with hole radius of $1.5$ cm and depth of $1.0$ for axial source cylinder of   radius $1.0$ cm and height $2.5$ cm at the hole surface.

```julia-repl
julia> using GeoEfficiency

julia> newDet = WellDetector(2.0, 3.0, 1.5, 1.0);

julia> geoEff(newDet, Point(0.0), 1.0, 2.5)
0.4669614527701105
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/938dc1c4630bbe122ecc2766beade3c02eab5566/src/Calculations.jl#L224-L285' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.GeoEff_Pnt' href='#GeoEfficiency.GeoEff_Pnt'>#</a>
**`GeoEfficiency.GeoEff_Pnt`** &mdash; *Function*.



**unexported**

```
GeoEff_Pnt(detector::CylDetector, aPnt::Point)::Float64
```

return the `geometrical efficiency` for the point source `aPnt` located on front of the cylindrical detector `detector` face.

**`Throw`** an Error if the point is out of the cylindrical detector `detector` face.

!!! note
    this is the base function that all other functions call directly or indirectly to calculate `geometrical efficiency` of the cylindrical-ish detector family.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/938dc1c4630bbe122ecc2766beade3c02eab5566/src/Calculations.jl#L23-L37' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.GeoEff_Disk' href='#GeoEfficiency.GeoEff_Disk'>#</a>
**`GeoEfficiency.GeoEff_Disk`** &mdash; *Function*.



**unexported**

```
GeoEff_Disk(detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)::Float64
```

return the `geometrical efficiency` for a `disk` source. The `disk` center is the `SurfacePnt` and  its radius is `SrcRadius` on front of the cylindrical detector `detector` face.

produce a warning if the disk is out of the cylindrical detector face.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/938dc1c4630bbe122ecc2766beade3c02eab5566/src/Calculations.jl#L72-L82' class='documenter-source'>source</a><br>

