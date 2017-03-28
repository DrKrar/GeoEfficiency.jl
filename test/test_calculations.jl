#**************************************************************************************
# test_calculations.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to test calculate the Geometrical efficiency.
#
#**************************************************************************************

using GeoEfficiency
using Base.Test

info("Statrting `geoEff` test...")
@testset begin
	println()
	info("Spectial case for cylinderical detector; very restrict test")
	@testset "point at the surface of cylinderical detector of raduis $raduis cm" for 
		raduis in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
		detector = CylDetector(raduis)
			
		@test geoEff(detector, Point(0)) ≈ 0.5
		@test geoEff(detector, Point(0, raduis-eps(raduis))) ≈ 0.5
		@test geoEff(detector, Point(0, -raduis+eps(raduis))) ≈ 0.5
		@test geoEff(detector, Point(0, raduis/2-eps(raduis))) ≈ 0.5
		@test geoEff(detector, Point(0, -raduis/2+eps(raduis))) ≈ 0.5
	
		@test geoEff(detector, Point(eps())) ≈ 0.5
		@test geoEff(detector, Point(eps(), raduis-eps(raduis))) ≈ 0.5
		@test geoEff(detector, Point(eps(), -raduis+eps(raduis))) ≈ 0.5	
		@test geoEff(detector, Point(eps(), raduis/2-eps(raduis))) ≈ 0.5
		@test geoEff(detector, Point(eps(), -raduis/2+eps(raduis))) ≈ 0.5

	end #for_testset

end #testset


@testset begin
	println()
	info("Spectial case for well detector")
	@testset "point at the surface of Well detector of raduis $raduis cm and height $height" for 
		raduis=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
		height=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
		k=[1.1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
		
		welldepth::Float64 = height/k		# k > 1
		holeradius::Float64 = raduis/k		# k > 1
		detector = WellDetector(raduis,height,holeradius, welldepth)
	
		@test geoEff(detector, Point(welldepth)) ≈ 0.5
		@test geoEff(detector, Point(welldepth, holeradius-eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth, -holeradius+eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth, holeradius/2-eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth, -holeradius/2+eps(holeradius))) ≈ 0.5
	
		@test geoEff(detector, Point(welldepth+eps(welldepth))) ≈ 0.5
		@test geoEff(detector, Point(welldepth+eps(welldepth), holeradius-eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth+eps(welldepth), -holeradius+eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth+eps(welldepth), holeradius/2-eps(holeradius))) ≈ 0.5
		@test geoEff(detector, Point(welldepth+eps(welldepth), -holeradius/2+eps(holeradius))) ≈ 0.5

	end #for_testset	

end #testset


@testset begin
	println()
	info("Statrting scaling test cylinderical detector with point source...")
	@testset "[$(k*(j-1))] test, Scalling $k at Raduis $raduis cm" for 
		raduis=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
		j=2:100, 
		k=2:100
		detector = CylDetector(raduis); detectork = CylDetector(raduis*k)

		@test geoEff(detector, Point(raduis/j)) ≈ geoEff(detectork, Point(k*raduis/j))

		@test geoEff(detector, Point(raduis*j, raduis/j)) ≈ geoEff(detectork, Point(k*raduis*j, k*raduis/j))

	end #for_testset

end #testset


