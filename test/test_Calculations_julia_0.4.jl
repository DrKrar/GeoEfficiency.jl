#**************************************************************************************
# test_Calculations_julia_0.4.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to test calculate the Geometrical efficiency [for Julia 0.4].
#
#**************************************************************************************


info("Statrting `geoEff` test...")
println()
info("special cases for cylinderical detector; very restrict test")
for radius in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
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

end


println()
info("special cases for well detector")
for	radius in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
	height in [1,2,3,4,5,6,7,8,9,10.1,10.5,10.6], 
	k in [1.1,2,3,4,5,6,7,8,9,10.1,10.5,10.6]
	
	welldepth = height/k		# k > 1
	holeradius = radius/k		# k > 1
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

end #for


println()
	info("Statrting scaling test cylinderical detector with point source...")
for radius=[1,2,3,4,5,6,7,8,9,10.1,10.5,10.6],
	j=2:100, 
	k=2:100
	acylDetector = CylDetector(radius); acylDetectork = CylDetector(radius*k)

	@test geoEff(acylDetector, Point(radius/j)) ≈ geoEff(acylDetectork, Point(k*radius/j))

	@test geoEff(acylDetector, Point(radius*j, radius/j)) ≈ geoEff(acylDetectork, Point(k*radius*j, k*radius/j))

end #for
	