using Compat.Dates

#------------------about------------------------------------

function about() 
	print_with_color(:green,
	"""
	\n
	\t *************************************************
	\t **            -=) GeoEfficiency (=-            **
	\t **  Accurate Geometrical Efficiency Calculator **
	\t **   First Created on Fri Aug 14 20:12:01 2015 **
	\t *************************************************

	  Author:        Mohamed Krar,  @e-mail: DrKrar@gmail.com 
	  Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3
		Repository:    https://github.com/DrKrar/GeoEfficiency.jl/
		Version:       v"0.9.2-DEV" - ($(Date(now()) - Date("2018-04-02")) old master)  
	  Documentation: http://geoefficiencyjl.readthedocs.org\n
	""")
end


#------------------set_Consts---------------------------------

  ##Physics_Model.jl##

  ##Intput_Interface.jl##
  const datafolder    = "GeoEfficiency"

  ##Calculations.jl##
  using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = 0.0001
  const absoluteError =  0.00000000001

  ##Output_Interface.jl##
  const resultsfolder = "results"
