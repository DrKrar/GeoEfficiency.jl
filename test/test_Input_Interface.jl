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
const dotest = false

@testset "Input_Interface" begin
    @testset "getfloat" begin
	if dotest
		info("test `getfloat` with different ways to input numbers...")
		@test   0.0     ==  getfloat("\njust press return: ")
		@test   1.0     ==  getfloat("\ninput 1, then press return: ")
	    @test   1.0     ==  getfloat("\ninput 1.0, then press return: ")
	    @test   2000.0  ==  getfloat("\ninput '2e3', then press return: ")
	    @test   0.034   ==  getfloat("\ninput '3.4e-2', then press return: ")
	    @test   Float64 == typeof(getfloat("\ntry to input any string, only valid number should accepted: "))
	    @test   Float64 == typeof(getfloat("\nthe first time input '1.2f': "))
	
	    info("test `getfloat` with mathematical expressions...")
	    @test   0.5           ==  getfloat("\ninput 1/2, then press return: ")
		@test   0.75          ==  getfloat("\ninput 3//4, then press return: ")
	    @test   Base.pi/2     ==  getfloat("\ninput 'pi/2', then press return: ")
	    @test   Base.e        ==  getfloat("\ninput 'e', then press return: ")
	    @test   Base.e^3      ==  getfloat("\ninput 'e^3', then press return: ")
	    @test   Base.sin(0.1) ==  getfloat("\ninput 'sin(0.1)', then press return: ")
	    @test   Float64       ==  typeof(getfloat("\nthe first time input '1.2+2im': "))

	end #if 
    end # testset
	
end # testset
