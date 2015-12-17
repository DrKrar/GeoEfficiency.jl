type Point
	Height::Float64
	Rho::Float64
	
	Point(Height, Rho) = new(float(Height), float(Rho))
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


abstract GammaDetector
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
accourding to the input from the console.
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