#**************************************************************************************
# Pythical_Model.jl
# =============== part of the GeoEfficiency.jl package.
#
# here is the place where all physical elements is being modeled and created as computer objects.
#
#**************************************************************************************

import Base.show

"""
    Point(Height::Real, Rho::Real)

construct and return a `Point` source that can be a source of itself or an
`anchor point` of a source.

`Height` : point height relative to the detector.

`Rho` : point off axis relative to the detector axis of symmetry.
# Note please
+ each detector interpreted the height in a different way as follow.
+ for `CylDetector` the point source `height` is consider to be measured from the detector `face surface`.
+ for `BoreDetector` the point source `height` is consider to be measured from the `detector middle`, +ve value are above the detector center while -ve are below.
+ for `WellDetector` the point source `height` is considered to be measured from the detector `hole surface`.
"""
type Point
	Height::Float64
	Rho::Float64
	Point(Height::Real, Rho::Real) = new(float(Height), float(Rho))
end #type

"""
	Point(Height::Real)

the same as `Point(Height::Real, Rho::Real)` but return an axial point.

`Height` : point height relative to the detector.
"""
Point(Height::Real) = Point(Height, 0.0)

"""
	Point()

the same as `Point(Height::Real, Rho::Real)` but ask the user to provide the
information from the `console`.
"""
function Point()
	print_with_color(:yellow,"\n II- The Radiactive Source Anchor Point:-\n")
	Height = getfloat("\n\t > Height (cm) = ")
	Rho = getfloat("\n\t > Off-axis (cm) = ")
	Point(Height, Rho)
end #function

function setHeight!(aPnt::Point, xH::Real)
	aPnt.Height = xH
	return aPnt
end #function
function setHeight(aPnt::Point, xH::Real)
	pnt::Point = deepcopy(aPnt)
	pnt.Height = xH
	return pnt
end #function
function setRho!(aPnt::Point, xRho::Real)
	aPnt.Rho = xRho
	return aPnt
end #function
function setRho(aPnt::Point, xRho::Real)
	pnt::Point = deepcopy(aPnt)
	pnt.Rho = xRho
	return pnt
end #function
id(aPnt::Point) = "Point[Height=$(aPnt.Height), Rho=$(aPnt.Rho)]"
show(pnt::Point) = print(id(pnt))


"""
	source(;isPoint=false)

return a tuple describing the source (`anchorPnt`, `SrcRadius`, `SrcLength`) based on the user input to the `console`.

`aPnt` : the source anchoring point.

`SrcRadius` : source radius.

`SrcLength` : source length.

If `isPoint` is true both `SrcRadius` and `SrcLength` are set to zero.
"""
function source(;isPoint=false)
    anchorPnt = Point()
	isPoint && return (anchorPnt, 0.0, 0.0)

	SrcRadius = getfloat("\n\t > Source Radius (cm) = ")
    if 0.0 != SrcRadius
        SrcLength = getfloat("\n\t > Source Length (cm) = ")
        anchorPnt.Rho = 0.0

	else
        SrcLength = 0.0

	end #if
    return (anchorPnt, SrcRadius, SrcLength)
end #function


#abstract base of all the Gamma Detectors.
if VERSION < v"0.6.0-dev.2746" # julia PR #20418
    include_string("abstract RadiationDetector")           #for compitaiblity with the syntax change
else
    include_string("abstract type RadiationDetector end")  #for compitaiblity with the syntax change
end
show(io::IO, Detector::RadiationDetector) = print(id(Detector))


"""
	CylDetector(CryRadius::Real, CryLength::Real)

return a `cylindrical` detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.
"""
immutable CylDetector <: RadiationDetector
	CryRadius::Float64    	#Real
  CryLength::Float64		#Real

	function CylDetector(CryRadius::Real, CryLength::Real)
		@assert CryRadius > 0.0	  	"Crystal Radius: expect +ve number, get $(CryRadius)."
		@assert CryLength >= 0.0  	"Crystal Length: expect +ve number or zero, get) $(CryLength)."
		new(float(CryRadius), float(CryLength))
	end #if

end #type

"""
    CylDetector(CryRadius::Real)

return a cylindrical detector with crystal length 0.0.

`CryRadius` : the detector crystal radius.
"""
CylDetector(CryRadius::Real) = CylDetector(CryRadius, 0.0)

"""
    CylDetector()

return a cylindrical detector according to the input from the `console`.
"""
function CylDetector()
	print_with_color(:yellow," I- The Cylinderical Detetcor physical Dimensions:-\n")
	CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
	CryLength = getfloat("\n\t > Crystal Length (cm) = ")
	CylDetector(CryRadius, CryLength)
end #function

id(Detector::CylDetector) = "CylDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength)]"


