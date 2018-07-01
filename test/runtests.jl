#
# Correctness Tests
#

const io = IOBuffer()
logging(io, kind=:warn)
logging(io, kind=:info)

using Compat
import Compat: stdin, @info
using Compat.MathConstants
using Compat.DelimitedFiles
using Compat.Test
using GeoEfficiency
const G = GeoEfficiency

function exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs::Vector; Fn_ARGs::Vector=[])
	for input in  string.(consol_inputs)
		 write(stdin.buffer, input,"\n")
	end
	return Fn(Fn_ARGs...)
end
exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs...; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, consol_inputs; Fn_ARGs=Fn_ARGs)
exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs::String; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, split(consol_inputs); Fn_ARGs=Fn_ARGs)


const tests = [
	"Input_Interface",
    "Physics_Model",
    "Calculations",
    "Output_Interface"]

println("\nRunning tests:")
for t in tests
	println(); @info("Begin test of $(t).....\n")
	@testset("Testing $(t) .....") begin
    	include("test_$(t).jl")
	end #testset
	println()
end
@test about() == nothing

