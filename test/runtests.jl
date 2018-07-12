#
# Correctness Tests
#

using Compat
using Compat: stdin, @info, Test
#using Compat: MathConstants, DelimitedFiles, Test
using GeoEfficiency
const G = GeoEfficiency
logging(IOBuffer(), G)

include("Helper.jl")

const tests = [
	"Helper",
	"Input_Interface",
    "Physics_Model",
    "Calculations",
    "Output_Interface"]

println("\nRunning tests:")
for t in tests
	println(); @info("Begin test of $(t).....\n")
	@testset "Testing $(t) ....." begin
    	include("test_$(t).jl")
	end #testset
	println()
end #for
@test about() == nothing

