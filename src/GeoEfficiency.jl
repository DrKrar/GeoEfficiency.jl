__precompile__()

"""
# GeoEfficiency Package

GeoEfficiency Package represent a fast and flexible tool to calculate in batch or individually the geometrical efficiency
for a set of common radiation detectors shapes (cylindrical, Bore-hole, Well-type) as seen form a source.
the source can be a point, a disc or even a cylinder.

# Quick Usage

* geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\n
	
* calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\n
	
* calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\n
	
* batch()	: Try to calculate using data in the "GeoEfficiency" folder in batch mode. 

"""
module GeoEfficiency

about() = print_with_color(:green,"""\n
    \t *************************************************
    \t **            -=) GeoEfficiency (=-            **
    \t **  Accurate Geometrical Efficiency Calculator **
    \t **             @version: v"0.8.8-dev           **
    \t *************************************************

  @author: Mohamed Krar
  @Profile: https://www.researchgate.net/profile/Mohamed_Krar3
  @repository: https://github.com/DrKrar/GeoEfficiency.jl/
  @documentation: http://geoefficiencyjl.readthedocs.org
  Created on Fri Aug 14 20:12:01 2015
""")


export 
    about,
    setConsts,
		
    # Input_Interface
	setSrcToPoint,
	getfloat, 
	getDetectors, 
	
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
	batch

function setConsts(;datafolder::Abstract string = "GeoEfficiency",
                   resultsfolder::Abstract string = "results"
                         relativeError::Float64 = 0.0001,
						 absoluteError::Float64 = 0.00000000001,)
	
  ##Physics_Model.jl##


  ##Intput_Interface.jl##
  const datafolder    = datafolder

  ##-Calculations.jl##
#using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = relativeError
  const absoluteError = absoluteError

  ##Output_Interface.jl##
  const resultsfolder = resultsfolder
end

about()
include("Physics_Model.jl")
include("Input_Interface.jl")
include("Calculations.jl")
include("Output_Interface.jl")

end #module
