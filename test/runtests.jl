#
# Correctness Tests
#

using GeoEfficiency
if  VERSION > v"0.5.0-dev+7720" 	#isdefined(Base.Test, Symbol("@testset")) 
	using Base.Test 
else 
	using BaseTestNext 
	const Test = BaseTestNext 
end 

tests = ["Input_Interface",
         "Physical_model",
         "Output_Interface",
         "Calculations"]

println("\nRunning tests:")

for t in tests
    println(" * $(t)")
    include("test_$(t).jl")
end
@test 1.0==1
