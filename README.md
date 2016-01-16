# Accurate Geometrical Efficiency Calculator (GeoEfficiency)

[![Build Status](https://travis-ci.org/DrKrar/GeoEfficiency.jl.svg)](https://travis-ci.org/DrKrar/GeoEfficiency.jl)  [![Build Status](https://ci.appveyor.com/api/projects/status/gnd6dqbdaxcx1c23/branch/master?svg=true)](https://ci.appveyor.com/project/DrKrar/GeoEfficiency.jl/branch/master)

---


GeoEfficiency.jl provides a set of tools to calculate the Geometrical Efficiency in a fast and accurate way. 

The Geometrical Efficiency is calculated for a detector (`cylinder`, `bore-hole` or `well-type`) as seen from a source (`point`, `disc`, or `cylinder`).


## Requirements
Julia 0.4 or above.

##Download and Install the Package
	Pkg.add("GeoEfficiency")
	using GeoEfficiency
	
## Quick Usage
	calc()
	
for more try also `calcN(()` `batch()`
	
##Package overview
The following contractors can be used to construct a specific type of detector 
`CylDetector` for cylindrical detector, 
`BoreDetector` for bore hole, 
`WellDetector` for well type detector.
While the function `detectorFactory` can be used to construct any of the above types. You may try also `getDetectors`.


`Point` contractor is used to construct an anchoring point of a source relative to it its position to the detector is specified.
For a point source, the anchoring point is the source itself. The `source` function take input from the `console` and return a tuple describing the source.


 The efficiency calculation can be done by one of the functions. `geoEff` used with or without argument(s), `calc` ask for the required information from the `console`, `calcN` just a repeat of the `calc` function or batch() which try to take required information from csv files located in the home directory inside a folder called `GeoEfficiency`.
 
 > input from the `console` can be numerical expression not just a number.
 >Example:-
 > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
 > All are valid expressions.
	
##Batch Calculation
The output results of batch calculation using `batch()` is found in `GeoEfficiency\results` folder inside the user account home.

For example	`c:\users\yourusername`.

The input to the `batch()` function should be found in the `GeoEfficiency` folder to be able to function correctly.

The input is a set of comma saved values (CSV) files each line represent an entry, the first line is count as the header.

The CSV files are:-

`Detectors.csv` contains the detectors description; 
The line format is: Crystal_Radius, Crystal_Length,Hole_Radius, Hole_Depth.

The program expect the line to contain at least one number or at most four separated numbers.
	
`srcHeights.csv` contains the source heights; 	
the program expect the line to contain one number.
	
`srcRhos.csv` contains the source off-axis distances; 	 				
the program expect the line to contain one number.	

`srcRadii.csv` contains the source radii for disc and cylindrical sources; 			
the program expect the line to contain one number.	
	
	
`srcLengths.csv` contains the source length for cylindrical sources; 	
the program expect the line to contain one number.
