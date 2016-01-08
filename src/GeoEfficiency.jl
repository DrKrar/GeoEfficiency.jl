#**************************************************************************************
# GeoEfficiency.jl package
# ========================
# 
# represent a fast and flexible tool to calculate in batch or individually the geometrical efficiency
# for a set of common radiation detectors shapes (cylindrical, Bore-hole, Well-type) as seen form a sources.
# the source can be a point, a disc or even a cylinder.
#
#**************************************************************************************

module GeoEfficiency
print_with_color(:black,"""\n
    \t *************************************************
    \t **            -=) GeoEfficiency (=-            **
    \t **  Accurate Geometrical Efficiency Calculator **
    \t **                                             **
    \t *************************************************

  @author: Mohamed Krar
  @Profile: https://www.researchgate.net/profile/Mohamed_Krar3
  @repositry: https://github.com/DrKrar/GeoEfficiency.jl/
  @documentation: http://geoefficiencyjl.readthedocs.org
  @version: v"0.7.1"
  Created on Fri Aug 14 20:12:01 2015
  
  loading Package
  ===============
  Pkg.add("GeoEfficiency")
  using GeoEfficiency
  
  Quick usage
  ===========
  calc()	: calculate once.
  calcN()	: calculate untill you quit.
  batch()	: batch calculate using data in the ".batch" folder. 
""")

export 	input, 
		getfloat, 
		getDetectors, 
		
		Point, 
		source,
		GammaDetector, 
		CylDetector, 
		BoreDetector,
		WellDetector,
		DetectorFactory,
		
		GeoEff, 
		
		calc, 
		calcN, 
		batch

include("Input_Interface.jl")
include("Physical_model.jl")
include("Output_Interface.jl")
include("calculations.jl")

end #module
