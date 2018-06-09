#**************************************************************************************
# Config.jl
# =============== part of the GeoEfficiency.jl package.
#
# this file contain the configurable parameters of the program. 
# 	-  the values introduced here do hid any other values.
# 	-  to retore defaults for a parameter just comment it out.
#
#**************************************************************************************

#------------------ ---- set_global_Consts -----------------------------

##Physics_Model.jl##

##Input_Interface.jl##
const dataFolder    = "GeoEfficiency"
const dataDir       = joinpath(homedir(), dataFolder)

##Calculations.jl##
using QuadGK; const integrate = QuadGK.quadgk
const relativeError = 1.0E-4
const absoluteError = eps(1.0)

##Output_Interface.jl##
const resultsFolder = "results"
