#
# Correctness Tests
#

using Base.Test
using GeoEfficiency
const G = GeoEfficiency
logging(IOBuffer(),G,:warn)

tests = ["Input_Interface",
         "Physics_Model",
         "Calculations",
         "Output_Interface"]

println("\nRunning tests:")

for t in tests
	println()
	info("Beging test of $(t).....\n")
    include("test_$(t).jl")
	println(); info("End test of $(t).....\n")
end
@test about() == nothing
@test G.CONFIG() == nothing
