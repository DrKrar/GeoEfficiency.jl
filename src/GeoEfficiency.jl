__precompile__()

"""

# GeoEfficiency Package
introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency` 
for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form 
a source. The source can be a point, a disc or even a cylinder.

# Quick Usage
*  geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\n
*  calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\n
*  calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\n
*  batch()	: Calculate the geometrical efficiency using data in the **`$dataDir`** folder in batch mode.

**for more information and updates refer to the repository at [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)**

"""
module GeoEfficiency

export 
	about,

 # Config

 # Input_Interface
	getDetectors,
	setSrcToPoint,
	typeofSrc,

 # Physics_Model
	Point,
	source,
	Detector,
	CylDetector,
	BoreDetector,
	WellDetector,

 # Calculations
	geoEff,

 # Output_Interface
	calc,
	calcN,
	batch,
	batchInfo

include("Config.jl") # to overwrite defaults edit parameters; restore by comment out this line.
include("Physics_Model.jl")
include("Input_Interface.jl")
include("Calculations.jl")
include("Output_Interface.jl")


#------------------------ about ---------------------------

using Compat
using Compat.Dates

const abt ="""
\n
\t *************************************************
\t **            -=) GeoEfficiency (=-            **
\t **  Accurate Geometrical Efficiency Calculator **
\t **   First Created on Fri Aug 14 20:12:01 2015 **
\t *************************************************

\t Author:        Mohamed E. Krar,  @e-mail: DrKrar@gmail.com 
\t Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3
\t Repository:    https://github.com/DrKrar/GeoEfficiency.jl/
\t Version:       v"0.9.2-DEV" - ($(Date(now()) - Date("2018-07-18")) old master)  
\t Documentation: http://geoefficiencyjl.readthedocs.org
\n
\n\tBatch mode 
\t-  read files by defaul from directory `$dataDir`
\t-  save results by default to directory `$resultdir`
\n\tfor more information see `batch`, `batchInfo`.
\n
"""

"$abt"
about() = printstyled(abt, color=:green, bold=true)
about()

end #module
