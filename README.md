
[![Build Status](https://travis-ci.org/DrKrar/GeoEfficiency.jl.svg)](https://travis-ci.org/DrKrar/GeoEfficiency.jl)  [![Build Status](https://ci.appveyor.com/api/projects/status/gnd6dqbdaxcx1c23/branch/master?svg=true)](https://ci.appveyor.com/project/DrKrar/GeoEfficiency.jl/branch/master)


# Accurate Geometrical Efficiency Calculator (GeoEfficiency)

GeoEfficiency.jl provides a set of tools to calculate the geometrical efficiency in a fast and accurate way. 

the geometrical efficiency is calculated for a detector (`cylinder`, `bore-hole` or `well-type`) as seen from a source (`point`, `disc`, or `cylinder`).


## Requirements
Julia 0.4 or above.

##Download and Install the Package
	Pkg.add("GeoEfficiency")
	using GeoEfficiency
	
## Quick Usage
	calc()
	
for more try also `calcN(()` `batch()`
	
##Package overview
the following function can be used to construct a specific type of detector 
`CylDetector` for cylindrical detector, 
`BoreDetector` for bore hole, 
`WellDetector` for well type detector.
while `DetectorFactory` can be used to construct any of the above types. you may try `getDetectors` also.


`Point` function is used to construct an anchoring point for a source relative to it its position to the detector is specified.
for a point source the  anchoring point  is the source itself. the `source` function take input from the `console` and return a tuple 
descriping the source.


the effcieicny calcualtion can done by one of the functions `GeoEff` used with argument, `calc` ask for the required information 
from the `console` m `calcN` just a repeat of the `calc` function or batch() which try to take required information from csv files located in the home directory
inside a folder called `.batch`.
	
##Batch Calculation
the output results of batch calculation using `batch()` is found in `.batch\results` folder inside the user account home.
for example	`c:\users\yourusername`.

the input to the `batch()` function should be found in the `.batch` folder to be able to function correctly.

the input is a set of comma saved values (CSV) files each line represent an entry, the first line is count as the header.
the CSV files are:-

`Detectors.csv` contains the detectors description; 
the line format is: Crystal_Raduis, Crystal_Length,Hole_Radius, Hole_Depth

the program expect the line to contain at least one number or at most four separated numbers.
	
`srcHeights.csv` contains the source heights; 	
the program expect the line to contain one number.
	
`srcRhos.csv` contains the source off-axis distances; 	 				
the program expect the line to contain one number.	

`srcRadii.csv` contains the source radii for disc and cylindrical sources; 			
the program expect the line to contain one number.	
	
	
`srcLengths.csv` contains the source length for cylindrical sources; 	
the program expect the line to contain one number.
