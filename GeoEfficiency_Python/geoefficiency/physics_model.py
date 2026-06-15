"""
Physics model classes for GeoEfficiency package.

This module contains classes representing physical objects:
- Point: A point in space (source or anchor point)
- Detector: Base detector class
- CylDetector: Cylindrical detector
- BoreDetector: Bore-hole (coaxial) detector
- WellDetector: Well-type detector
"""

import math
from .error import validate_detector, invalid_geometry, not_implemented_error


# ============================================================================
# Point Class
# ============================================================================

class Point:
    """
    Represents a point in space relative to a detector.
    
    A Point can represent either a point source or an anchor point for
    higher-dimension sources (disc, cylinder, etc.).
    
    Parameters
    ----------
    height : float
        Point height relative to the detector (interpretation varies by detector type)
    rho : float, optional
        Point off-axis distance from detector axis of symmetry (default: 0.0)
    
    Attributes
    ----------
    height : float
        Point height
    rho : float
        Off-axis distance
    
    Notes
    -----
    Height interpretation by detector type:
    - CylDetector: measured from detector face surface
    - BoreDetector: measured from detector middle (+ve above, -ve below)
    - WellDetector: measured from detector hole surface
    """
    
    def __init__(self, height, rho=0.0):
        self.height = float(height)
        self.rho = float(rho)
    
    def __repr__(self):
        return f"Point(height={self.height}, rho={self.rho})"
    
    def __str__(self):
        return f"Point[Height={self.height}, Rho={self.rho}]"
    
    def __eq__(self, other):
        if not isinstance(other, Point):
            return False
        return math.isclose(self.height, other.height) and math.isclose(self.rho, other.rho)
    
    def __lt__(self, other):
        """Compare points by height, then by rho."""
        if not isinstance(other, Point):
            return NotImplemented
        if not math.isclose(self.height, other.height):
            return self.height < other.height
        return self.rho < other.rho


# ============================================================================
# Detector Classes
# ============================================================================

class Detector:
    """
    Base class for radiation detectors.
    
    This abstract base class defines the interface for detector types.
    """
    
    def __init__(self):
        pass
    
    def __repr__(self):
        return f"{self.__class__.__name__}()"


class CylDetector(Detector):
    """
    Cylindrical detector.
    
    A cylindrical detector with specified crystal radius and length.
    
    Parameters
    ----------
    cry_radius : float
        Crystal (active) radius in cm
    cry_length : float
        Crystal (active) length (height) in cm
    
    Attributes
    ----------
    cry_radius : float
        Crystal radius
    cry_length : float
        Crystal length
    
    Raises
    ------
    InValidDetectorDim
        If cry_radius or cry_length is not positive
    """
    
    def __init__(self, cry_radius, cry_length):
        super().__init__()
        cry_radius = float(cry_radius)
        cry_length = float(cry_length)
        
        validate_detector(cry_radius > 0, f"Crystal radius must be positive, got {cry_radius}")
        validate_detector(cry_length > 0, f"Crystal length must be positive, got {cry_length}")
        
        self.cry_radius = cry_radius
        self.cry_length = cry_length
    
    def __repr__(self):
        return f"CylDetector(cry_radius={self.cry_radius}, cry_length={self.cry_length})"
    
    def __str__(self):
        return f"Cylindrical Detector[Radius={self.cry_radius}cm, Length={self.cry_length}cm]"
    
    def __eq__(self, other):
        if not isinstance(other, CylDetector):
            return False
        return (math.isclose(self.cry_radius, other.cry_radius) and
                math.isclose(self.cry_length, other.cry_length))


class BoreDetector(Detector):
    """
    Bore-hole (coaxial) detector.
    
    A cylindrical detector with a hole drilled through its center.
    
    Parameters
    ----------
    cry_radius : float
        Outer crystal radius in cm
    cry_length : float
        Crystal length in cm
    hole_radius : float
        Hole radius in cm
    
    Attributes
    ----------
    cry_radius : float
        Outer crystal radius
    cry_length : float
        Crystal length
    hole_radius : float
        Hole radius
    
    Raises
    ------
    InValidDetectorDim
        If dimensions are invalid (hole must be smaller than crystal radius)
    """
    
    def __init__(self, cry_radius, cry_length, hole_radius):
        super().__init__()
        cry_radius = float(cry_radius)
        cry_length = float(cry_length)
        hole_radius = float(hole_radius)
        
        validate_detector(cry_radius > 0, f"Crystal radius must be positive, got {cry_radius}")
        validate_detector(cry_length > 0, f"Crystal length must be positive, got {cry_length}")
        validate_detector(hole_radius >= 0, f"Hole radius must be non-negative, got {hole_radius}")
        validate_detector(hole_radius < cry_radius, 
                         f"Hole radius {hole_radius} must be less than crystal radius {cry_radius}")
        
        self.cry_radius = cry_radius
        self.cry_length = cry_length
        self.hole_radius = hole_radius
    
    def __repr__(self):
        return (f"BoreDetector(cry_radius={self.cry_radius}, cry_length={self.cry_length}, "
                f"hole_radius={self.hole_radius})")
    
    def __str__(self):
        return (f"Bore-hole Detector[Outer Radius={self.cry_radius}cm, Length={self.cry_length}cm, "
                f"Hole Radius={self.hole_radius}cm]")
    
    def __eq__(self, other):
        if not isinstance(other, BoreDetector):
            return False
        return (math.isclose(self.cry_radius, other.cry_radius) and
                math.isclose(self.cry_length, other.cry_length) and
                math.isclose(self.hole_radius, other.hole_radius))


