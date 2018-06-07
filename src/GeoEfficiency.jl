__precompile__()

"""

# GeoEfficiency Package

`GeoEfficiency` package represent a fast and flexible tool to calculate in batch or individually 
the geometrical efficiency for a set of common radiation detectors shapes (cylindrical, 
Bore-hole, Well-type) as seen form a source. The source can be a point, a disc or even a cylinder.

# Quick Usage
*  geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\n
*  calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\n
*  calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\n
*  batch()	: Calculate the geometrical efficiency using data in the **``$dataDir``** folder in batch mode.

**for more information and updates refer to the repository at [``GitHub.com``](https://github.com/DrKrar/GeoEfficiency.jl/)**

"""
module GeoEfficiency

export # Config
    about,

 # Input_Interface
	getfloat, 
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

include("Config.jl")
include("Physics_Model.jl")
include("Input_Interface.jl")
include("Calculations.jl")
include("Output_Interface.jl")

about()
printstyled("""
\n\tBatch mode 
\t-  read files from directory `$dataDir`
\t-  save results to directory `$resultdir`
\n\tfor more information see `batch`, `prepare_batch`.
\n"""
,  color=:green)

end #module
