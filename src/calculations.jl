const relativeError = 0.0001			#set the global relative precession of the Geometrical Efficiency Calculation

function GeoEff_Pnt(Detector::CylDetector, aPnt::Point)
	
	function MaxPhi(theta::Real )
		side = aPnt.Height * sin(theta)
		return clamp((aPnt.Rho^2 + side^2 - Detector.CryRadius )/ side / aPnt.Rho /2.0, -1.0, 1.0) |> acos
	end # function

	func(theta::Real ) = MaxPhi(theta) * sin(theta)
	
	if 0 == aPnt.Rho
		strt = 0.0; fine = atan2(Detector.CryRadius , aPnt.Height)
		return quadgk(sin, strt, fine, reltol = relativeError)[1]

	else
		strt = 0.0
		transtion = atan2(Detector.CryRadius - aPnt.Rho, aPnt.Height)
		fine = atan2(Detector.CryRadius + aPnt.Rho, aPnt.Height)
		if transtion >= 0
			prt1 = quadgk(sin, strt, transtion, reltol = relativeError)[1]
			prt2 = quadgk(func, transtion, fine, reltol = relativeError)[1]
			return quadgk(sin, strt, transtion, reltol = relativeError)[1] + quadgk(func, transtion, fine, reltol = relativeError)[1] / pi
		
		else
			Error("Point off-axis: out of the Detector Face, this is not Implemented Yet")
		
		end #if
	
	end #if
end #function


function GeoEff_Disk(Detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)
	integrand(xRho) = xRho * GeoEff_Pnt(Detector, setRho!(SurfacePnt, xRho))
	return  quadgk(integrand , 0, SrcRadius, reltol = relativeError)[1] / SrcRadius^2  
end #function

