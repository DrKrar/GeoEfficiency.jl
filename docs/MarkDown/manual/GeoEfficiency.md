
<a id='Summery-1'></a>

# Summery

<a id='GeoEfficiency.GeoEfficiency' href='#GeoEfficiency.GeoEfficiency'>#</a>
**`GeoEfficiency.GeoEfficiency`** &mdash; *Module*.



**GeoEfficiency Package**

Introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency`  for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form  a source. The source can be a point, a disc or even a cylinder.

**Quick Usage**

  * geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.
  * calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.
  * calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.
  * batch()	: Calculate  in $batch mode$ the geometrical efficiency using data in the **`/home/.GeoEfficiency`** folder.  For more information see `batch`, `batchInfo`.

**Documentation and Updates**

```
 Repository:    [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)
 Documentation: https://GeoEfficiency.GitHub.io/dev/index.html
                https://juliahub.com/docs/GeoEfficiency/
 PDF_Manual:    https://GeoEfficiency.GitHub.io/dev/GeoEfficiency.jl.pdf
```

To use Julia pakage manger to check for and obtaining the latest stable vesrion

$julia> import Pkg$

$julia> Pkg.update("GeoEfficiency")$


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/83c258218fa45f7e9d609e92c59890d2f293ff91/src/GeoEfficiency.jl#L3-L34' class='documenter-source'>source</a><br>

