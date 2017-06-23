#**************************************************************************************
# test_Calculations.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to test calculate the Geometrical efficiency.
#
#**************************************************************************************



@testset "Calculations" begin

	print("\t"); info("polnomial test of function `integrate`")
	function poly(z::Float64, coff::Vector{Float64})
	res::Float64 = 0.0
	for i= 1:length(coff)
		res += coff[i]*z^(i-1)
	end #for
	return res
	end #function_poly
	
	@test  poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)
	poly0(z::Float64) = poly(z, [1.0])
	poly1(z::Float64) = poly(z, [1.0, 2.0])
	poly2(z::Float64) = poly(z, [1.0, 2.0, 3.0])	
	
	@testset "integrate" for str = [-0.2 , -0.1, 0.0, 1.0, 2.0, 3.0 ], nd = [-0.2 , -0.1, 0.0, 1.0, 2.0, 3.0 ]

		@test G.integrate(poly0, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0) - @evalpoly(str, 0.0, 1.0)
		@test G.integrate(poly1, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0, 1.0) - @evalpoly(str, 0.0, 1.0, 1.0)
		@test G.integrate(poly2, str, nd)[1] ≈ @evalpoly(nd, 0.0, 1.0, 1.0, 1.0) - @evalpoly(str, 0.0, 1.0, 1.0, 1.0)
		
	end #testset_begin
	
	print("\t"); info("special cases for cylinderical detector; very restrict test")
	@testset "point at the surface of cylinderical detector of radius $radius cm" for 
		radius in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
		acylDetector = CylDetector(radius)
			
		@test geoEff(acylDetector, Point(0)) ≈ 0.5
		@test geoEff(acylDetector, Point(0, radius-eps(radius))) ≈ 0.5
		@test geoEff(acylDetector, Point(0, -radius+eps(radius))) ≈ 0.5
		@test geoEff(acylDetector, Point(0, radius/2-eps(radius))) ≈ 0.5
		@test geoEff(acylDetector, Point(0, -radius/2+eps(radius))) ≈ 0.5
	
		@test geoEff(acylDetector, Point(eps())) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), radius-eps(radius))) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), -radius+eps(radius))) ≈ 0.5	
		@test geoEff(acylDetector, Point(eps(), radius/2-eps(radius))) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), -radius/2+eps(radius))) ≈ 0.5

	end #for_testset
	
	print("\t"); info("special cases for cylinderical detector also; very restrict test")
	@testset "point at the surface of cylinderical detector of radius $radius cm" for 
		radius in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
		acylDetector = CylDetector(radius)
			
		@test geoEff(acylDetector, Point(0), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(0, radius-eps(radius)), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(0, -radius+eps(radius)), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(0, radius/2-eps(radius)), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(0, -radius/2+eps(radius)), 0) ≈ 0.5
	
		@test geoEff(acylDetector, Point(eps())) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), radius-eps(radius)), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), -radius+eps(radius)), 0) ≈ 0.5	
		@test geoEff(acylDetector, Point(eps(), radius/2-eps(radius)), 0) ≈ 0.5
		@test geoEff(acylDetector, Point(eps(), -radius/2+eps(radius)), 0) ≈ 0.5

	end #for_testset

end #testset


@testset "special cases for well detector" begin

	print("\t"); info("special cases for well detector")
	@testset "point at the surface of Well detector of radius $radius cm and height $height" for 
		radius=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
		height=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
		k=[1.1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
		
		welldepth::Float64 = height/k		# k > 1
		holeradius::Float64 = radius/k		# k > 1
		awellDetector = WellDetector(radius,height,holeradius, welldepth)
	
		@test geoEff(awellDetector, Point(welldepth)) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, holeradius-eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, -holeradius+eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, holeradius/2-eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth, -holeradius/2+eps(holeradius))) ≈ 0.5
	
		@test geoEff(awellDetector, Point(welldepth+eps(welldepth))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth+eps(welldepth), holeradius-eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth+eps(welldepth), -holeradius+eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth+eps(welldepth), holeradius/2-eps(holeradius))) ≈ 0.5
		@test geoEff(awellDetector, Point(welldepth+eps(welldepth), -holeradius/2+eps(holeradius))) ≈ 0.5

	end #for_testset	

end #testset


@testset "scaling test" begin

	print("\t"); info("statrting scaling test cylinderical detector with point source...")
	@testset "[J=$j] test, Scalling $k at cryRadius=$cryRadius" for 
		cryRadius = [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		j=2:100, 
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
		#print("[J=",j, ", k=",k,"]-")
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
		#print("[J=",j, ", k=",k,"]-")
			awellDetector  = WellDetector(  cryRadius,   j,   holeRadius,   j/2.0)
			awellDetectork = WellDetector(k*cryRadius, k*j, k*holeRadius, k*j/2.0)		
			axPnt  = Point(  cryRadius/j); naxPnt  = Point(  cryRadius/j,   holeRadius/j)
			axPntk = Point(k*cryRadius/j); naxPntk = Point(k*cryRadius/j, k*holeRadius/j)

			@test geoEff(awellDetector , axPnt)  ≈ geoEff(awellDetectork, axPntk) atol= 1.0e-16	# axial point
			@test geoEff(awellDetector , naxPnt) ≈ geoEff(awellDetectork, naxPntk) atol= 1.0e-16 	# non-axial point
		end #for
	end #for_testset	
end #testset

