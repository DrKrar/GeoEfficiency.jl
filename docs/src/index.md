# GeoEfficiency: Accurate Geometrical Efficiency Calculator

The Package `GeoEfficiency`, an officially registered Julia program, provides a set of tools  to calculate the geometrical efficiency in a fast and accurate way. 
The Package models a radiation detector irradiated by a radioactive source. 
The Package relay directly on numerical evaluation of closed form analytical formula describing the geometrical efficiency.


Author | [Mohamed Krar](https://www.researchgate.net/profile/Mohamed_Krar3) (DrKrar@gmail.com)
----|:----: 
Repository | [GitHub.com](https://github.com/DrKrar/GeoEfficiency.jl/)
Documentation |  [ReadTheDocs](http://geoefficiencyjl.readthedocs.org)*(stale)*
Current version | [v"0.9.2"](https://github.com/DrKrar/GeoEfficiency.jl)
First Created | Fri Aug 14 20:12:01 2015


## The following list show the current and planed features:-
the checked items represent allready present feature.

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
      - [ ] the medium and absorber effect.
      
 - [ ] combine the effect of the source geometry and composition. 


## Requirements
 *  Julia 0.6 or above.
 *  QuadGK 0.3.0 or above, will be installed automatically during the package Installation.
 *  Compat 0.63.0 or above, will be installed automatically during the package Installation.
 
## Download and Install the Package
The package is registered and so can be installed through the Julia package system by running 

```julia
julia> using Pkg
julia> Pkg.add("GeoEfficiency") 
```

## Quick Usage
```julia
julia> using GeoEfficiency
julia> calc()
```
**see also: [`geoEff()`](@ref), [`calcN()`](@ref), [`batch()`](@ref)**
	

## Package Overview
The following constructor can be used to construct a specific type of detector 
 *  [`CylDetector`](@ref) for cylindrical detector, 
 *  [`BoreDetector`](@ref) for bore hole, 
 *  [`WellDetector`](@ref) for well type detector.

 While the function [`Detector`](@ref) can be used to construct any of the above types. You may try also [`getDetectors`](@ref).


[`Point`](@ref) constructor is used to construct an anchoring point of a source relative to it its position to the detector is specified.
For a point source, the anchoring point is the source itself. 
The [`source()`](@ref) method take input from the 'console' and return a tuple describing the source.


The efficiency calculation can be done by one of the functions: 
*  [`geoEff`](@ref) used with or without argument(s), 
*  [`calc`](@ref) ask for the required information from the 'console', 
*  [`calcN`](@ref) just a repeat of the [`calc`](@ref) function 
*  [`batch()`](@ref) which try to take required information from csv files located in 
   the home directory inside a folder called `GeoEfficiency`.
 
For more on the function and its methods prefix the name of the function by `?`.

!!! note
    Input from the 'console' can be numerical expression not just a number.
    > **5/2, 5//2, pi, exp(2) , 1E-2, 5.2/3, sin(1), pi/2/3**
    > **All are valid expressions.**
	
## Batch Calculation
The package can be used to perform batch calculations by calling one of the 
methods of the function `batch`. The output results of batch calculations is 
found by default in `GeoEfficiency\results` folder inside the user home.

**For example	`c:\users\yourusername\GeoEfficiency\results\`**.

The function [`batch()`](@ref) can be called with or without arrangement(s). 
The without argument version relay on previously prepared Comma Saved  Values 
[CSV] files, that can be easily edit by Microsoft Excel, located by default 
in the `GeoEfficiency` folder.

Those Comma Saved  Values [CSV] files are:-
	
*  `Detectors.csv` contains the detectors description; The line format is: 
	
		 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |
    	 ---------------| ---------------|-------------|----------- |

*  `srcHeights.csv` contains the source heights; 
	
    	     Source_Heights | 
		 ---------------|

*  `srcRhos.csv` contains the source off-axis distances; 	 				
	
		 Source_Rhos | 
     	 ------------|

*  `srcRadii.csv` contains the source radii for disc and cylindrical sources; 			
	
		 Source_Radii| 
		 ------------|

*  `srcLengths.csv` contains the source length for cylindrical sources; 	
	
		 Source_Lengths| 
		 --------------|


!!! note
    for Comma Saved Values [CSV] files each line represent an entry, the first line is always treated as the header.
	 
!!! warning
    the program expect each line to contain one number for all CSV files except for ``Detectors.csv`` each line should contain at least one number or at most four separated numbers