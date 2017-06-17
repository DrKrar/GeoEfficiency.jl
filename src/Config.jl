
#------------------about------------------------------------

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


#------------------setConsts---------------------------------

function setConsts(
;datafolder::AbstractString = "GeoEfficiency",
resultsfolder::AbstractString = "results",
 elativeError::Float64 = 0.0001,
absoluteError::Float64 = 0.00000000001)

  ##Physics_Model.jl##

  ##Intput_Interface.jl##
  const datafolder    = datafolder

  ##-Calculations.jl##
#using QuadGK; const integrate = QuadGK.quadgk
  const relativeError = relativeError
  const absoluteError = absoluteError

  ##Output_Interface.jl##
  const resultsfolder = resultsfolder
  reload("GeoEfficiency")
end
