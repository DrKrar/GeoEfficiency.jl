#
# Correctness Tests
#

const io = IOBuffer()
logging(io, kind=:warn)
logging(io, kind=:info)

if VERSION < v"0.7.0-dev.2000"
	using Base.Test
else
	using Test
end
using GeoEfficiency
const G = GeoEfficiency
using Compat
using Compat.MathConstants

tests = ["Input_Interface",
         "Physics_Model",
         "Calculations",
         "Output_Interface"]

println("\nRunning tests:")

for t in tests
	println(); info("Begin test of $(t).....\n")
    include("test_$(t).jl")
	println(); info("End test of $(t).....\n")
end
@test about() == nothing

