#**************************************************************************************
# calculations.jl
# =============== part of the GeoEfficiency.jl package.
# 
# this file contains all the required function to calculate the Geometrical Efficiency.
#
#**************************************************************************************

const relativeError = 0.0001			#set the global relative precession of the Geometrical Efficiency Calculation


"""

	GeoEff_Pnt(Detector::CylDetector, aPnt::Point)
	
return the Geometrical Efficiency for a point source `aPnt` on front of the cylindrical detector `Detector` face.

`Throw` an Error if the point is out of cylinderical detector the face.

This is the base function that all other function call directly or indirectly to calculate Geometrical Efficiency.
"""
function GeoEff_Pnt(Detector::CylDetector, aPnt::Point)

	function MaxPhi(theta::Float64 )
		side = aPnt.Height * sin(theta)
		return clamp((aPnt.Rho^2 + side^2 - Detector.CryRadius^2 )/ side / aPnt.Rho /2.0, -1.0, 1.0) |> acos
	end # function

	func(theta::Float64 ) = MaxPhi(theta) * sin(theta)
	
	if 0.0 == aPnt.Rho
		strt = 0.0
		fine = atan2(Detector.CryRadius , aPnt.Height)
		return quadgk(sin, strt, fine, reltol = relativeError)[1]

	else
		strt = 0.0
		transtion = atan2(Detector.CryRadius - aPnt.Rho, aPnt.Height)
		fine = atan2(Detector.CryRadius + aPnt.Rho, aPnt.Height)
		if transtion >= 0.0
		
			return quadgk(sin, strt, transtion, reltol = relativeError)[1] + quadgk(func, transtion, fine, reltol = relativeError)[1] / pi
		
		else
			Error("Point off-axis: out of the Detector face, this case is not implemented yet")
		
		end #if
	
	end #if
end #function


"""

	GeoEff_Disk(Detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)
	
return the Geometrical Efficiency for a disk source. The disk center is `SurfacePnt` and its radius is `SrcRadius` on front of the cylindrical detector `Detector` face.

`Throw` an Error if the disk is out of cylindrical detector the face.
"""
function GeoEff_Disk(Detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)
	integrand(xRho) = xRho * GeoEff_Pnt(Detector, setRho!(SurfacePnt, xRho))
	return  quadgk(integrand , 0, SrcRadius, reltol = relativeError)[1] / SrcRadius^2  
end #function


