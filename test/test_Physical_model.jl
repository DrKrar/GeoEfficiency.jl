#**************************************************************************************
# test_Pythical_Model.jl
# ====================== part of the GeoEfficiency.jl package.
# 
#   
# 
#**************************************************************************************


@testset begin
  @testset "Point" begin
    pnt1 = Point(5)
    @test 0.0 == pnt1.Rho
    @test typeof(pnt1.Rho) == Float64
    @test 5.0 == pnt1.Height
    @test typeof(pnt1.Height) == Float64
  
    pnt2 = Point(5, 0)
    pnt3 = Point(5, 0.0)
    pnt4 = Point(5.0, 0)
    pnt5 = Point(5.0, 0.0)
    @test pnt1.Height == pnt2.Height 
    @test pnt2.Height == pnt3.Height
    @test pnt3.Height == pnt4.Height
    @test pnt4.Height == pnt5.Height
  
    @test pnt1.Rho == pnt2.Rho  
    @test pnt2.Rho == pnt3.Rho
    @test pnt3.Rho == pnt4.Rho
    @test pnt4.Rho == pnt5.Rho
  
    pnt6 = GeoEfficiency.setRho(pnt5, 1)
    @test pnt6.Height == pnt5.Height 
    @test pnt6.Rho != pnt5.Rho 
    
  
    pnt6 = GeoEfficiency.setHeight(pnt5, 1)
    @test pnt6.Height != pnt5.Height 
    @test pnt6.Rho == pnt5.Rho 
    
    pnt6 = GeoEfficiency.setRho!(pnt5, 5)
    @test pnt6.Height == pnt5.Height 
    @test pnt6.Rho == pnt5.Rho 
		
    pnt6 = GeoEfficiency.setHeight!(pnt5, 5)
    @test pnt6.Height == pnt5.Height 
    @test pnt6.Rho == pnt5.Rho 

		end #testset

  @testset "Detector" begin 
    const Detector = RadiationDetector
  
    cyl1 = Detector(5)
    @test_throws ErrorException  cyl1.CryRaduis = 1
    @test typeof(cyl1) == CylDetector
    @test 5.0 == cyl1.CryRadius
    @test 0.0 == cyl1.CryLength
  
    cyl2 = Detector(5, 0)
    cyl3 = Detector(5, 0.0)
    cyl4 = Detector(5.0, 0)
    cyl5 = Detector(5.0, 0.0)
    cyl6 = Detector(5, 0, 0)
    cyl7 = Detector(5, 0, 0, 0)
    @test cyl1 === cyl2 
    @test cyl2 === cyl3
    @test cyl3 === cyl4
    @test cyl4 === cyl5
    @test cyl5 === cyl6
    @test cyl6 === cyl7
 
		end #testset

end #tesset
