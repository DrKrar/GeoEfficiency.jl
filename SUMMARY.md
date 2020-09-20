# Summary

## GeoEfficiency Package
Introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency` 
for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form a source. The source can be a point, a disc or even a cylinder.

## Requirements

 *  Julia 1.5 or above.
 *  QuadGK 2.4  or above, will be installed automatically while the package Installation.

## Download and Install the Package

To install the latest stable version 

```julia
julia> import Pkg

julia> Pkg.add("GeoEfficiency")
```

## Documentation and Updates

\t Repository:    [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)
\t Documentation: https://GeoEfficiency.GitHub.io/dev/index.html
\t                https://juliahub.com/docs/GeoEfficiency/
\t PDF_Manual:    https://GeoEfficiency.GitHub.io/dev/GeoEfficiency.jl.pdf

To use Julia pakage manger to check for and obtaining the latest stable vesrion

```julia
julia> import Pkg

julia> Pkg.update("GeoEfficiency")
```

## Quick Usage

After installing the package, you can load it to your current workspace by typing the following:
```julia
julia> using GeoEfficiency
```

Now the package is available to use, try typing:
```julia
julia> calc()
```

 * geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\n
	
 * calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\n
	
 * calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\n
	
 * batch()	: Calculate the geometrical efficiency using data in the "GeoEfficiency" folder in batch mode.
 