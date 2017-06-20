#**************************************************************************************
# Calculations.jl
# =============== part of the GeoEfficiency.jl package.
#
# this file collect all the function that calculate the Geometrical Efficiency.
#
#**************************************************************************************

# set the global minimum relative precession of the Geometrical Efficiency Calculations
isconst(:relativeError) ||  const relativeError = 0.0001	
isconst(:absoluteError) ||  const absoluteError = 0.00000000001
isconst(:integrate )    ||  const integrate     = begin using QuadGK; QuadGK.quadgk; end


#-----------GeoEff_Pnt------------------------------------------------------

"""# unexported function

	GeoEff_Pnt(detector::CylDetector, aPnt::Point)  

return the Geometrical Efficiency for the point source `aPnt` located on front
of the cylindrical detector `detector` face.

`Throw` an  error if the point is out of the cylindrical detector `detector` face.

!!! note
    This is the base function that all other function call directly or indirectly
    to calculate Geometrical Efficiency.

"""
function GeoEff_Pnt(detector::CylDetector, aPnt::Point)

	function MaxPhi(theta::Float64 )
		side = aPnt.Height * sin(theta)
		return clamp((aPnt.Rho^2 + side^2 - detector.CryRadius^2 )/ side / aPnt.Rho /2.0, -1.0, 1.0) |> acos
	end # function

	func(theta::Float64) = MaxPhi(theta) * sin(theta)

	if 0.0 == aPnt.Rho
		strt = 0.0
		fine = atan2(detector.CryRadius , aPnt.Height)
		return integrate(sin, strt, fine, reltol = relativeError)[1]

	else
		strt = 0.0
		transtion = atan2(detector.CryRadius - aPnt.Rho, aPnt.Height)
		fine = atan2(detector.CryRadius + aPnt.Rho, aPnt.Height)
		if transtion >= 0.0

		 	return integrate(sin, strt, transtion, reltol = relativeError)[1] +
                      			integrate(func, transtion, fine, reltol = relativeError)[1] / pi

		else
			 error("GeoEff_Pnt: Point off-axis, out of the detector face. This case is not implemented yet")

		end #if

	end #if
end #function


#-----------GeoEff_Disk------------------------------------------------------

"""# unexported function

	GeoEff_Disk(detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)

return the Geometrical Efficiency for a disk source. The disk center is `SurfacePnt` and its radius is `SrcRadius` 
on front of the cylindrical detector `detector` face.

give a warning if the disk is out of cylindrical detector the face.

"""
function GeoEff_Disk(detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)
	(detector.CryRadius > SurfacePnt.Rho + SrcRadius) || warn("GeoEff_Disk: Off the detector face sources is not supported yet SrcRadius = $(SrcRadius), CryRadius = $(detector.CryRadius )")
	
	integrand(xRho) = xRho * GeoEff_Pnt(detector, setRho!(SurfacePnt, xRho))
	return  integrate(integrand , 0.0, SrcRadius, reltol = relativeError)[1] / SrcRadius^2

end #function

#------------geoEff-----------------------------------------------------


