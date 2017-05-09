#**************************************************************************************
# test_Physics_model.jl
# ====================== part of the GeoEfficiency.jl package.
# 
#   
# 
#**************************************************************************************


@testset "Physics_model" begin
  
  @testset "Point" begin
    pnt1 = Point(5)
    @test 0.0 == pnt1.Rho
    @test isa(pnt1..Rho, Float64)
    @test 5.0 == pnt1.Height
    @test isa(pnt1.Height, Float64)
  
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

  @testset "Cylinderical Detector" begin 
  
    cyl0 = CylDetector(5)
	cyl1 = Detector(5)
    @test_throws ErrorException  cyl0.CryRadius = 1
	@test_throws ErrorException  cyl0.CryLength = 1
	@test isa(cyl1, Detector)
    @test isa(cyl1, CylDetector)
    @test 5.0 == cyl1.CryRadius
    @test 0.0 == cyl1.CryLength
  
    cyl2 = Detector(5, 0)
    cyl3 = Detector(5, 0.0)
    cyl4 = Detector(5.0, 0)
    cyl5 = Detector(5.0, 0.0)
    cyl6 = Detector(5, 0, 0)
    cyl7 = Detector(5, 0, 0, 0)
    @test cyl0 === cyl1 
	@test cyl1 === cyl2 
    @test cyl2 === cyl3
    @test cyl3 === cyl4
    @test cyl4 === cyl5
    @test cyl5 === cyl6
    @test cyl6 === cyl7
 
		end #testset
		
  @testset "Borehole Detector" begin 
  
    bore0 = BoreDetector(5,4,3)
	bore1 = Detector(5,4,3)
    @test_throws ErrorException  bore0.CryRadius = 1
	@test_throws ErrorException  bore0.CryLength = 1
	@test_throws ErrorException  bore0.HoleRadius= 1
	@test isa(bore1, Detector)
    @test isa(bore1, BoreDetector)
    @test 5.0 == bore1.CryRadius
    @test 4.0 == bore1.CryLength
	@test 3.0 == bore1.HoleRadius
  
    bore2 = Detector(5.0,4,3)
    bore3 = Detector(5,4,3,0)
    bore4 = Detector(5,4.0,3)
    bore5 = Detector(5.0,4,3.0)
    bore6 = Detector(5.0,4.0,3.0)
    bore7 = Detector(5.0,4.0,3.0, 0)
    @test bore0 === bore1 
	@test bore1 === bore2 
    @test bore2 === bore3
    @test bore3 === bore4
    @test bore4 === bore5
    @test bore5 === bore6
    @test bore6 === bore7
 
		end #testset
		
  @testset "Well-type Detector" begin 
  
    Well0 = WellDetector(5,4,3,2)
	Well1 = Detector(5,4,3,2)
    @test_throws ErrorException  Well0.CryRadius = 1
	@test_throws ErrorException  Well0.CryLength = 1
	@test_throws ErrorException  Well0.HoleRadius= 1
	@test_throws ErrorException  Well0.HoleDepth = 1
	@test isa(Well1, Detector)
    @test isa(Well1, WellDetector)
    @test 5.0 == Well1.CryRadius
    @test 4.0 == Well1.CryLength
	@test 3.0 == Well1.HoleRadius
	@test 2.0 == Well1.HoleDepth
  
    Well2 = Detector(5.0,4,3,2)
    Well3 = Detector(5,4.0,3,2)
    Well4 = Detector(5,4,3.0,2)
    Well5 = Detector(5,4,3,2.0)
    Well6 = Detector(5.0,4,3.0,2)
    Well7 = Detector(5,4.0,3,2.0)
    @test Well0 === Well1 
	@test Well1 === Well2 
    @test Well2 === Well3
    @test Well3 === Well4
    @test Well4 === Well5
    @test Well5 === Well6
    @test Well6 === Well7
 
		end #testset		

end #tesset
