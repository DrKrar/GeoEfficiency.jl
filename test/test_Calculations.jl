#**************************************************************************************
# test_Calculations.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to test calculate the Geometrical efficiency.
#
#**************************************************************************************

function poly(z::Float64, coff::Vector{Float64})
	res::Float64 = 0.0
	for i= 1:length(coff)
		res += coff[i]*z^(i-1)
	end #for
	return res
end #function_poly
poly0(z::Float64) = poly(z, [1.0])
poly1(z::Float64) = poly(z, [1.0, 2.0])
poly2(z::Float64) = poly(z, [1.0, 2.0, 3.0])	

@testset "Calculations" begin

	print("\t"); info("polynomial test for the function `integrate`")
	@test  poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)
	
	@testset "integrate" for 
	str = -20:1.0:30, 
	nd  = -20:1.0:30
	str === nd &&  continue
	
		@test G.integrate(poly0, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0) - @evalpoly(str, 0.0, 1.0) atol=1.0e-13 
		@test G.integrate(poly1, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0, 1.0) - @evalpoly(str, 0.0, 1.0, 1.0) atol=1.0e-13 
		@test G.integrate(poly2, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0, 1.0, 1.0) - @evalpoly(str, 0.0, 1.0, 1.0, 1.0) atol=1.0e-13 
		
	end #testset_begin
	
	print("\t"); info("special cases for cylinderical detector; very restrict test")
	@testset "point at the surface of cylinderical detector of cryRaduis = $cryRaduis" for 
		cryRaduis = 1.0:0.1:11.0
		acylDetector = CylDetector(cryRaduis)

		@test geoEff(acylDetector, Point(0)) ≈ 0.5
		@test geoEff(acylDetector, Point(0, prevfloat(cryRaduis)))  ≈ 0.5
		@test geoEff(acylDetector, Point(0, nextfloat(-cryRaduis))) ≈ 0.5
		@test geoEff(acylDetector, Point(0,         cryRaduis/2.0)) ≈ 0.5
		@test geoEff(acylDetector, Point(0,        -cryRaduis/2.0)) ≈ 0.5

		@test geoEff(acylDetector, Point(eps())) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), prevfloat(cryRaduis)))  <= 0.5
		@test geoEff(acylDetector, Point(eps(), nextfloat(-cryRaduis))) <= 0.5
		@test geoEff(acylDetector, Point(eps(),          cryRaduis/2.0)) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(),         -cryRaduis/2.0)) ≈ 0.5

		@test geoEff(acylDetector, Point(eps(cryRaduis), cryRaduis))  ≈ .25
		@test geoEff(acylDetector, Point(cryRaduis, cryRaduis))  < .25		
		@test_throws ErrorException geoEff(acylDetector, Point(eps(cryRaduis), nextfloat(cryRaduis)))
		@test_throws ErrorException geoEff(acylDetector, Point(nextfloat(cryRaduis), nextfloat(cryRaduis)))
	end #for_testset
	
	print("\t"); info("special cases for Borehole detector")
	@testset "point at the surface of Borehole detector of cryRaduis $cryRaduis and height $height" for 
	cryRaduis = 1.0:0.1:11.0, 
	height = 1.0:0.1:11.0, 
	k      = 1.1:0.1:11.0
	
	holeradius::Float64 = cryRaduis/k		# k > 1
	aboreDetector = BoreDetector(cryRaduis,height,holeradius)
	
		@test  geoEff(aboreDetector, Point(0.0)) > 0.0
		@test  geoEff(aboreDetector, Point(-0.1)) > 0.0 ### invert Detector
		@test_skip  geoEff(aboreDetector, Point(height/2.0)) > 0.0
		@test_skip  geoEff(aboreDetector, Point(-height/2.0)) > 0.0
		@test_skip  geoEff(aboreDetector, Point(height/2.0)) ≈ geoEff(aboreDetector, Point(-height/2.0))

		@test_skip   geoEff(aboreDetector, Point(height)) > 0.0
		@test_skip   geoEff(aboreDetector, Point(-height)) > 0.0
		@test_skip   geoEff(aboreDetector, Point(height)) ≈ geoEff(aboreDetector, Point(-height))
		
		@test_skip   geoEff(aboreDetector, Point(1.5*height)) > 0.0
		@test_skip   geoEff(aboreDetector, Point(-1.5*height)) > 0.0
		@test_skip   geoEff(aboreDetector, Point(1.5*height)) ≈ geoEff(aboreDetector, Point(-1.5*height))
	end #testset_for
	
	print("\t"); info("special cases for well detector")
	@testset "point at the surface of Well detectors of cryRaduis $cryRaduis and height $height" for 
	cryRaduis = 1.0:0.1:11.0, 
	height = 1.0:0.1:11.0, 
	k      = 1.1:0.1:11.0
		
	holeradius::Float64 = cryRaduis/k		# k > 1
	welldepth::Float64 = height/k		# k > 1
	awellDetector = WellDetector(cryRaduis,height,holeradius, welldepth)
	
		@test geoEff(awellDetector, Point(welldepth)) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, prevfloat(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, nextfloat(-holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, holeradius/2.0)) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, -holeradius/2.0)) ≈ 0.5
	
		@test geoEff(awellDetector, Point(nextfloat(welldepth))) ≈ 0.5
		@test geoEff(awellDetector, Point(nextfloat(welldepth), prevfloat(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(nextfloat(welldepth), prevfloat(-holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(nextfloat(welldepth),  holeradius/2.0)) ≈ 0.5
		@test geoEff(awellDetector, Point(nextfloat(welldepth), -holeradius/2.0)) ≈ 0.5

	end #for_testset	

end #testset


@testset "scaling test" begin

	print("\t"); info("statrting scaling test cylinderical detector with point source...")
	@testset "[J=$j] test, Scalling $k at cryRadius=$cryRadius" for 
		cryRadius = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		j=2:100, 	# j > 1
		k=2:100
		
		acylDetector  = CylDetector(  cryRadius)
		acylDetectork = CylDetector(k*cryRadius)
		axPnt  = Point(  cryRadius/j); naxPnt  = Point(  cryRadius/j,   cryRadius/j)
		axPntk = Point(k*cryRadius/j); naxPntk = Point(k*cryRadius/j, k*cryRadius/j)
		
		@test geoEff(acylDetector, axPnt)  ≈ geoEff(acylDetectork, axPntk)		# axial point
		@test geoEff(acylDetector, naxPnt) ≈ geoEff(acylDetectork, naxPntk)		# non-axial point
	end #for_testset
	
	print("\t"); info("statrting scaling test Borehole detector with point source...")
	@testset "cryRadius=$cryRadius, holeRadius=$holeRadius" for 
		cryRadius  = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		holeRadius = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]/2.2
		holeRadius > cryRadius && continue	
		
		for j=2:100, k=2:100
		aboreDetector  = BoreDetector(  cryRadius,   j,   holeRadius)
		aboreDetectork = BoreDetector(k*cryRadius, k*j, k*holeRadius)
		axPnt  = Point(  cryRadius/j); naxPnt  = Point(  cryRadius/j,   holeRadius/j)
		axPntk = Point(k*cryRadius/j); naxPntk = Point(k*cryRadius/j, k*holeRadius/j)
		
			@test geoEff(aboreDetector , axPnt)  ≈ geoEff(aboreDetectork, axPntk) atol= 1.0e-16	# axial point
			@test geoEff(aboreDetector , naxPnt) ≈ geoEff(aboreDetectork, naxPntk) atol= 1.0e-16	# non-axial point
		end #for
	end #for_testset

	print("\t"); info("statrting scaling test Well-type detector with point source...")
	@testset "cryRadius=$cryRadius, holeRadius=$holeRadius" for 
		cryRadius  = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		holeRadius = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]/2.2
		holeRadius > cryRadius && continue	
		
		for j=2:100, k=2:100
			awellDetector  = WellDetector(  cryRadius,   j,   holeRadius,   j/2.0)
			awellDetectork = WellDetector(k*cryRadius, k*j, k*holeRadius, k*j/2.0)		
			axPnt  = Point(  cryRadius/j); naxPnt  = Point(  cryRadius/j,   holeRadius/j)
			axPntk = Point(k*cryRadius/j); naxPntk = Point(k*cryRadius/j, k*holeRadius/j)

			@test geoEff(awellDetector , axPnt)  ≈ geoEff(awellDetectork, axPntk) atol= 1.0e-16	# axial point
			@test geoEff(awellDetector , naxPnt) ≈ geoEff(awellDetectork, naxPntk) atol= 1.0e-16 	# non-axial point
		end #for
	end #for_testset
	

	
	@testset "\tfunction `geoEff on CylDetector(5,$cryLength)" for 
	cryLength=[0,1,5,10]
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1, 1))    < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1, 1//2)) < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1, pi))   < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1, 1.0))  < 2pi

		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1//2, 1))    < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1//2, 1//2)) < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1//2, pi))   < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1//2, 1.0))  < 2pi

		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),e, 1))    < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),e, 1//2)) < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),e, pi))   < 2pi #
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),e, 1.0))  < 2pi

		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1.0, 1))    < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1.0, 1//2)) < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1.0, pi))   < 2pi
		@test 0.0 < geoEff(Detector(5,cryLength),(Point(1),1.0, 1.0))  < 2pi
     end #testset_for
	 
	@testset "\tfunction `geoEff` on WellDetector(5, 4, $holeRadius, $holeDepth)" for 
	holeRadius = 3:0.5:4, 
	holeDepth  = 0:1.0:3
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1))    < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1//2)) < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, pi))   < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1.0))  < 4pi

		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1))    < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1//2)) < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, pi))   < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1.0))  < 4pi

		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1))    < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1//2)) < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, pi))   < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1.0))  < 4pi

		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1))    < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1//2)) < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, pi))   < 4pi
		@test 0.0 < geoEff(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1.0))  < 4pi
		end #testset_for
end #testset

