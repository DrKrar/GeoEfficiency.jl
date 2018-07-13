#
# Correctness Tests
#

using Compat, Compat.Test , Compat.DelimitedFiles, Compat.MathConstants
using Compat: @info, stdin
using GeoEfficiency
const G = GeoEfficiency
#logging(IOBuffer(), G)

include("Helper.jl")

const SourceFiles = [
	"Helper",
	"Input_Interface",
    "Physics_Model",
    "Calculations",
    "Output_Interface"]

@testset "$SourceFile" for  SourceFile in SourceFiles
	println(); @info("Begin test of.....", SourceFile); println()	   
	include("test_$SourceFile.jl")
end #testset

@test about() == nothing

