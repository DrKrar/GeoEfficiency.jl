#**************************************************************************************
# Pythical_Model.jl
# =============== part of the GeoEfficiency.jl package.
# 
# here is the place where all physical elements is being modeled and created as computer objects.  
# 
#**************************************************************************************

"""

	Point(Height::Real, Rho::Real)
	
construct and return a point source that can be a source of itself or anchor point of a source.
Height : point height relative to the detector.
Rho : point off axis relative to the detector axis of symmetry.

	Point(Height::Real)
	
the same as Point(Height::Real, Rho::Real) but return an axial point.
Height : point height relative to the detector.

	Point()
	
the same as Point(Height::Real, Rho::Real) but ask the user to provide data from the console.	

Note
\n*****
- each detector interpreted the height in a different way, please consult the help of the detector of interest.
"""

type Point
	Height::Float64
	Rho::Float64
	
	Point(Height::Real, Rho::Real) = new(float(Height), float(Rho))
	function Point(Height::Real)
		Point(Height, 0.0)
	end #function
	function Point()
		print_with_color(:yellow,"\n II- The Radiactive Source Anchor Point:-\n")
		Height = getfloat("\n\t > Height (cm) = ")
		Rho = getfloat("\n\t > Off-axis (cm) = ")
		Point(Height, Rho)
	end #function
end #type
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


"""

	source(;isPoint=false)
	
return a tuple describing the source (aPnt, SrcRadius, SrcLength) based on the user input to the console.
aPnt : the source anchoring point.
SrcRadius : source radius.
SrcLength : source length.
if isPoint is true both SrcRadius, SrcLength are zero.
"""
function source(;isPoint=false)
    aPnt = Point()
	isPoint && return (aPnt, 0.0, 0.0)
    
	SrcRadius = getfloat("\n\t > Source Radius (cm) = ")
    if 0.0 != SrcRadius
        SrcLength = getfloat("\n\t > Source Length (cm) = ")
        aPnt.Rho = 0.0
    
	else
        SrcLength = 0.0
	
	end #if
    return (aPnt, SrcRadius, SrcLength)
end #function


"""

abstract base of all the Gamma Detectors. 
"""
abstract GammaDetector


"""

	CylDetector(CryRadius::Real, CryLength::Real)
	
return a cylindrical detector.
CryRadius : the detector crystal radius.
CryLength : the detector crystal length.
	
	CylDetector(CryRadius::Real)
	
return a cylindrical detector with crystal length 0.0.
CryRadius : the detector crystal radius.

	
	CylDetector()
	
return a cylindrical detector according to the input from the console.
"""
immutable CylDetector <: GammaDetector
	CryRadius::Float64    	#Real
    CryLength::Float64		#Real
	
	function CylDetector(CryRadius::Real, CryLength::Real)
		@assert CryRadius > 0.0					"Crystal Radius: expect +ve number, get $(CryRadius)."
		@assert CryLength >= 0.0				"Crystal Length: expect +ve number or zero, get $(CryLength)."
		new(float(CryRadius), float(CryLength))
	end #if
	function CylDetector(CryRadius::Real)
		CylDetector(CryRadius, 0.0)
	end #if
	function CylDetector()
		print_with_color(:yellow," I- The Cylinderical Detetcor physical Dimensions:-\n")
		CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
		CryLength = getfloat("\n\t > Crystal Length (cm) = ")
		CylDetector(CryRadius, CryLength)
	end #function
end #type	
id(Detector::CylDetector) = "CylDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength)]"


"""

	BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
	
return a bore-hole detector.
CryRadius : the detector crystal radius.
CryLength : the detector crystal length.
HoleRadius : the detector hole radius.
	
	BoreDetector()
	
return a bore-hole detector according to the input from the console.
"""
immutable BoreDetector <: GammaDetector
	CryRadius::Float64    	#Real
    CryLength::Float64    	#Real
	HoleRadius::Float64    	#Real
	
	function BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
		@assert CryRadius > 0.0					"Crystal Radius: expect +ve number, get $(CryRadius)."
		@assert CryLength > 0.0					"Crystal Length: expect +ve number, get $(CryLength)."
		@assert CryRadius > HoleRadius > 0.0	"Hole Radius: expect +ve number Less than 'Crystal Radius=$(CryRadius)', get $(HoleRadius)."
		new(float(CryRadius), float(CryLength), float(HoleRadius))
	end #if
	function BoreDetector()
		print_with_color(:yellow," I- The Bore Hole Detetcor physical Dimensions:-\n")
		CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
		CryLength = getfloat("\n\t > Crystal Length (cm) = ")
		HoleRadius = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryRadius)
		BoreDetector(CryRadius, CryLength, HoleRadius)
	end #function	
end #type
id(Detector::BoreDetector) = "BoreDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength), HoleRadius=$(Detector.HoleRadius)]"


"""

	WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
	
return a Well-Type detector.
CryRadius : the detector crystal radius.
CryLength : the detector crystal length.
HoleRadius : the detector hole radius.
HoleDepth : the detector hole length.
	
	WellDetector()
	
return a Well-Type detector according to the input from the console.
"""
immutable WellDetector <: GammaDetector
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
	function WellDetector()
		print_with_color(:yellow," I- The Well-Type Detetcor physical Dimensions:-\n")
		CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
		CryLength = getfloat("\n\t > Crystal Length (cm) = ")
		HoleRadius = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryRadius)
		HoleDepth = getfloat("\n\t > Hole Radius (cm) = ", 0.0, CryLength)
		WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth)
	end #function	
end #type
id(Detector::WellDetector) = "WellDetector[CryRadius=$(Detector.CryRadius), CryLength=$(Detector.CryLength), HoleRadius=$(Detector.HoleRadius), HoleDepth=$(Detector.HoleDepth)]"


"""

	DetectorFactory()

return an object of the GammaDetector type (CylDetector, BoreDetector or WellDetector) 
according to the input from the console.
"""
function DetectorFactory()
	print_with_color(:yellow, "\n I- The Detector physical Dimensions :-\n")
	CryRadius = getfloat("\n\t > Crystal Radius (cm) = ")
	CryLength = getfloat("\n\t > Crystal Length (cm) = ")
	HoleRadius = getfloat("\n(zero for cylindrical detectors) > Hole Radius (cm) = ", 0.0, CryRadius)
	if   0.0 == HoleRadius
		return CylDetector(CryRadius, CryLength)
	
	else
		HoleDepth = getfloat("\n(zero for Bore-Hole detectors) > Hole Depth (cm) = ", 0.0, CryLength )
		return(0.0 == HoleDepth 			
				? BoreDetector(CryRadius, CryLength, HoleRadius) 
				: WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth)	)		
	end #if
end #function
DetectorFactory(CryRadius::Real) = CylDetector(CryRadius)
DetectorFactory(CryRadius::Real, CryLength::Real) = CylDetector(CryRadius, CryLength)
DetectorFactory(CryRadius::Real, CryLength::Real, HoleRadius::Real) = (0.0 == HoleRadius 
				?  CylDetector(CryRadius, CryLength)
				: BoreDetector(CryRadius, CryLength, HoleRadius)) 
DetectorFactory(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real) = (0.0 == HoleDepth 
				? DetectorFactory(CryRadius, CryLength, HoleRadius)
				: WellDetector(CryRadius, CryLength, HoleRadius, HoleDepth))
DetectorFactory(Detector::GammaDetector) = Detector