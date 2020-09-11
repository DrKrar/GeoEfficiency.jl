Project Status: | [![Active – The project has reached a stable, usable state and is being actively developed.][repostatus-img]](http://www.repostatus.org/#active)
:----|:----:
Author | [Mohamed E. Krar](https://www.researchgate.net/profile/Mohamed_Krar3) (DrKrar@gmail.com) 
Repository | [GitHub.com](https://github.com/DrKrar/GeoEfficiency.jl/)
Documentation |  [GitHub.io](https://GeoEfficiency.GitHub.io/dev/index.html)
Current version | [v"0.9.4-dev"](https://github.com/DrKrar/GeoEfficiency.jl)
First Created | Fri Aug 14 20:12:01 2015

Build status: | [![travis][travis-img]](https://travis-ci.org/DrKrar/GeoEfficiency.jl) | [![appveyor][appveyor-img]](https://ci.appveyor.com/project/DrKrar/GeoEfficiency-jl)
----|----|----
Code coverage: | [![coveralls][coveralls-img]](https://coveralls.io/github/DrKrar/GeoEfficiency.jl?branch=master) | [![codecov][codecov-img]](http://codecov.io/github/DrKrar/GeoEfficiency.jl?branch=master)

[repostatus-img]: http://www.repostatus.org/badges/latest/active.svg
[travis-img]: https://img.shields.io/travis/JuliaLang/julia/master.svg?label=Linux+/+macOS
[appveyor-img]: https://img.shields.io/appveyor/ci/JuliaLang/julia/master.svg?label=Windows
[coveralls-img]: https://img.shields.io/coveralls/github/JuliaLang/julia/master.svg?label=coveralls
[codecov-img]: https://img.shields.io/codecov/c/github/JuliaLang/julia/master.svg?label=codecov

---

# GeoEfficiency: Accurate Geometrical Efficiency Calculator

An officially registered Julia program, provides a set of tools to calculate the geometrical efficiency in a fast and accurate way. 
The Package models a radiation detector irradiated by a radioactive source. 
The Package relay directly on numerical evaluation of a closed form analytical formula describing the geometrical efficiency.

## Current/Planned Features
The following list describe the state of current feature and planed feature. 
The checked items represent already present feature.

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
 *  Julia 1.5 or above.
 *  QuadGK 2.4 or above, installed automatically during the package installation.
 
## Download/Installation
Getting the GeoEfficiency package to work involves two steps: 

### 1. Installing Julia Language
Just head over to the Julia language [download page](https://www.julialang.org/downloads/) and choose the suitable binary for your platform to download and install. 
At the end of this step you should be able to run julia from your system. 

## _Note_
**Head to [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/DrKrar/GeoEfficiency.jl/master) to run julia in your browser without any local installation.**

### 2. Installing Package
GeoEfficiency is registered officially and so the latest stable release can be installed through the Julia package management system just by typing the following into the julia REPL prompt.

```julia
julia> import Pkg
julia> Pkg.add("GeoEfficiency") 
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

**see also: `geoEff()`, `calcN()`, `batch()`**

## Unit Test
Being error free and accuracy is a highly demanded objective in scientific calculation.
Thus, the package is extensively tested method-wise in each supported operating system.
Operating system fully supported includes Windows, Linus, Apple OSX.

After installing, the package can be tested in your own system by typing the following into the REPL prompt.
```julia
julia> using Test, Pkg
julia> Pkg.test("GeoEfficiency") 
```

## Package Overview
The following constructor can be used to construct a specific type of detector 
 *  `CylDetector` for cylindrical detector, 
 *  `BoreDetector` for bore hole, 
 *  `WellDetector` for well type detector.

 While the function `Detector` can be used to construct any of the above types. You may try also `getDetectors`.

`Point` constructor is used to construct an anchoring point of a source. relative to source anchoring point the source position is specified.
For a point source, the anchoring point is the source itself. 
The `source()` method take input from the `console` and return a tuple describing the source.

The efficiency calculation can be done by one of the functions: 
*  `geoEff` used with or without argument(s), 
*  `calc` ask for the required information from the `console`, 
*  `calcN` just a repeat of the `calc` function 
*  `batch()` which try to take required information from csv files located in 
   the home directory inside a folder called `GeoEfficiency`.
 
For more on the function and its methods prefix the name of the function by `?`.

## _Note_
**Input from the `console` can be numerical expression not just a number.**
   
   > **``5/2`` ; ``5//2`` ; ``pi`` ; ``π/2`` ; ``exp(2)`` ; ``1E-2 `` ; ``5.2/3`` ; ``sin(1)`` ;  ``sin(1)^2``**
   > **All are valid expressions.**
     
## Batch Calculation
The package can be used to perform batch calculations by calling one of the 
methods of the function `batch`. The output results of batch calculations is 
found by default in `GeoEfficiency\results` folder inside the user home directory.

**For example  `c:\users\yourusername\GeoEfficiency\results\`**.

The function `batch()` can be called with or without arrangement(s). 
The without argument version relay on previously prepared Comma Saved  Values 
[CSV] files, that can be easily edit by Microsoft Excel, located by default 
in the ``GeoEfficiency`` folder.

Those Comma Saved  Values [CSV] files are:-
    
*  `Detectors.csv` contains the detectors description (`a detector per line`); The line format is: 
     
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

## _Note_
**For Comma Saved Values [CSV] files each line represent an entry, the first line is always treated as the header.**
      
## _warning_
**The program expect each line to contain one number for all CSV files except for ``Detectors.csv`` each line should contain at least one number or at most four separated numbers.**
