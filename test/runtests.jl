#
# Correctness Tests
#

using GeoEfficiency
using Base.Test

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