"""

	geoEff(Detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	
return the Geometrical Efficiency for a source (point, disk or cylinder) with the cylindrical detector `Detector`.

example:-

	newDet = CylDetector()
	eff = geoEff(newDet, aSurfacePNT, SrcRadius, SrcLength)

`aSurfacePNT`: a surface point.
if `SrcRadius` = `SrcLength` = `0`; the method returns the Geometrical Efficiency at this point.
			 
`SrcRadius`: Radius of the source.
if `srcHieght` = 0; the method returns Geometrical Efficiency for disc of Radius = `SrcRadius` and 
its center is defined by the `aSurfacePNT`.

`srcHieght`:  the height of an upright cylinder source having a base like described above.

>`Throw` an Error if the source location is inappropriate.

`Note please`
\n- `aSurfacePnt`: point height is consider to be measured from the detector face surface.
\n*****
"""
function geoEff(Detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	pnt::Point = deepcopy(aSurfacePnt)
	@assert Detector.CryRadius > SrcRadius		" Source Raduis: Expected less than 'Detector Raduis=$(Detector.CryRadius)', get $SrcRadius."

    if 0.0 == SrcRadius
		@assert Detector.CryRadius  > pnt.Rho	" Point off-axis: Expected less than 'Detector Raduis=$(Detector.CryRadius)', get $(pnt.Rho)."
        return GeoEff_Pnt(Detector, pnt)/2            	#Point source

	elseif 0.0 == SrcLength								#Disk source
        return GeoEff_Disk(Detector, pnt, SrcRadius)

	else												#Cylinderical source	
        integrand(xH) = GeoEff_Disk(Detector, setHeight!(pnt, xH), SrcRadius)
		return quadgk(integrand , pnt.Height, pnt.Height + SrcLength, reltol = relativeError)[1] / SrcLength   

	end #if
end #function

"""

	geoEff(Detector::RadiationDetector = detectorFactory())
	
return the Geometrical Efficiency of the given detector or if no detector is supplied it ask for a detector from the `console`. Also prompt the user to input a source via the `console`.

>`Throw` an Error if the source location is inappropriate.
\n*****
"""
function geoEff(Detector::RadiationDetector = detectorFactory())
	geoEff(Detector, source()...)
end #function

"""

	geoEff(Detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	
return the Geometrical Efficiency for the given source (point , disk or cylinder) with the Bore-Hole detector `Detector`. 

example:-

	newDet = BoreDetector()
	efff = geoEff(newDet, aCenterPNT, SrcRadius, SrcLength)
	
`aCenterPNT`: a center point represent the anchoring point of the source. 
if `SrcRadius` = `SrcLength` = `0`; the method returns the Geometrical Efficiency at the anchoring point.

`SrcRadius`: Raduis of the source.
if SrcLength = 0;  the method returns Geometrical Efficiency for disc of Radius = `SrcRadius` 
and its center is defined by the `aCenterPNT`.

`SrcLength`: the height of an upright cylinder source having a base like described above.

>`Throw` an Error if the source location is inappropriate.

`Note please`
\n-  `aCenterPNT` : point `height` is consider to be measured from the detector middle, +ve value are above the detector center while -ve are below.
\n*****
"""
function geoEff(Detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

	HeightWup = aCenterPnt.Height - Detector.CryLength/2.0
	HeightWdown = aCenterPnt.Height + Detector.CryLength/2.0
	if HeightWdown < 0.0 
		if HeightWup + SrcLength < 0.0 		#invert the source.
			return geoEff(Detector, Point(aCenterPnt.Height - Detector.CryLength, aCenterPnt.Rho), SrcRadius, SrcLength)

		else # the source span the detector and emerges from both sides, split the source into two sources. 
			#res = (1 - 2 * geoEff(detin, Point(0.0), SrcRadius, SrcLength))* Detector.CryLength /SrcLength
			res = geoEff(Detector, Point(0.0), SrcRadius, -aCenterPnt.Height )* (-aCenterPnt.Height /SrcLength)
			res += geoEff(Detector, Point(0.0), SrcRadius, SrcLength + aCenterPnt.Height )* (1.0 + aCenterPnt.Height /SrcLength)
			return res

		end
	end

	pntWup::Point = deepcopy(aCenterPnt); 
	setHeight(aCenterPnt, abs(HeightWup));  #0.0 == SrcRadius && setRho!(pntWup, 0.0)

	pntWdown::Point = deepcopy(aCenterPnt); 
	setHeight!(pntWdown, abs(HeightWdown)); #0.0 == SrcRadius && setRho!(pntWdown, 0.0)

	detin::CylDetector = CylDetector(Detector.HoleRadius)
	detout::CylDetector = CylDetector(Detector.CryRadius)


	if HeightWup >= 0.0						# the source as a whole out of detector
		res = geoEff(detout, pntWup, SrcRadius, SrcLength)[1]
		res -= geoEff(detin, pntWdown, SrcRadius, SrcLength)[1]

	elseif HeightWup + SrcLength < 0.0 		# the source as a whole in the detector			
		res = 1 - geoEff(detin, setHeight(pntWup,abs(HeightWup + SrcLength)), SrcRadius, SrcLength)[1]
		res -= geoEff(detin, pntWdown, SrcRadius, SrcLength)[1]

	else # elseif SrcLength > 0.0
		res = (1.0 - geoEff(detin, Point(0.0), SrcRadius, -HeightWup)[1] )* -HeightWup/SrcLength
		res += geoEff(detout, Point(0.0), SrcRadius, HeightWup + SrcLength)[1] * (1.0 + HeightWup/SrcLength)
		return res

	#=else
		return 1.0 - geoEff(detin, setHeight!(pnt, -Height), SrcRadius)[1] 
	else
		res = 1 - quadgk(xH -> GeoEff_Disk(detin, setHeight!(pnt, xH), SrcRadius), 0.0, -pnt.Height, reltol = relativeError)[1]
		res = res + quadgk(xH -> GeoEff_Disk(detout, setHeight!(pntWup, xH), SrcRadius), 0.0, pntWup.Height , reltol = relativeError)[1]
			=#
	end #if
	
	return res
end #function

"""

	geoEff(Detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	
return the Geometrical Efficiency for the given source (point, disk or cylinder) with the Well-Type detector `Detector`.

Example:-

	newDet = WellDetector()
	eff = geoEff(newDet, aWellPNT, SrcRadius, SrcLength)
	
`aWellPNT`: a Well point represent the anchoring point of the source. 
if `SrcRadius` = `SrcLength` = `0`; the method returns the Geometrical Efficiency at the anchoring point.

`SrcRadius`: Raduis of the source.
if SrcLength = 0;  the method returns Geometrical Efficiency for disc of Radius = `SrcRadius` 
and its center is defined by the `aWellPNT`.

SrcLength:  the height of upright cylinder source having a base like described above.

>`Throw` an Error if the source location is inappropriate.

`Note Please`
\n- `aWellPNT` : point `height` is considered to be measured from the detector hole surface.
\n*****
"""
function geoEff(Detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	pnt::Point = deepcopy(aWellPnt)
	Height = pnt.Height - Detector.HoleDepth
	
	detin::CylDetector = CylDetector(Detector.HoleRadius)
	detout::CylDetector = CylDetector(Detector.CryRadius)
	setHeight!(pnt, Height); #0.0 == SrcRadius && setRho!(pnt, 0.0)
	
	if Height > 0.0							# the source as a whole out of the detector	
		return geoEff(detout, setHeight!(pnt, Height), SrcRadius, SrcLength)[1]
		
	elseif Height + SrcLength < 0.0 		# the source as a whole inside of the detector
		return 1.0 - geoEff(detin, setHeight!(pnt, -(Height + SrcLength) ), SrcRadius, SrcLength)[1] 
	
	elseif SrcLength > 0.0
		res = (1.0 - geoEff(detin, Point(0.0), SrcRadius, -Height)[1] )* -Height/SrcLength
		res += geoEff(detout, Point(0.0), SrcRadius, Height + SrcLength)[1] * (1.0 + Height/SrcLength)
		return res
	
	else
		return 1.0 - geoEff(detin, setHeight!(pnt, -Height), SrcRadius)[1] 
	
	end #if
end #function
