#**************************************************************************************
# test_Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# test all the input from eithther the console or the csv files.
# 
#**************************************************************************************

# this set of tests need interactive input from the console, uncomment them to do tests.

@test getfloat("\njust press return: ") == 0.0 
@test getfloat("\ninput 1, then press return: ") == 1.0
@test getfloat("\ninput 1.0, then press return: ") == 1.0 
@test getfloat("\ninput '2e3', then press return: ") == 2000.0
@test getfloat("\ninput '3.4e-2', then press return: ") == 0.034
@test typeof(getfloat("\ntry to input any string, only valid number should accepted: ")) == Float64
@test typeof(getfloat("\nthe first time input '1.2f': ")) == Float64
