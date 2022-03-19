__precompile__() #First Created on Fri Aug 14 20:12:01 2015 

"""


# GeoEfficiency Package
Introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency` 
for a set of common radiation detectors shapes (cylindrical, Bore-hole, Well-type) as seen form 
a source. The source can be a point, a disc or even a cylinder.

# Quick Usage
*  geoEff()	: Calculate the geometrical efficiency (GE) for one geometrical setup; returns a numerical value represent the calculated GE.

*  calc() 	: Calculate the geometrical efficiency (GE) for one geometrical setup and display full information on the console.

*  calcN()	: Calculate the geometrical efficiency (GE) for geometrical setup(s) recusevily and display full information on the console until the user quit.

*  batch()	: Calculate  in ``batch mode`` the geometrical efficiency using data in the **`$(join(split(dataDir,"/travis")))`** folder.
   For more information see `batch`, `batchInfo`.

# Documentation and Updates

\t Repository:    [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)
\t Documentation: https://GeoEfficiency.GitHub.io/dev/index.html
\t                https://juliahub.com/docs/GeoEfficiency/
\t PDF_Manual:    https://GeoEfficiency.GitHub.io/dev/GeoEfficiency.jl.pdf

To use Julia pakage manger to check for and obtaining the latest stable vesrion

```julia
julia> import Pkg

julia> Pkg.update("GeoEfficiency")
````

"""
module GeoEfficiency
const GeoEfficiency_Version = v"0.9.4-dev"

export 

 # Config

 # Input_Console

 # Physics_Model
	Point,
	source,
	Detector,
	CylDetector,
	BoreDetector,
	WellDetector,

# Input_Batch
	getDetectors,
	setSrcToPoint,
	typeofSrc,

 # Calculations
	geoEff,

 # Output_Interface
 	max_batch,
 	calc,
	calcN,
	batch,
	batchInfo

include("Config.jl") # configurable parameters of the program.
include("Error.jl")	# define error system for the package.
include("Input_Console.jl")
include("Physics_Model.jl")
include("Input_Batch.jl")
include("Calculations.jl")
include("Output_Interface.jl")


#------------------------ splash ---------------------------


printstyled("""
\n
\t **************************************************
\t **            -=) GeoEfficiency (=-             **
\t **  Accurate Geometrical Efficiency Calculator  **
\t **************************************************

\t Author:     Mohamed E. Krar [ DrKrar@gmail.com ]
\t Profile:    https://www.researchgate.net/profile/Mohamed_Krar3

\t Welcome to GeoEfficiency $GeoEfficiency_Version

\t Start a calculation by using:
\t julia> calc()

\t Type ? just after 'julia>' to open help system:
\t julia>? GeoEfficiency
\n
""", color = :blue, bold = true)

end #module