"""

	geoEff(detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

return the Geometrical Efficiency for a source (point, disk or cylinder) with the cylindrical detector `detector`.

 *  `aSurfacePNT`: a surface point represennt the anchoring point of the source.
if both `SrcRadius` and `SrcLength` equal to `zero`; the method returns the Geometrical Efficiency of a point source at the anchoring point.

 *  `SrcRadius`: Radius of the source.
SrcLength` equal to `zero`; the method returns Geometrical Efficiency for disc of Radius = `SrcRadius` and
its base circle center is the point `aSurfacePNT`.

 *  `srcHieght`:  the height of an upright cylinder source having a base like described above.

!!! note
    *  `aSurfacePnt`: point height is consider to be measured from the detector face surface.

    *  `Throw` an Error if the source location is inappropriate.

# Example

to obtain the efficiency of a cylindrical detector of crystal radius 2.0 cm for axial cylinder of radius 1.0 cm and height 2.5 cm 
on the detector surface.

```jldoctest
    julia> geoEff(CylDetector(2), Point(0), 1.0, 2.5)
    0.49999999999999994
```
\n*****

"""
function geoEff(detector::CylDetector, aSurfacePnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	detector.CryRadius > SrcRadius	||	warn("geoEff: Source Radius: Expected less than 'detector Radius=$(detector.CryRadius)', get $SrcRadius.")
	
	pnt::Point = deepcopy(aSurfacePnt)
		
	if 0.0 == SrcRadius                         #Point source
	
		detector.CryRadius  > pnt.Rho  ||	warn("geoEffPoint off-axis: Expected less than 'detector Radius=$(detector.CryRadius)', get $(pnt.Rho).")
        return GeoEff_Pnt(detector, pnt)/2            	

	elseif 0.0 == SrcLength						#Disk source
	
        return GeoEff_Disk(detector, pnt, SrcRadius)

	else										# Cylindrical source
	
        integrand(xH) = GeoEff_Disk(detector, setHeight!(pnt, xH), SrcRadius)
		return integrate(integrand , pnt.Height, pnt.Height + SrcLength, reltol = relativeError)[1] / SrcLength

	end #if
end #function

"""

	geoEff(detector::RadiationDetector = RadiationDetector())

return the Geometrical Efficiency of the given detector or if no detector is supplied it ask for a detector from the `console`. 
Any way prompt the user to input a source via the `console`.

!!! note
    `Throw` an Error if the source location is inappropriate.
\n*****

"""
geoEff(detector::RadiationDetector = RadiationDetector()) = geoEff(detector, source()...)


"""

	geoEff(detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

return the Geometrical Efficiency for the given source (point , disk or cylinder) with the Bore-Hole detector `detector`.

 *  `aCenterPNT`: a center point represent the anchoring point of the source.
if both `SrcRadius` and `SrcLength` equal to `zero`; the method returns the Geometrical Efficiency of a point source at the anchoring point.

 *  `SrcRadius`: Radius of the source.
SrcLength` equal to `zero`;  the method returns Geometrical Efficiency for disc of Radius = `SrcRadius`
and its center is the point `aCenterPNT`.

 *  `SrcLength`: the height of an upright cylinder source having a base like described above.

!!! note
    *  `aCenterPNT` : point `height` is consider to be measured from the detector middle, +ve value are above the detector center while -ve are below.

    *  `Throw` an Error if the source location is inappropriate.

# Example

to obtain the efficiency for a bore-hole detector of crystal radius of 2.0 and height of 3.0 with hole radius of 1.5 cm for axial cylinder of radius 1.0 cm and height 2.5 cm starting from detector center.
```jldoctest
	julia> newDet = BoreDetector(2.0, 3.0, 1.5)
    BoreDetector[CryRadius=2.0, CryLength=3.0, HoleRadius=1.5]

	julia> geoEff(newDet, Point(0), 1.0, 2.5)
	0.5678174038944723
```
\n*****

"""
function geoEff(detector::BoreDetector, aCenterPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

	HeightWup = aCenterPnt.Height - detector.CryLength/2.0
	HeightWdown = aCenterPnt.Height + detector.CryLength/2.0
	if HeightWdown < 0.0
		if HeightWup + SrcLength < 0.0 		#invert the source.
			return geoEff(detector, Point(aCenterPnt.Height - detector.CryLength, aCenterPnt.Rho), SrcRadius, SrcLength)

		else # the source span the detector and emerges from both sides, split the source into two sources.
			#res = (1 - 2 * geoEff(detin, Point(0.0), SrcRadius, SrcLength))* detector.CryLength /SrcLength
			return geoEff(detector, Point(0.0), SrcRadius, -aCenterPnt.Height ) * (-aCenterPnt.Height /SrcLength) +
			       geoEff(detector, Point(0.0), SrcRadius, SrcLength + aCenterPnt.Height ) * (1.0 + aCenterPnt.Height /SrcLength)

		end
	end

	pntWup::Point = deepcopy(aCenterPnt);
	setHeight(aCenterPnt, abs(HeightWup));  #0.0 == SrcRadius && setRho!(pntWup, 0.0)

	pntWdown::Point = deepcopy(aCenterPnt);
	setHeight!(pntWdown, abs(HeightWdown)); #0.0 == SrcRadius && setRho!(pntWdown, 0.0)

	detin::CylDetector = CylDetector(detector.HoleRadius)
	detout::CylDetector = CylDetector(detector.CryRadius)


	if HeightWup >= 0.0						# the source as a whole out of detector
		res = geoEff(detout, pntWup, SrcRadius, SrcLength) - geoEff(detin, pntWdown, SrcRadius, SrcLength)

	elseif HeightWup + SrcLength < 0.0 		# the source as a whole in the detector
		res = 1 - geoEff(detin, setHeight(pntWup,abs(HeightWup + SrcLength)), SrcRadius, SrcLength)
		res -= geoEff(detin, pntWdown, SrcRadius, SrcLength)

	else # elseif SrcLength > 0.0
		res = (1.0 - geoEff(detin, Point(0.0), SrcRadius, -HeightWup))* -HeightWup/SrcLength
		res += geoEff(detout, Point(0.0), SrcRadius, HeightWup + SrcLength) * (1.0 + HeightWup/SrcLength)

	#=else
		return 1.0 - geoEff(detin, setHeight!(pnt, -Height), SrcRadius)[1]
	else
		res = 1 - integrate(xH -> GeoEff_Disk(detin, setHeight!(pnt, xH), SrcRadius), 0.0, -pnt.Height, reltol = relativeError)[1]
		res = res + integrate(xH -> GeoEff_Disk(detout, setHeight!(pntWup, xH), SrcRadius), 0.0, pntWup.Height , reltol = relativeError)[1]
			=#
	end #if

	return res
end #function

"""

	geoEff(detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)

return the Geometrical Efficiency for the given source (point, disk or cylinder) with the Well-Type detector `detector`.

 *  `aWellPNT`: a Well point represent the anchoring point of the source.
if both `SrcRadius` and `SrcLength` equal to `zero`; the method returns the Geometrical Efficiency of a point source at the anchoring point.

 *  `SrcRadius`: radius of the source.
SrcLength` equal to `zero`;   the method returns Geometrical Efficiency for disk of Radius = `SrcRadius`
and its center is defined by the `aWellPNT`.

 *  `SrcLength`: height of upright cylinder source having a base like described above.

!!! note
    *  `aWellPNT` : point `height` is considered to be measured from the detector hole surface.

    *  `Throw` an Error if the source location is inappropriate.

# Example

to obtain the efficiency for a well-type detector of crystal radius of 2.0 and height 3.0 with hole radius of 1.5 cm and depth of 1.0 for axial cylinder of radius 1.0 cm and height 2.5 cm at the hole surface.
```jldoctest
	julia> newDet = WellDetector(2.0, 3.0, 1.5, 1.0)
	WellDetector[CryRadius=2.0, CryLength=3.0, HoleRadius=1.5, HoleDepth=1.0]

	julia> geoEff(newDet, Point(0), 1.0, 2.5)
	0.4669614527701105
```
\n*****

"""
function geoEff(detector::WellDetector, aWellPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)
	
	pnt::Point = deepcopy(aWellPnt)
	Height = pnt.Height - detector.HoleDepth

	detin::CylDetector = CylDetector(detector.HoleRadius)
	detout::CylDetector = CylDetector(detector.CryRadius)
	setHeight!(pnt, Height); #0.0 == SrcRadius && setRho!(pnt, 0.0)

	if Height > 0.0							# the source as a whole out of the detector
		return geoEff(detout, setHeight!(pnt, Height), SrcRadius, SrcLength)

	elseif Height + SrcLength < 0.0 		# the source as a whole inside of the detector
		return 1.0 - geoEff(detin, setHeight!(pnt, -(Height + SrcLength) ), SrcRadius, SrcLength)

	elseif SrcLength > 0.0
		res = (1.0 - geoEff(detin, Point(0.0), SrcRadius, -Height)) * -Height/SrcLength
		res += geoEff(detout, Point(0.0), SrcRadius, Height + SrcLength) * (1.0 + Height/SrcLength)
		return res

	else
		return 1.0 - geoEff(detin, setHeight!(pnt, -Height), SrcRadius)

	end #if
end #function
