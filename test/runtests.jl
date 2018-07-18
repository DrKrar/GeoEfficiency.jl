#
# Correctness Tests
#

using Compat, Compat.Test , Compat.DelimitedFiles, Compat.MathConstants
using Compat: @debug, @info, stdin
using GeoEfficiency
const G = GeoEfficiency
#logging(IOBuffer(), G)


include("Helper.jl")

const SourceFiles = [
					#"Helper",
					#"Input_Interface",
   					#"Physics_Model",
    				#"Calculations",
					"Output_Interface"
					]

@testset "$SourceFile" for SourceFile = SourceFiles
	@debug("Begin test of.....", SourceFile)   
	include("test_$SourceFile.jl")
	println("\n")
end #testset

@test about() == nothing
