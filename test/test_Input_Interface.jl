#**************************************************************************************
# test_Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# test all the input from eithther the console or the csv files.
# 
#**************************************************************************************


# this set of tests need interactive input from the console, uncomment the line after `while` to do tests.
info("Statrting `getfloat` test...")
warn("those tests are suppressed because it need interactive input")
#dotest=false
@testset "getfloat" begin
	info("test `getfloat` with different ways to input numbers...")
	@test_skip   getfloat("\njust press return: ") == 0.0 
	@test_skip   getfloat("\ninput 1, then press return: ") == 1.0
	@test_skip   getfloat("\ninput 1.0, then press return: ") == 1.0 
	@test_skip   getfloat("\ninput '2e3', then press return: ") == 2000.0
	@test_skip   getfloat("\ninput '3.4e-2', then press return: ") == 0.034
	@test_skip   typeof(getfloat("\ntry to input any string, only valid number should accepted: ")) == Float64
	@test_skip   typeof(getfloat("\nthe first time input '1.2f': ")) == Float64
	
	info("test `getfloat` with mathematical expressions...")
	@test_skip   getfloat("\ninput 1/2, then press return: ") == 0.5
	@test_skip   getfloat("\ninput 'pi/2', then press return: ") == pi/2
	@test_skip   getfloat("\ninput 'e', then press return: ") == e
	@test_skip   getfloat("\ninput 'e^3', then press return: ") == e^3
	@test_skip   getfloat("\ninput 'sin(0.1)', then press return: ") == sin(0.1)
	@test_skip   typeof(getfloat("\nthe first time input '1.2+2im': ")) == Float64

end # testset