"""
	BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)

return a `bore-hole` detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.

`HoleRadius` : the detector hole radius.
"""
immutable BoreDetector <: RadiationDetector
	CryRadius::Float64    	#Real
    CryLength::Float64    	#Real
	HoleRadius::Float64    	#Real

	function BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
		@assert CryRadius > 0.0					"Crystal Radius: expect +ve number, get $(CryRadius)."
		@assert CryLength > 0.0					"Crystal Length: expect +ve number, get $(CryLength)."
		@assert CryRadius > HoleRadius > 0.0	"Hole Radius: expect +ve number Less than 'Crystal Radius=$(CryRadius)', get $(HoleRadius)."
		new(float(CryRadius), float(CryLength), float(HoleRadius))
	end #if

end #type

"""
	BoreDetector()

return a bore-hole detector according to the input from the `console`.
"""
function BoreDetector()
	print_with_color(:yellow," I- The Bore Hole Detetcor physical Dimensions:-\n")
	CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
	CryLength = getfloat("\n\t > Crystal Length (cm) = ")
	HoleRadius = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryRadius)
	BoreDetector(CryRadius, CryLength, HoleRadius)
end #function

id(Detector::BoreDetector) = "BoreDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength), HoleRadius=$(Detector.HoleRadius)]"


"""
	WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)

return a Well-Type detector.

`CryRadius` : the detector crystal radius.

`CryLength` : the detector crystal length.

`HoleRadius` : the detector hole radius.

`HoleDepth` : the detector hole length.
"""
immutable WellDetector <: RadiationDetector
	CryRadius::Float64
  CryLength::Float64
	HoleRadius::Float64
	HoleDepth::Float64

	function WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
		@assert CryRadius > 0.0					"Crystal Radius: expect +ve number, get $(CryRadius)."
		@assert CryLength > 0.0					"Crystal Length: expect +ve number, get $(CryLength)."
		@assert CryRadius > HoleRadius > 0.0	"Hole Radius: expect +ve number Less than 'Crystal Radius=$(CryRadius)', get $(HoleRadius)."
		@assert CryLength > HoleDepth > 0.0	   	"Hole Depth: expect +ve number Less than 'Crystal Length=$(CryLength)', get $(HoleDepth)."
		new(float(CryRadius), float(CryLength), float(HoleRadius), float(HoleDepth))
	end #if

end #type

"""
	WellDetector()

return a Well-Type detector according to the input from the `console`.
"""
function WellDetector()
	print_with_color(:yellow," I- The Well-Type Detetcor physical Dimensions:-\n")
	CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
	CryLength = getfloat("\n\t > Crystal Length (cm) = ")
	HoleRadius = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryRadius)
	HoleDepth = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryLength)
	WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth)
end #function

id(Detector::WellDetector) = "WellDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength), HoleRadius=$(Detector.HoleRadius), HoleDepth=$(Detector.HoleDepth)]"


"""
	RadiationDetector()

construct and return an object of the RadiationDetector type (`CylDetector`, `BoreDetector` or `WellDetector`)
according to the input from the console.

# Note please
+ this methode aquire all required information from the `console` and will prompt user on invalid data.
+ if any method with argument(s) take an `invalid` argument it would throw an error.
+ if the value the last argument is `zero` of a method with `more` than one argument it behave as a missing argument.
"""
function RadiationDetector()
	print_with_color(:yellow, "\n I- The Detector physical Dimensions :-\n")
	CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
	CryLength = getfloat("\n\t > Crystal Length (cm) = ")
	HoleRadius = getfloat("\n(zero for cylindrical detectors) > Hole Radius (cm) = ", 0.0, CryRadius)
	if   0.0 == HoleRadius
		return CylDetector(CryRadius, CryLength)

	else
		HoleDepth = getfloat("\n(zero for Bore-Hole detectors) > Hole Depth (cm) = ", 0.0, CryLength )
		return 0.0 == HoleDepth ?
				BoreDetector(CryRadius, CryLength, HoleRadius) :
				WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth)
	end #if
end #function

"""
    RadiationDetector(CryRadius::Real)

return cylindrical detector with zero hieght
"""
RadiationDetector(CryRadius::Real) = CylDetector(CryRadius)

"""
    RadiationDetector(CryRadius::Real, CryLength::Real)

return cylindrical detector
"""
RadiationDetector(CryRadius::Real, CryLength::Real) = CylDetector(CryRadius, CryLength)

"""
    RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)

return bore-hole or cylindrical detector if `HoleRadius` = 0.0
"""
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real) = 0.0 == HoleRadius ?
				                                        CylDetector(CryRadius, CryLength) :
				                                        BoreDetector(CryRadius, CryLength, HoleRadius)

"""
    RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)

return well-type or bore-hole or cylindrical detector
"""
RadiationDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real) = 0.0 == HoleDepth ?
				                                        RadiationDetector(CryRadius, CryLength, HoleRadius):
				                                        WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth)

"""
    RadiationDetector(Detector::RadiationDetector)

return just the inputed detector
"""
RadiationDetector(Detector::RadiationDetector) = Detector
