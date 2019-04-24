# Physics Model
Geometrical efficiency of radioactive source measurement is a type of detection efficiency. A fully describe a radioactive source measurement at the most basic level three component should be provided. 
*  radioactive detector description
*  radiation source description 
*  relative position of the source to detector.
this section will discus how to instruct the program to construct each of the aforementioned component.

# Detector
Currently, only cylindrical-like types of detectors are supported.  

## Cylindrical Detector
To construct a **cylinder** detector type `CylDetector(CryRadius, CryLength)`

```@docs
GeoEfficiency.CylDetector
```

To construct a planer **cylinder**  detector or **Disc** `CylDetector(CryRadius)`

```@docs
GeoEfficiency.CylDetector(CryRadius::Real)
```

user may also just type `CylDetector()` to enter dimension from the console.

```@docs
GeoEfficiency.CylDetector()
```
!!!  note
    the position of the source is reported relative to the detector anchoring point, 
    for a cylinder detector it is taking as a point in the plain surface nearest to the source 
    which lies on the detector axis of symmetry.

## Bore-hole Detector
To construct a bore-hole detector type `BoreDetector(CryRadius, CryLength, HoleRadius)`. 

```@docs
GeoEfficiency.BoreDetector
```

user may also just type `BoreDetector()` to enter dimension from the console.

```@docs
GeoEfficiency.BoreDetector()
```

!!! note
    the position of the source is reported relative to the detector anchoring point, 
    for a bore-hole detector it is taking as the middle point of its axis of symmetry.


## Well-type Detector

```@docs
GeoEfficiency.WellDetector
```

```@docs
GeoEfficiency.WellDetector()
```
!!! note
    the position of the source is reported relative to the detector anchoring point, 
    for well-type detector it is taking as the point detector hole surface that 
    lies on the detector axis of symmetry.

!!! note
    to let the program determine the detector type as well as dimension just type `Detector()`

# Source

```@docs
GeoEfficiency.source
```

# Source Anchoring Point

```@docs
GeoEfficiency.Point
```


```@docs
GeoEfficiency.Point(Height::Real)
```

```@docs
GeoEfficiency.Point()
GeoEfficiency.Point(xHeight::Real, aPnt::Point)
```

```@docs
GeoEfficiency.Point(aPnt::Point, xRho::Real)
```
