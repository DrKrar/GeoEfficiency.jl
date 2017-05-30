#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************



@testset "Output Interface" begin
  
   @testset "function `calc`-CylDetector" for cryLength=[0,1,5,10]
	   @test calc(Detector(5,cryLength),(Point(1),1, 1))    == nothing
	   @test calc(Detector(5,cryLength),(Point(1),1, 1//2)) == nothing     
	   @test calc(Detector(5,cryLength),(Point(1),1, pi))   == nothing  
	   @test calc(Detector(5,cryLength),(Point(1),1, 1.0))  == nothing    
	   
	   @test calc(Detector(5,cryLength),(Point(1),1//2, 1))    == nothing
	   @test calc(Detector(5,cryLength),(Point(1),1//2, 1//2)) == nothing  
	   @test calc(Detector(5,cryLength),(Point(1),1//2, pi))   == nothing 
	   @test calc(Detector(5,cryLength),(Point(1),1//2, 1.0))  == nothing
	   
	   @test calc(Detector(5,cryLength),(Point(1),e, 1))    == nothing 
	   @test calc(Detector(5,cryLength),(Point(1),e, 1//2)) == nothing  
	   @test calc(Detector(5,cryLength),(Point(1),e, pi))   == nothing   
	   @test calc(Detector(5,cryLength),(Point(1),e, 1.0))  == nothing   
	   
	   @test calc(Detector(5,cryLength),(Point(1),1.0, 1))    == nothing   
	   @test calc(Detector(5,cryLength),(Point(1),1.0, 1//2)) == nothing   
	   @test calc(Detector(5,cryLength),(Point(1),1.0, pi))   == nothing   
	   @test calc(Detector(5,cryLength),(Point(1),1.0, 1.0))  == nothing
     end #testset_for
	 
	@testset "function `calc`-BoreDetector & WellDetector" for holeRadius=[3, 4], holeDepth=[0,1,2,3]
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1))    == nothing
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1//2)) == nothing     
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, pi))   == nothing  
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1.0))  == nothing    
	   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1))    == nothing
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1//2)) == nothing  
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, pi))   == nothing 
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1.0))  == nothing
	   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1))    == nothing 
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1//2)) == nothing  
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, pi))   == nothing   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1.0))  == nothing   
	   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1))    == nothing   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1//2)) == nothing   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, pi))   == nothing   
	   @test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1.0))  == nothing
       end #testset_for
   
   @testset "function `batch`" begin
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
	   @test batch([eps() 0], [0.0], [0.0], [0.0], [0.0],false) == nothing
	   @test batch([1.0 0], [0.0]) == nothing
	   @test batch([1.0 0], [0.0], [0.0], [0.0], [0.0],false) == nothing
	   @test batch([1//2 0.0], [0.0]) == nothing
	   @test batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false) == nothing
	   @test batch([1//2 0.0], [0.0]) == nothing
	   @test batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false) == nothing
	   @test batch([e pi], [0.0]) == nothing
	   @test batch([e pi], [0.0], [0.0], [0.0], [0.0],false) == nothing
	   
	   @test batch([5.0 4 3], [0.0]) == nothing
	   @test batch([5.0 4 3], [0.0], [0.0],[0.0],[0.0],false) == nothing
	   @test batch([5.0 4 3//1], [0.0]) == nothing
	   @test batch([5.0 4 3//1], [0.0], [0.0],[0.0],[0.0],false) == nothing
	   @test batch([5.0 4 pi], [0.0]) == nothing
	   @test batch([5.0 4 pi], [0.0], [0.0],[0.0], [0.0], false) == nothing
	   
	   @test batch([5.0 4 3 2], [0.0]) == nothing
	   @test batch([5.0 4 3 2], [0.0], [0.0], [0.0],[0.0],false) == nothing
	   
	   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0]) == nothing
	   @test batch([CylDetector(eps()), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
	   
	   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0]) == nothing
	   @test batch([CylDetector(eps()), BoreDetector(5,4,3)], [0.0], [0.0], [0.0],[0.0],false) == nothing
	   
	   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
	   @test batch([BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
	   
	   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0]) == nothing
	   @test batch([CylDetector(eps()), BoreDetector(5,4,3), WellDetector(5,4,3, 2)], [0.0], [0.0], [0.0],[0.0],false) == nothing
       end  #begin_testset
end  #begin_testset