"""
	GeoEff(Detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	
Returns the Geometrical Efficiency for a gamma source (point, disk or cylinder) with cylindrical detector

aSurfacePNT: a surface point (in case SrcRadius = SrcLength = 0;
			 the method returns the Geometrical Efficiency at this point ).\n
			 
SrcRadius: Radius of the source. ( in case srcHieght = 0;
		   the method returns Geometrical Efficiency for disc of Radius =
		   SrcRadius and its center is defined by aSurfacePNT).\n

srcHieght:  the height of upright cylinder source having a base like described above.\n

example:-

	newDet = CylDetector()
	eff = GeoEff(newDet, aSurfacePNT, SrcRadius, SrcLength)

Note
\n*****
- point height is measured from the detector surface.
"""
function GeoEff(Detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	pnt::Point = deepcopy(aSurfacePnt)
	@assert Detector.CryRadius > SrcRadius		" Source Raduis: Expected less than 'Detctor Raduis=$(Detector.CryRadius)', get $SrcRadius."

    if 0.0 == SrcRadius
		@assert Detector.CryRadius  > pnt.Rho	" Point off-axis: Expected less than 'Detctor Raduis=$(Detector.CryRadius)', get $(pnt.Rho)."
        return GeoEff_Pnt(Detector, pnt)/2            	#Point source

	elseif 0.0 == SrcLength								#Disk source
        return GeoEff_Disk(Detector, pnt, SrcRadius)

	else												#Cylinderical source	
        integrand(xH) = GeoEff_Disk(Detector, setHeight!(pnt, xH), SrcRadius)
		return quadgk(integrand , pnt.Height, pnt.Height + SrcLength, reltol = relativeError)[1] / SrcLength   

	end #if
end #function

"""
	GeoEff(Detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
returns the Geometrical Efficiency for the given . (point , disk or cylinder) with Bore-Hole Detector

aCenterPNT: a center point (in case SrcRadius = SrcLength = 0;
		 the method returns the Geometrical Efficiency at this point ).

SrcRadius: Raduis of the source. ( in case SrcLength = 0;
		 the method returns Geometrical Efficiency for disc of Radius
		 = SrcRadius and its center is defined by aCenterPNT).

SrcLength:  the height of upright cylinder source having a base like described above.

example:-
	newDet = BoreDetector()
	efff = GeoEff(newDet, aCenterPNT, SrcRadius, SrcLength)
Note:
\n*****
- point height is measured from the detector middle, +ve value are above the detector center while -ve are below.
"""
function GeoEff(Detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

	HeightWup = aCenterPnt.Height - Detector.CryLength/2.0
	HeightWdown = aCenterPnt.Height + Detector.CryLength/2.0
	if HeightWdown < 0.0 
		if HeightWup + SrcLength < 0.0 		#invert the source.
			return GeoEff(Detector, Point(aCenterPnt.Height - Detector.CryLength, aCenterPnt.Rho), SrcRadius, SrcLength)

		else # the source span the detector and emerges from both sides, split the source into two sources. 
			#res = (1 - 2 * GeoEff(detin, Point(0.0), SrcRadius, SrcLength))* Detector.CryLength /SrcLength
			res = GeoEff(Detector, Point(0.0), SrcRadius, -aCenterPnt.Height )* (-aCenterPnt.Height /SrcLength)
			res += GeoEff(Detector, Point(0.0), SrcRadius, SrcLength + aCenterPnt.Height )* (1.0 + aCenterPnt.Height /SrcLength)
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
		res = GeoEff(detout, pntWup, SrcRadius, SrcLength)[1]
		res -= GeoEff(detin, pntWdown, SrcRadius, SrcLength)[1]

	elseif HeightWup + SrcLength < 0.0 		# the source as a whole in the detector			
		res = 1 - GeoEff(detin, setHeight(pntWup,abs(HeightWup + SrcLength)), SrcRadius, SrcLength)[1]
		res -= GeoEff(detin, pntWdown, SrcRadius, SrcLength)[1]

	else # elseif SrcLength > 0.0
		res = (1.0 - GeoEff(detin, Point(0.0), SrcRadius, -HeightWup)[1] )* -HeightWup/SrcLength
		res += GeoEff(detout, Point(0.0), SrcRadius, HeightWup + SrcLength)[1] * (1.0 + HeightWup/SrcLength)
		return res

	#=else
		return 1.0 - GeoEff(detin, setHeight!(pnt, -Height), SrcRadius)[1] 
	else
		res = 1 - quadgk(xH -> GeoEff_Disk(detin, setHeight!(pnt, xH), SrcRadius), 0.0, -pnt.Height, reltol = relativeError)[1]
		res = res + quadgk(xH -> GeoEff_Disk(detout, setHeight!(pntWup, xH), SrcRadius), 0.0, pntWup.Height , reltol = relativeError)[1]
			=#
	end #if
	
	return res
end #function

"""
	GeoEff(Detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
Returns the Geometrical Efficiency for the given source (point, disk or cylinder) with Well-Type detector

aWellPNT: a Well point (in case SrcRadius = SrcLength = 0;
		 the method returns the Geometrical Efficiency at this point ).\n
SrcRadius: Radius of the source. ( in case SrcLength = 0;
		  the method returns Geometrical Efficiency for disc of Radius
		  = SrcRadius and its center is defined by aWellPNT).\n
SrcLength:  the height of upright cylinder source having a base like described above.\n

Example:-

	newDet = WellDetector()
	eff - GeoEff(newDet, aWellPNT, SrcRadius, SrcLength)
Note
\n*****
- point height is measured from the detector hole surface.
"""
function GeoEff(Detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	pnt::Point = deepcopy(aWellPnt)
	Height = pnt.Height - Detector.HoleDepth
	
	detin::CylDetector = CylDetector(Detector.HoleDepth)
	detout::CylDetector = CylDetector(Detector.CryRadius)
	setHeight!(pnt, Height); #0.0 == SrcRadius && setRho!(pnt, 0.0)
	
	if Height > 0.0							# the source as a whole out of the detector	
		return GeoEff(detout, setHeight!(pnt, Height), SrcRadius, SrcLength)[1]
		
	elseif Height + SrcLength < 0.0 		# the source as a whole inside of the detector
		return 1.0 - GeoEff(detin, setHeight!(pnt, -(Height + SrcLength) ), SrcRadius, SrcLength)[1] 
	
	elseif SrcLength > 0.0
		res = (1.0 - GeoEff(detin, Point(0.0), SrcRadius, -Height)[1] )* -Height/SrcLength
		res += GeoEff(detout, Point(0.0), SrcRadius, Height + SrcLength)[1] * (1.0 + Height/SrcLength)
		return res
	
	else
		return 1.0 - GeoEff(detin, setHeight!(pnt, -Height), SrcRadius)[1] 
	
	end #if
end #function