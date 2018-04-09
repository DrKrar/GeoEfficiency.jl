#**************************************************************************************
# Config.jl
# =============== part of the GeoEfficiency.jl package.
#
# this file contain the configuration parameters. the values introduced here hid any other value.
#
#**************************************************************************************

using Compat.Dates

#------------------about------------------------------------

function about() 
	printstyled(
	"""
	\n
	\t *************************************************
	\t **            -=) GeoEfficiency (=-            **
	\t **  Accurate Geometrical Efficiency Calculator **
	\t **   First Created on Fri Aug 14 20:12:01 2015 **
	\t *************************************************

	\t Author:        Mohamed Krar,  @e-mail: DrKrar@gmail.com 
	\t Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3
	\t Repository:    https://github.com/DrKrar/GeoEfficiency.jl/
	\t Version:       v"0.9.2-DEV" - ($(Date(now()) - Date("2018-04-09")) old master)  
	\t Documentation: http://geoefficiencyjl.readthedocs.org
	\n"""
	, color=:green)
end


#------------------set_Consts---------------------------------

  ##Physics_Model.jl##

  ##Input_Interface.jl##
  const datafolder    = "GeoEfficiency"

  ##Calculations.jl##
  using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = 0.0001
  const absoluteError =  0.00000000001

  ##Output_Interface.jl##
  const resultsfolder = "results"
