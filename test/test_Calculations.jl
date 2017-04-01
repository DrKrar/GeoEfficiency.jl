#**************************************************************************************
# test_Calculations.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to test calculate the Geometrical efficiency.
#
#**************************************************************************************


info("Statrting `geoEff` test...")
@testset begin
	println()
	info("special cases for cylinderical detector; very restrict test")
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

end #testset


@testset begin
	println()
	info("special cases for well detector")
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


@testset begin
	println()
	info("Statrting scaling test cylinderical detector with point source...")
	@testset "[$(k*(j-1))] test, Scalling $k at radius $radius cm" for 
		radius=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		j=2:100, 
		k=2:100
		acylDetector = CylDetector(radius); acylDetectork = CylDetector(radius*k)

		@test geoEff(acylDetector, Point(radius/j)) ≈ geoEff(acylDetectork, Point(k*radius/j))

		@test geoEff(acylDetector, Point(radius*j, radius/j)) ≈ geoEff(acylDetectork, Point(k*radius*j, k*radius/j))

	end #for_testset

end #testset

