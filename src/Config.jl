#**************************************************************************************
# Config.jl
# =============== part of the GeoEfficiency.jl package.
#
# This file contain the configurable parameters of the program. 
#
#**************************************************************************************

#------------------ ---- set_global_consts -----------------------------

# source_file                                                   # default value


##Physics_Model.jl##
##Input_Consolejl##


##Input_Batch.jl##
const dataFolder    = string(".", @__MODULE__)                 # string(".", @__MODULE__) = ".GeoEfficiency"
const dataDir       = joinpath(homedir(), dataFolder)          # joinpath(homedir(), dataFolder)


##Calculations.jl##
const integrate     = begin using QuadGK; QuadGK.quadgk; end    # begin using QuadGK; QuadGK.quadgk; end
const relativeError = 1.0E-4                                    # 1.0E-4  
const absoluteError = eps(1.0)                                  # eps(1.0)


##Output_Interface.jl##
const resultsFolder = "results"                                 # "results"

"""
set the default value for the global variable `_max_batch`
"""
const max_display   =  20                                       # 20