class WellDetector(Detector):
    """
    Well-type detector.
    
    A cylindrical detector with a well (hole) for inserting samples.
    
    Parameters
    ----------
    cry_radius : float
        Outer crystal radius in cm
    cry_length : float
        Crystal length in cm
    hole_radius : float
        Well radius in cm
    hole_depth : float
        Well depth in cm
    
    Attributes
    ----------
    cry_radius : float
        Outer crystal radius
    cry_length : float
        Crystal length
    hole_radius : float
        Well radius
    hole_depth : float
        Well depth
    
    Raises
    ------
    InValidDetectorDim
        If dimensions are invalid
    """
    
    def __init__(self, cry_radius, cry_length, hole_radius, hole_depth):
        super().__init__()
        cry_radius = float(cry_radius)
        cry_length = float(cry_length)
        hole_radius = float(hole_radius)
        hole_depth = float(hole_depth)
        
        validate_detector(cry_radius > 0, f"Crystal radius must be positive, got {cry_radius}")
        validate_detector(cry_length > 0, f"Crystal length must be positive, got {cry_length}")
        validate_detector(hole_radius > 0, f"Hole radius must be positive, got {hole_radius}")
        validate_detector(hole_depth > 0, f"Hole depth must be positive, got {hole_depth}")
        validate_detector(hole_radius < cry_radius,
                         f"Hole radius {hole_radius} must be less than crystal radius {cry_radius}")
        validate_detector(hole_depth <= cry_length,
                         f"Hole depth {hole_depth} must not exceed crystal length {cry_length}")
        
        self.cry_radius = cry_radius
        self.cry_length = cry_length
        self.hole_radius = hole_radius
        self.hole_depth = hole_depth
    
    def __repr__(self):
        return (f"WellDetector(cry_radius={self.cry_radius}, cry_length={self.cry_length}, "
                f"hole_radius={self.hole_radius}, hole_depth={self.hole_depth})")
    
    def __str__(self):
        return (f"Well Detector[Radius={self.cry_radius}cm, Length={self.cry_length}cm, "
                f"Well Radius={self.hole_radius}cm, Well Depth={self.hole_depth}cm]")
    
    def __eq__(self, other):
        if not isinstance(other, WellDetector):
            return False
        return (math.isclose(self.cry_radius, other.cry_radius) and
                math.isclose(self.cry_length, other.cry_length) and
                math.isclose(self.hole_radius, other.hole_radius) and
                math.isclose(self.hole_depth, other.hole_depth))


# ============================================================================
# Source Type Management
# ============================================================================

# Global source type tracking
_src_type = None
_SRC_UNKNOWN = 0
_SRC_POINT = 1
_SRC_DISC = 2
_SRC_CYLINDER = 3


def typeofSrc():
    """
    Get the current source type.
    
    Returns
    -------
    int
        Current source type code
    """
    return _src_type if _src_type is not None else _SRC_UNKNOWN


def setSrcToPoint(value=True):
    """
    Set source type to point source.
    
    Parameters
    ----------
    value : bool, optional
        If True, set to point source; if False, unset (default: True)
    
    Returns
    -------
    bool
        True if source was set to point, False otherwise
    """
    global _src_type
    if value:
        _src_type = _SRC_POINT
        return True
    else:
        _src_type = _SRC_UNKNOWN
        return False


def source(anchor_pnt=None):
    """
    Get source information (anchor point, radius, length).
    
    Parameters
    ----------
    anchor_pnt : Point, optional
        Source anchor point. If None, creates a point at (0, 0)
    
    Returns
    -------
    tuple
        (anchor_point, src_radius, src_length)
    
    Notes
    -----
    For point sources, both radius and length are set to zero.
    """
    if anchor_pnt is None:
        anchor_pnt = Point(0.0, 0.0)
    
    if typeofSrc() == _SRC_POINT:
        return (anchor_pnt, 0.0, 0.0)
    else:
        # Non-point source handling would go here
        # For now, return as point source
        return (anchor_pnt, 0.0, 0.0)
