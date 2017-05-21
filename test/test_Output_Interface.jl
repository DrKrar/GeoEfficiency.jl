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
   
   @test batch([CylDetector(eps())], [0.0]) == nothing
   @test batch([CylDetector(eps())], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([BoreDetector(5,4,3)], [0.0]) == nothing
   @test batch([BoreDetector(5,4,3)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0]) == nothing
   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   
   @test batch([eps() 0], [0.0]) == nothing
   @test batch([eps() 0], [0.0], [0.0], [0.0], [0.0], [0.0],false) == nothing
   @test batch([1 0], [0.0]) == nothing
   @test batch([1 0], [0.0], [0.0], [0.0], [0.0],[0.0],false) == nothing
   @test batch([1//2 0], [0.0]) == nothing
   @test batch([1//2 0], [0.0], [0.0], [0.0], [0.0],[0.0],false) == nothing
   @test batch([1//2 0], [0.0]) == nothing
   @test batch([1//2 0], [0.0], [0.0], [0.0], [0.0],[0.0],false) == nothing
   @test batch([e pi], [0.0]) == nothing
   @test batch([e pi], [0.0], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([5 4 3], [0.0]) == nothing
   @test batch([5 4 3], [0.0], [0.0],[0.0],false) == nothing
   @test batch([5 4 3//1], [0.0]) == nothing
   @test batch([5 4 3//1], [0.0], [0.0],[0.0],false) == nothing
   @test batch([5 4 pi], [0.0]) == nothing
   @test batch([5 4 pi], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([5 4 3 2], [0.0]) == nothing
   @test batch([5 4 3 2], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0]) == nothing
   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
   
   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing

 end  #begin_testset
