# Summary

`GeoEfficiency` Package represent a fast and flexible tool to calculate in batch or individually the geometrical efficiency
for a set of common radiation detectors shapes (cylindrical, Bore-hole, Well-type) as seen form a source.
the source can be a point, a disc or even a cylinder.

Documentation: [stable](https://GeoEfficiency.GitHub.io/stable/index.html), [latest](https://GeoEfficiency.GitHub.io/dev/index.html).

## Requirements
 *  Julia 1.2 or above.
 *  QuadGK 2.0.3 or above, will be installed automatically while the package Installation.


## Download and Install the Package
just type in the REPL.

```
] add GeoEfficiency
```

## Quick Usage
 * geoEff()	: Calculate the `geometrical efficiency` for one geometrical setup return only the value of the geometrical efficiency.\n
	
 * calc() 	: Calculate the `geometrical efficiency` for one geometrical setup and display full information on the console.\n
	
 * calcN()	: Calculate the `geometrical efficiency` for geometrical setup(s) and display full information on the console until the user quit.\n
	
 * batch()	: Calculate the `geometrical efficiency` using data in the "GeoEfficiency" folder in batch mode.
 