#**************************************************************************************
# test_Physics_Model.jl
# ====================== part of the GeoEfficiency.jl package.
# 
#   
# 
#**************************************************************************************
using Compat.Sys: isapple

@testset "Physics Model" begin

info("test `Point`...")	
	@testset "Point" begin
		@test G.id(Point(5,3)) == "Point[Height=5.0, Rho=3.0]"
		@test show(Point(5,3)) == nothing

		#pnt0 = Point()
		pnt1 = Point(5)
		pnt11 = 
		pnt5 = Point(5.0, 0.0)	
		pnt51 = Point(5.0, 1.0)	
		
		@test pnt1.Height === 5.0
		@test pnt1.Rho    === 0.0
		@test Point(-5).Height === -5.0
		@test Point(-5).Rho    === 0.0
		@test Point(-5,-1).Height === -5.0
		@test Point(-5,-1).Rho    === -1.0
		@test_throws MethodError     Point(1+0im,4)
		@test_throws MethodError     Point(4, 1+0im)
		@test_throws MethodError     Point(1+0im, 1+0im)
		@test_throws ErrorException  Point(5.0, 0.0).Height = 1.0
		@test_throws ErrorException  Point(5.0, 0.0).Rho    = 1.0
		
		@test Point(5)      === pnt5 
		@test Point(5//1)   === pnt5
		@test Point(5.0)    === pnt5
		
		@test Point(5, 0)   === pnt5
		@test Point(5, 0//1)=== pnt5
		@test Point(5, 0.0) === pnt5

		@test Point(5//1, 0)    === pnt5
		@test Point(5//1, 0//1) === pnt5
		@test Point(5//1, 0.0)  === pnt5

		@test Point(5.0, 0)    === pnt5
		@test Point(5.0, 0//1) === pnt5
		@test Point(5.0, 0.0)  === pnt5
	
	
		@test Point(5, 1)   === pnt51
		@test Point(5, 1//1)=== pnt51
		@test Point(5, 1.0) === pnt51

		@test Point(5//1, 1)    === pnt51
		@test Point(5//1, 1//1) === pnt51
		@test Point(5//1, 1.0)  === pnt51

		@test Point(5.0, 1)    === pnt51
		@test Point(5.0, 1//1) === pnt51
		@test Point(5.0, 1.0)  === pnt51	
		
		# pnt6 = G.setRho(pnt5, 1)
		# @test pnt6.Height == pnt5.Height 
		# @test pnt6.Rho != pnt5.Rho 

		# pnt6 = G.setHeight(pnt5, 1)
		# @test pnt6.Height != pnt5.Height 
		# @test pnt6.Rho == pnt5.Rho 

		pnt6 = G.setRho!(pnt5, 5)
		@test pnt6.Height == pnt5.Height 
		@test pnt6.Rho == 5.0

		pnt6 = G.setHeight!(pnt5, 5)
		@test pnt6.Height == 5.0
		@test pnt6.Rho == pnt5.Rho 
		
		if !isapple()
			write(STDIN.buffer,"5\n" * "1\n")
			@test Point() === pnt51
		end #if
	end #testset

print("\n\t"); info("test `Cylinderical Detector`...")			
	@testset "Cylinderical Detector" begin 
  
		@test G.id(CylDetector(5,3)) == "CylDetector[CryRadius=5.0, CryLength=3.0]"
  		@test show(CylDetector(5,3)) == nothing
	
    	cyl0 = CylDetector(5)
		cyl1 = Detector(5)
		@test_throws ErrorException  cyl0.CryRadius = 1
		@test_throws ErrorException  cyl0.CryLength = 1
		@test_throws MethodError     CylDetector(1+0im,4)
		@test_throws MethodError     CylDetector(4, 1+0im)
		@test_throws MethodError     CylDetector(1+0im, 1+0im)
		@test_throws AssertionError  CylDetector(0)
		@test_throws AssertionError  CylDetector(-5)
		@test_throws AssertionError  CylDetector(5, -1)	
		@test isa(cyl1, Detector)
		@test isa(cyl1, CylDetector)
		@test cyl1.CryRadius === 5.0
		@test cyl1.CryLength === 0.0

		cyl2 = Detector(5, 0)
		cyl3 = Detector(5, 0.0)
		cyl4 = Detector(5.0, 0)
		cyl5 = Detector(5.0, 0.0)
		cyl6 = Detector(5, 0, 0)
		cyl7 = Detector(5, 0, 0, 0)
		cyl8 = Detector(5//1, 0, 0, 0)
		@test cyl0 === cyl1 
		@test cyl1 === cyl2 
		@test cyl2 === cyl3
		@test cyl3 === cyl4
		@test cyl4 === cyl5
		@test cyl5 === cyl6
		@test cyl6 === cyl7
		@test cyl7 === cyl8	
		@test G.volume(CylDetector(5.0,1))  <=   G.volume(CylDetector(15.0,1))
		@test G.volume(CylDetector(10.0,1)) <=   G.volume(CylDetector(15.0,1)) 
		@test G.volume(CylDetector(15.0))   <=   G.volume(CylDetector(10.0)) 
		@test CylDetector(5.0,1) < CylDetector(15.0,1)
	
		detectors = [Detector(6,2),Detector(5,1), Detector(7,10)]
		@test eltype(Vector{Detector}(detectors)) === Detector
		@test Vector{Detector}(detectors) == detectors

		if !isapple()
			info("test CylDetector()")
			write(STDIN.buffer,"5\n" * "0\n")
			@test CylDetector() === cyl0
		end #if
end #testset

print("\n\t"); info("test `Borehole Detector`...")	
	@testset "Borehole Detector" begin 
	
		@test G.id(BoreDetector(5,3,2)) == "BoreDetector[CryRadius=5.0, CryLength=3.0, HoleRadius=2.0]"
  		@test show(BoreDetector(5,3,2)) == nothing  
    
		bore0 = BoreDetector(5,4,3)
		bore1 = Detector(5,4,3)
		@test_throws ErrorException  bore0.CryRadius = 1
		@test_throws ErrorException  bore0.CryLength = 1
		@test_throws ErrorException  bore0.HoleRadius= 1
		@test_throws MethodError     BoreDetector(1+1im,4,3)
		@test_throws MethodError     BoreDetector(5+1im,4,3)	
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
		bore8 = Detector(5//1,4.0,3.0, 0)
		@test bore0 === bore1
		@test bore1 === bore2
		@test bore2 === bore3
		@test bore3 === bore4
		@test bore4 === bore5
		@test bore5 === bore6
		@test bore6 === bore7
		@test bore7 === bore8
		@test G.volume(Detector(5.0,1,.1))  <=   G.volume(Detector(15.0,1,0.1))
		@test G.volume(Detector(10.0,1,.0)) <=   G.volume(Detector(15.0,1,0.1)) 
		@test Detector(5.0,1,0.1) < Detector(15.0,1,0.1)

		detectors = [Detector(6,2,1), Detector(5,1,.2), Detector(7,10,5)]
		@test eltype(Vector{Detector}(detectors)) === Detector
		@test Vector{Detector}(detectors) == detectors

		if !isapple()
			info("test BoreDetector()")
			write(STDIN.buffer,"5\n" * "4\n" * "3\n")
			@test BoreDetector() === bore0
			write(STDIN.buffer,"5\n" * "4\n" * "6\n" * "3\n")
			@test BoreDetector() === bore0
			end #testset
		end #if

print("\n\t"); info("test `Well-type Detector`...")	
	@testset "Well-type Detector" begin 
		@test G.id(WellDetector(5,3,2,1)) == "WellDetector[CryRadius=5.0, CryLength=3.0, HoleRadius=2.0, HoleDepth=1.0]"
		@test show(WellDetector(5,3,2,1)) == nothing  

		Well0 = WellDetector(5,4,3,2)
		Well1 = Detector(5,4,3,2)
		@test_throws ErrorException  Well0.CryRadius = 1
		@test_throws ErrorException  Well0.CryLength = 1
		@test_throws ErrorException  Well0.HoleRadius= 1
		@test_throws ErrorException  Well0.HoleDepth = 1
		@test_throws MethodError     WellDetector(1+1im,4,3,2)
		@test_throws MethodError     WellDetector(5+1im,4,3,2)
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
		Well8 = Detector(5//1,4,3,2)
		@test Well0 === Well1 
		@test Well1 === Well2 
		@test Well2 === Well3
		@test Well3 === Well4
		@test Well4 === Well5
		@test Well5 === Well6
		@test Well6 === Well7
		@test Well7 === Well8

		@test G.volume(Detector(5.0,2,0.1,1))  <=   G.volume(Detector(15.0,2,0.1,1))
		@test G.volume(Detector(10.0,2,0.1,1)) <=   G.volume(Detector(15.0,2,0.1,1)) 
		@test Detector(5.0,2,0.1,1) < Detector(15.0,2,0.1,1)

		detectors = [Detector(6,2,1,.1), Detector(5,1,.2,.1), Detector(7,10,5,.1)]
		@test eltype(Vector{Detector}(detectors)) === Detector
		@test Vector{Detector}(detectors) == detectors

		if !isapple()
			info("test WellDetector()")
			write(STDIN.buffer,"5\n" * "4\n" * "3\n" * "2\n")
			@test WellDetector() === Well0
			write(STDIN.buffer,"5\n" * "4\n" * "6\n" * "3\n" * "6\n" * "2\n")
			@test WellDetector() === Well0
		end #if
	end #testset
		
print("\n\t"); info("test `RadiationDetector`...")    
	@testset "RadiationDetector" begin 
	
		@test_throws MethodError  Detector(1+1im)
		@test_throws MethodError  Detector(5+1im, 0)
		@test_throws MethodError  Detector(1+1im, 1)
		@test_throws MethodError  Detector(5+1im, 4,3)
		@test_throws MethodError  Detector(1+1im, 4, 3,2)
		@test_throws MethodError  Detector(5+1im, 4, 3,2)
		@test_throws MethodError  Detector(1+1im, 4, 3,2)
		@test_throws MethodError  Detector(4,1+1im, 3,2)
		@test_throws MethodError  Detector(4,3,2+1im,1)
		@test_throws MethodError  Detector(4,3,2,1+1im)
		
		@test Detector(5)       === CylDetector(5)
		@test Detector(5,0)     === CylDetector(5)
		@test Detector(5,0,0,0) === CylDetector(5)
		@test Detector(5,1)     === CylDetector(5,1)
		@test Detector(5,1,0)   === CylDetector(5,1)
		@test Detector(5,1,0,0) === CylDetector(5,1)
		@test Detector(5,2,1)   === BoreDetector(5,2, 1)
		@test Detector(5,2,1,0) === BoreDetector(5,2, 1)
		@test Detector(5,4,3,2) === WellDetector(5,4,3,2)
		
		cyl0 = CylDetector(5)
	    	@test Detector(cyl0)   === cyl0
		bore0 = BoreDetector(5,4,3)
		@test Detector(bore0)  === bore0
		Well0 = WellDetector(5,4,3,2)
		@test Detector(Well0) === Well0
		for i=1:1000
			det1 = Detector(rand())
			@test Detector(det1)   === det1
			det2 = Detector(rand(2)...)
			@test Detector(det2)   === det2
			det3 = Detector(rand(15:20), rand(10:14), rand(1:13))
			@test Detector(det3)   === det3
			det4 = Detector(rand(15:20), rand(10:14), rand(9:13), rand(1:9))
			@test Detector(det4)   === det4
		end #for	
		@test G.id(Detector(5,3,2,1)) == "WellDetector[CryRadius=5.0, CryLength=3.0, HoleRadius=2.0, HoleDepth=1.0]"
		@test G.id(Detector(5,3,2)) == "BoreDetector[CryRadius=5.0, CryLength=3.0, HoleRadius=2.0]"
		@test G.id(Detector(5,3)) == "CylDetector[CryRadius=5.0, CryLength=3.0]"
		@test G.id(Detector(5)) == "CylDetector[CryRadius=5.0, CryLength=0.0]"
		
		detectors = [Detector(6,2), Detector(5,1,.2), Detector(7,10,5,.1)]
		@test eltype(Vector{Detector}(detectors)) === Detector
		@test Vector{Detector}(detectors) == detectors

		if !isapple()
			info("test Detector()")
			write(STDIN.buffer,"5\n" * "4\n" * "3\n" * "2\n")
			@test Detector() === Detector(5, 4, 3, 2)
			write(STDIN.buffer,"5\n" * "4\n" * "0\n")
			@test Detector() === Detector(5, 4)
			write(STDIN.buffer,"5\n" * "4\n" * "\n")
			@test Detector() === Detector(5, 4)
			write(STDIN.buffer,"5\n" * "4\n" * "6\n" * "3\n" * "6\n" * "2\n")
			@test Detector() === Detector(5, 4, 3, 2)
		end #if
	end #testset	

info("test `source`...")   
	@testset "source" begin
		setSrcToPoint(true)
		pnt1 = Point(5)
		@test source(pnt1) == (pnt1, 0.0, 0.0)
		end
		
	@testset "Invalid Detector Dimensions $dim"  for dim =  
	    Number[0, -1, 0//1, -1//1, -e, 0.0, -1.0, -Inf, Inf,]

		@test_throws AssertionError	 CylDetector(dim)  
		@test_throws AssertionError	 CylDetector(dim, 0)
		@test_throws AssertionError	 CylDetector(dim, 1)
		@test_throws AssertionError  BoreDetector(dim, 1, 0.2)
		@test_throws AssertionError  BoreDetector(dim, 1, 0)
		@test_throws AssertionError  WellDetector(dim, 2, 1, 0)

		@test_throws AssertionError  Detector(dim)
		@test_throws AssertionError	 Detector(dim, 0)
		@test_throws AssertionError	 Detector(dim, 1)
		@test_throws AssertionError  Detector(dim, 0, 0)

		dim == 0.0 && break
		@test_throws AssertionError	 CylDetector(5, dim)
		@test_throws AssertionError  BoreDetector(5, dim, 0)
		@test_throws AssertionError	 CylDetector(5, dim)
		@test_throws AssertionError  BoreDetector(5, dim, 0)
		@test_throws AssertionError  BoreDetector(5,dim, 1)
		@test_throws AssertionError  WellDetector(5,dim, 1, 0.1)

		end #testset_for
println()
end #tesset
