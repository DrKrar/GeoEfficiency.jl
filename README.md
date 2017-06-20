# Accurate Geometrical Efficiency Calculator (GeoEfficiency)

The Package `GeoEfficiency`, an officially registered Julia program, provides a set of tools  to calculate the geometrical efficiency in a fast and accurate way. 
The Package models a radiation detector irradiated by a radiative source. 
The Package relay directly on numerical evaluation of closed form analytical formula describing the geometrical efficiency.

@author: Mohamed Krar

@e-mail: DrKrar@gmail.com

@Profile: https://www.researchgate.net/profile/Mohamed_Krar3

@repository: https://github.com/DrKrar/GeoEfficiency.jl/

@documentation: http://geoefficiencyjl.readthedocs.org

@version: v"0.9"

Created on Fri Aug 14 20:12:01 2015


## Latest Release 
[![GeoEfficiency](http://pkg.julialang.org/badges/GeoEfficiency_0.4.svg)](http://pkg.julialang.org/?pkg=GeoEfficiency)  | [![GeoEfficiency](http://pkg.julialang.org/badges/GeoEfficiency_0.5.svg)](http://pkg.julialang.org/?pkg=GeoEfficiency)  | [![GeoEfficiency](http://pkg.julialang.org/badges/GeoEfficiency_0.6.svg)](http://pkg.julialang.org/?pkg=GeoEfficiency) 
----|----|----

## Nightly Builds

Project Status | Linux, OSX | Windows | Code Coverage | codecov.io
----|----|----|----|----
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) | [![Build Status](https://travis-ci.org/DrKrar/GeoEfficiency.jl.svg)](https://travis-ci.org/DrKrar/GeoEfficiency.jl) | [![Build Status](https://ci.appveyor.com/api/projects/status/ew595nn4njmm4dbl?svg=true)](https://ci.appveyor.com/project/DrKrar/GeoEfficiency-jl) | [![Coverage Status](https://coveralls.io/repos/github/DrKrar/GeoEfficiency.jl/badge.svg?branch=master)](https://coveralls.io/github/DrKrar/GeoEfficiency.jl?branch=master) | [![codecov.io](http://codecov.io/github/DrKrar/GeoEfficiency.jl/coverage.svg?branch=master)](http://codecov.io/github/DrKrar/GeoEfficiency.jl?branch=master)

---

## The following list show the current and planed features:-

 - [x] support of widely used detector geometries.
      - [x] `cylinder` detectors.
      - [x] `bore-hole` detectors.
      - [x] `well-type` detectors.
	
 - [ ] support of specialized detector geometries.
 
 - [x] support of isotropic radioactive sources.
      - [x] `point` sources.
      - [x] `disc` sources.
      - [x] `cylinder` sources.

 - [ ] support of anisotropic radioactive sources.
      - [ ] `point` sources.
	
 - [ ] consider more details of the measurement setup.
      - [ ] the detector effect.
      - [ ] the end cap effect.
      - [ ] the meduim and absorber effect.
      
 - [ ] combine the effect of the source geometry and composition. 


## Requirements
 *  Julia 0.6 or above.
 *  QuadGK 0.1.2 or above, will be installed automatically while the package Installtion.

## Download and Install the Package
The package is registered in an officially METADATA.jl and so can be installed with Pkg.add.

	Pkg.add("GeoEfficiency") 
	
## Quick Usage

	using GeoEfficiency
	calc()
	
for more try also `geoEff()`, `calcN()`, `batch()`
	

## Package Overview
The following constructor can be used to construct a specific type of detector 
 *  `CylDetector` for cylindrical detector, 
 *  `BoreDetector` for bore hole, 
 *  `WellDetector` for well type detector.

 While the function `Detector` can be used to construct any of the above types. You may try also `getDetectors`.


`Point` constructor is used to construct an anchoring point of a source relative to it its position to the detector is specified.
For a point source, the anchoring point is the source itself. 
The `source()` method take input from the `console` and return a tuple describing the source.


The efficiency calculation can be done by one of the functions: 
 *  `geoEff` used with or without argument(s), 
 *  `calc` ask for the required information from the `console`, 
 *  `calcN` just a repeat of the `calc` function 
 *  batch() which try to take required information from csv files located in the home directory inside a folder called `GeoEfficiency`.
 
For more on the function and its methods prrfix the name of the function by `?`.

### note
   Input from the `console` can be numerical expression not just a number.
   
   > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
   > All are valid expressions.
	
## Batch Calculation
the pachage can be used to perform patch calculation by calling the one of the methods of the function `batch()`. The output results of batch calculations is found in `GeoEfficiency\results` folder inside the user account home.

For example	`c:\users\yourusername\GeoEfficiency\results\`.

The function `batch()` can be called withs or without arrangement. 
The without argument version relay on previously prepared Comma Saved  Values [CSV] files, that can be easily edit by Microsoft Excel, located in the `GeoEfficiency` folder.

Those Comma Saved  Values [CSV] files are:-

 *  `Detectors.csv` contains the detectors description; The line format is: 

     Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth
     ----------------| -----------------|---------------|--------------

     > The program expect each line to contain at least one number or at most four separated numbers.

 *  `srcHeights.csv` contains the source heights; 

     Source_Heights | 
      -----------------|

     > The program expect each line to contain one number.

 *  `srcRhos.csv` contains the source off-axis distances; 	 				

     Source_Rhos | 
      -----------------|

     > The program expect each line to contain one number.

 *  `srcRadii.csv` contains the source radii for disc and cylindrical sources; 			

     Source_Radii| 
      -----------------|

     > The program expect each line to contain one number.

 *  `srcLengths.csv` contains the source length for cylindrical sources; 	

     Source_Lengths| 
      -----------------|

     > The program expect the line to contain one number.
     
### note
    For Comma Saved  Values [CSV] files each line represent an entry, the first line is always treated as the header.
