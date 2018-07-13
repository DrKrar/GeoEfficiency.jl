#
# Correctness Tests
#

using Compat, Compat.Test , Compat.DelimitedFiles, Compat.MathConstants
using Compat: @info, stdin
using GeoEfficiency
const G = GeoEfficiency
#logging(IOBuffer(), G)

include("Helper.jl")

const tests = [
	"Helper",
	"Input_Interface",
    "Physics_Model",
    "Calculations",
    "Output_Interface"]

@testset "Testing $tst ....." for tst in tests
	println(); @info("Begin test of $tst.....\n"); println()	   
	include("test_$tst.jl")
end #testset

@test about() == nothing

