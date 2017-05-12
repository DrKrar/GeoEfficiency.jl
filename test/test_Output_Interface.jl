#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************


info("Statrting `batch` test...")
@testset "Output Interface" begin

   #info("Statrting `calc` test...")
   #@test calc() == nothing
   
   info("Statrting `batch` test...")
   @test GeoEfficiency._batch(Val{true}, CylDetector(eps()), [0.0])[2][end] ≈ 0.5
   @test GeoEfficiency._batch(Val{false}, CylDetector(eps()), [0.0])[2][end] ≈ 0.5
   @test batch(CylDetector(eps()), [0.0])[2][end] ≈ 0.5
   @test batch(CylDetector(eps()), [0.0], [0.0], [0.0],[0.0],false)[2][end] ≈ 0.5
   
   #@test batch([CylDetector(eps())], [0.0]) == nothing
   #@test batch([CylDetector(eps())], [0.0], [0.0], [0.0],[0.0],false) == nothing



 end  #begin_testset
