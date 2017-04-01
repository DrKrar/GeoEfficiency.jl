#
# Correctness Tests
#

using GeoEfficiency
if isdefined(Base.Test, Symbol("@testset")) 
	using Base.Test 
else 
	using BaseTestNext 
	const Test = BaseTestNext 
end 

tests = ["Input_Interface",
         "Physical_model",
         "Output_Interface",
         "Calculations"]
#if v"0.4-" < VERSION < v"0.5-"
#	tests[4] = "Calculations_julia_0.4"
#end

println("\nRunning tests:")

for t in tests
    println(" * $(t)")
    include("test_$(t).jl")
end
@test 1.0==1



