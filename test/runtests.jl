#
# Correctness Tests
#

using Base.Test
using GeoEfficiency

using GeoEfficiency: srcType, writecsv_head, integrate, detector_info_from_csvFile, read_from_csvFile
using GeoEfficiency: setRho!, setHeight!, id, volume
using GeoEfficiency: integrate 
using GeoEfficiency: _batch
using GeoEfficiency: CONFIG


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
@test CONFIG() == nothing
