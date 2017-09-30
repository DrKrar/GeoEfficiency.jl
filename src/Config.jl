
#------------------about------------------------------------

function about() 
	print_with_color(:green,
	"""
	\n
	\t *************************************************
	\t **            -=) GeoEfficiency (=-            **
	\t **  Accurate Geometrical Efficiency Calculator **
	\t *************************************************

	  @version: v"0.9.1-Dev" - ($(Date(now())- Date("2017-09-05")) old master)  
	  @author: Mohamed Krar,  @e-mail: DrKrar@gmail.com 
	  @Profile: https://www.researchgate.net/profile/Mohamed_Krar3
	  @repository: https://github.com/DrKrar/GeoEfficiency.jl/
	  @documentation: http://geoefficiencyjl.readthedocs.org
	  Created on Fri Aug 14 20:12:01 2015, \n
	""")
end


#------------------setConsts---------------------------------

  ##Physics_Model.jl##

  ##Intput_Interface.jl##
  const datafolder    = "GeoEfficiency"

  ##Calculations.jl##
  using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = 0.0001
  const absoluteError =  0.00000000001

  ##Output_Interface.jl##
  const resultsfolder = "results"
