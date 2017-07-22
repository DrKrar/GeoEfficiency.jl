
#------------------about------------------------------------

function about() 
	print_with_color(:green,
	"""
	\n
	\t *************************************************
	\t **            -=) GeoEfficiency (=-            **
	\t **  Accurate Geometrical Efficiency Calculator **
	\t *************************************************

	  @version: v"0.9.1-Dev" - ($(Date(now())- Date("2017-07-25")) old master)  
	  @author: Mohamed Krar,  @e-mail: DrKrar@gmail.com 
	  @Profile: https://www.researchgate.net/profile/Mohamed_Krar3
	  @repository: https://github.com/DrKrar/GeoEfficiency.jl/
	  @documentation: http://geoefficiencyjl.readthedocs.org
	  Created on Fri Aug 14 20:12:01 2015, \n
	""")
end


#------------------setConsts---------------------------------

"""# This function is expermintal and should not be used.

	CONFIG(;
	_datafolder::AbstractString = "GeoEfficiency",
	_resultsfolder::AbstractString = "results",
	_relativeError::Float64 = 0.0001,
	_absoluteError::Float64 = 0.00000000001)

a spectial function that can be used to change the setting of the pakage for one or more
 setting while set the remining to the default.
 
!!! note
    CONFIG() can be used to reset the package to the defaults.
	
"""
function CONFIG(;
_datafolder::AbstractString = "GeoEfficiency",
_resultsfolder::AbstractString = "results",
_relativeError::Float64 = 0.0001,
_absoluteError::Float64 = 0.00000000001)

  warn("This function is expermintal and should not be used.")
  ##Physics_Model.jl##

  ##Intput_Interface.jl##
  const datafolder    = _datafolder

  ##-Calculations.jl##
#using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = _relativeError
  const absoluteError = _absoluteError

  ##Output_Interface.jl##
  const resultsfolder = _resultsfolder
  @compat reload(string(@__MODULE__))
end
