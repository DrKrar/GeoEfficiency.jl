__precompile__()
"""
# GeoEfficiency Package

represent a fast and flexible tool to calculate in batch or individually the geometrical efficiency
for a set of common radiation detectors shapes (cylindrical, Bore-hole, Well-type) as seen form a sources.
the source can be a point, a disc or even a cylinder.

# Quick Usage

* geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\n
	
* calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\n
	
* calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\n
	
* batch()	: Try to calculate using data in the "GeoEfficiency" folder in batch mode. 
"""
module GeoEfficiency
print_with_color(:green,"""\n
    \t *************************************************
    \t **            -=) GeoEfficiency (=-            **
    \t **  Accurate Geometrical Efficiency Calculator **
    \t **           @version: v"0.8.6-Dev"            **
    \t *************************************************

  @author: Mohamed Krar
  @Profile: https://www.researchgate.net/profile/Mohamed_Krar3
  @repository: https://github.com/DrKrar/GeoEfficiency.jl/
  @documentation: http://geoefficiencyjl.readthedocs.org
  Created on Fri Aug 14 20:12:01 2015
""")

export 	input, 
		getfloat, 
		getDetectors, 
		
		Point, 
		source,
		Detector, 
		CylDetector, 
		BoreDetector,
		WellDetector,
		RadiationDetector,
		
		geoEff, 
		
		calc, 
		calcN, 
		batch

# Physics_Model.jl

# Intput_Interface.jl
#const GeoEfficiency_datafolder    = "GeoEfficiency"

# Calculations.jl
using QuadGK
#const GeoEfficiency_integrate     = QuadGK.quadgk
#const GeoEfficiency_relativeError = 0.0001
#const GeoEfficiency_absoluteError = 0.00000000001

# Output_Interface.jl
#const GeoEfficiency_resultsfolder = "results"

include("Physics_Model.jl")
include("Input_Interface.jl")
include("Calculations.jl")
include("Output_Interface.jl")

end #module
