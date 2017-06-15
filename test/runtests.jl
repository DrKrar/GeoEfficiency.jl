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
         "Physics_Model",
         "Calculations",
         "Output_Interface"]

println("\nRunning tests:")

for t in tests
	println()
	info("Beging test of $(t).....\n")
    include("test_$(t).jl")
	info("End test of $(t).....\n")
end
@test about() == nothing
