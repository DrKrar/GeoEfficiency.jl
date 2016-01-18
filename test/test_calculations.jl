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
info("Spectial case for cylinderical detector; very restrict test")
for raduis=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
	detector = CylDetector(raduis)
	@test_approx_eq 	geoEff(detector, Point(0)) 							0.5
	@test_approx_eq 	geoEff(detector, Point(0, raduis-eps(raduis)))		0.5
	@test_approx_eq 	geoEff(detector, Point(0, -raduis+eps(raduis)))		0.5
	@test_approx_eq 	geoEff(detector, Point(0, raduis/2-eps(raduis)))	0.5
	@test_approx_eq 	geoEff(detector, Point(0, -raduis/2+eps(raduis)))	0.5
	
	@test_approx_eq 	geoEff(detector, Point(eps()))					0.5
	@test_approx_eq 	geoEff(detector, Point(eps(), raduis-eps(raduis)))		0.5
	@test_approx_eq 	geoEff(detector, Point(eps(), -raduis+eps(raduis)))		0.5
	@test_approx_eq 	geoEff(detector, Point(eps(), raduis/2-eps(raduis)))	0.5
	@test_approx_eq 	geoEff(detector, Point(eps(), -raduis/2+eps(raduis)))	0.5
end #for

info("Spectial case for well detector")
for raduis=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], height=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], k=[1.1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
	welldepth = height/k		# k > 1
	holeradius = raduis/k		# k > 1
	detector = WellDetector(raduis,height,holeradius, welldepth)
	
	@test_approx_eq 	geoEff(detector, Point(welldepth)) 									0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth, holeradius-eps(holeradius)))		0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth, -holeradius+eps(holeradius)))		0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth, holeradius/2-eps(holeradius)))	0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth, -holeradius/2+eps(holeradius)))	0.5
	
	@test_approx_eq 	geoEff(detector, Point(welldepth+eps(welldepth)))									0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth+eps(welldepth), holeradius-eps(holeradius)))		0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth+eps(welldepth), -holeradius+eps(holeradius)))		0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth+eps(welldepth), holeradius/2-eps(holeradius)))		0.5
	@test_approx_eq 	geoEff(detector, Point(welldepth+eps(welldepth), -holeradius/2+eps(holeradius)))	0.5
end #for	

