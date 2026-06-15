"""
Core calculations for geometrical efficiency.

This module contains all functions responsible for calculating the geometrical
efficiency of radiation detectors with various source configurations.
"""

import math
import copy
from .config import integrate, relative_error, absolute_error
from .physics_model import Point, CylDetector, BoreDetector, WellDetector
from .error import not_implemented_error, invalid_geometry


# ============================================================================
# Private Utility Functions
# ============================================================================

def _clamp(value, min_val, max_val):
    """Clamp a value between min and max."""
    return max(min_val, min(max_val, value))


# ============================================================================
# Core Calculation Functions for CylDetector
# ============================================================================

def _geoEff_pnt_cyl(detector, a_pnt):
    """
    Calculate geometrical efficiency for a point source on cylindrical detector.
    
    This is the base function that all other functions call to calculate
    geometrical efficiency for the cylindrical-ish detector family.
    
    Parameters
    ----------
    detector : CylDetector
        The cylindrical detector
    a_pnt : Point
        The point source
    
    Returns
    -------
    float
        Geometrical efficiency
    
    Raises
    ------
    InValidGeometry
        If point location is invalid (e.g., inside detector)
    NotImplementedError
        If point is off-axis and out of detector face
    """
    # Check if point is inside detector (invalid)
    if (detector.cry_radius > a_pnt.rho and a_pnt.height < 0.0):
        invalid_geometry("The point source location can't be inside the detector")
    
    def max_phi(theta):
        """Calculate maximum phi angle for given theta."""
        side = a_pnt.height * math.sin(theta)
        if abs(side) < 1e-15:  # Avoid division by zero
            return 0.0
        numerator = a_pnt.rho**2 + side**2 - detector.cry_radius**2
        denominator = side * a_pnt.rho * 2.0
        if abs(denominator) < 1e-15:
            return 0.0
        val = numerator / denominator
        val = _clamp(val, -1.0, 1.0)
        return math.acos(val)
    
    def func(theta):
        """Integrand function."""
        return max_phi(theta) * math.sin(theta)
    
    # Axial point (rho == 0)
    if abs(a_pnt.rho) < 1e-15:
        start = 0.0
        end = math.atan(detector.cry_radius / a_pnt.height)
        result, _ = integrate(math.sin, start, end, 
                            epsrel=relative_error, epsabs=absolute_error)
        return result
    
    # Non-axial point
    else:
        start = 0.0
        transition = math.atan((detector.cry_radius - a_pnt.rho) / a_pnt.height)
        end = math.atan((detector.cry_radius + a_pnt.rho) / a_pnt.height)
        
        if transition >= 0.0:
            result1, _ = integrate(math.sin, start, transition,
                                 epsrel=relative_error, epsabs=absolute_error)
            result2, _ = integrate(func, transition, end,
                                 epsrel=relative_error, epsabs=absolute_error)
            return result1 + result2 / math.pi
        else:
            not_implemented_error("Point off-axis, out of the detector face")


def _geoEff_disk_cyl(detector, surface_pnt, src_radius):
    """
    Calculate geometrical efficiency for disk source on cylindrical detector.
    
    Parameters
    ----------
    detector : CylDetector
        The cylindrical detector
    surface_pnt : Point
        Center point of the disk source
    src_radius : float
        Radius of the disk source
    
    Returns
    -------
    float
        Geometrical efficiency
    """
    if detector.cry_radius < surface_pnt.rho + src_radius:
        raise ValueError(
            f"Off-axis source out of detector face: "
            f"SrcRadius={src_radius}, CryRadius={detector.cry_radius}, Rho={surface_pnt.rho}")
    
    def integrand(x_rho):
        """Integrand: x_rho * GeoEff for point at radius x_rho."""
        pnt = Point(surface_pnt.height, x_rho)
        return x_rho * _geoEff_pnt_cyl(detector, pnt)
    
    result, _ = integrate(integrand, 0.0, src_radius,
                        epsrel=relative_error, epsabs=absolute_error)
    return result / (src_radius ** 2)


def _geoEff_cyl(detector, a_surface_pnt, src_radius=0.0, src_length=0.0):
    """
    Calculate geometrical efficiency for cylindrical detector.
    
    Parameters
    ----------
    detector : CylDetector
        The cylindrical detector
    a_surface_pnt : Point
        Reference point on detector surface
    src_radius : float, optional
        Source radius (0 = point source)
    src_length : float, optional
        Source length (0 = point or disk source)
    
    Returns
    -------
    float
        Geometrical efficiency
    
    Notes
    -----
    Point height is measured from detector face surface.
    """
    if detector.cry_radius < src_radius + a_surface_pnt.rho:
        raise ValueError(
            f"Source Radius: Expected less than 'detector radius="
            f"{detector.cry_radius}', got {src_radius}")
    
    pnt = copy.copy(a_surface_pnt)
    
    if abs(src_radius) < 1e-15:  # Point source
        if detector.cry_radius <= a_surface_pnt.rho:
            raise ValueError(
                f"Point off-axis: Expected less than 'detector radius="
                f"{detector.cry_radius}', got {a_surface_pnt.rho}")
        return _geoEff_pnt_cyl(detector, pnt) / 2.0
    
    elif abs(src_length) < 1e-15:  # Disk source
        return _geoEff_disk_cyl(detector, pnt, src_radius)
    
    else:  # Cylindrical source
        def integrand(x_h):
            """Integrate over source height."""
            pnt_at_h = Point(x_h, pnt.rho)
            return _geoEff_disk_cyl(detector, pnt_at_h, src_radius)
        
        result, _ = integrate(integrand, a_surface_pnt.height,
                            a_surface_pnt.height + src_length,
                            epsrel=relative_error, epsabs=absolute_error)
        return result / src_length


def _geoEff_bore(detector, a_center_pnt, src_radius=0.0, src_length=0.0):
    """
    Calculate geometrical efficiency for bore-hole detector.
    
    Parameters
    ----------
    detector : BoreDetector
        The bore-hole detector
    a_center_pnt : Point
        Reference point at detector center
    src_radius : float, optional
        Source radius
    src_length : float, optional
        Source length
    
    Returns
    -------
    float
        Geometrical efficiency
    
    Notes
    -----
    Point height is measured from detector middle.
    """
    # Create virtual cylindrical detectors for calculation
    height_up = a_center_pnt.height - detector.cry_length / 2.0
    height_down = a_center_pnt.height + detector.cry_length / 2.0
    
    if height_down < 0.0:
        if height_up + src_length < 0.0:  # Invert source
            return _geoEff_bore(detector, 
                               Point(a_center_pnt.height - detector.cry_length, a_center_pnt.rho),
                               src_radius, src_length)
    
    # Create equivalent cylindrical detector for calculation
    cyl_eq = CylDetector(detector.cry_radius, detector.cry_length)
    surface_pnt = Point(height_up, a_center_pnt.rho)
    
    return _geoEff_cyl(cyl_eq, surface_pnt, src_radius, src_length)


def _geoEff_well(detector, a_surface_pnt, src_radius=0.0, src_length=0.0):
    """
    Calculate geometrical efficiency for well-type detector.
    
    Parameters
    ----------
    detector : WellDetector
        The well-type detector
    a_surface_pnt : Point
        Reference point on detector surface
    src_radius : float, optional
        Source radius
    src_length : float, optional
        Source length
    
    Returns
    -------
    float
        Geometrical efficiency
    """
    # Simplified implementation using equivalent cylinder
    cyl_eq = CylDetector(detector.cry_radius, detector.cry_length)
    return _geoEff_cyl(cyl_eq, a_surface_pnt, src_radius, src_length)


# ============================================================================
# Public API Function
# ============================================================================

def geoEff(detector, a_pnt, src_radius=0.0, src_length=0.0):
    """
    Calculate geometrical efficiency for a detector-source configuration.
    
    Parameters
    ----------
    detector : CylDetector, BoreDetector, or WellDetector
        The radiation detector
    a_pnt : Point
        Reference point (interpretation varies by detector type):
        - CylDetector: measured from detector face surface
        - BoreDetector: measured from detector middle
        - WellDetector: measured from detector hole surface
    src_radius : float, optional
        Source radius in cm (0 = point source, default: 0.0)
    src_length : float, optional
        Source length in cm (0 = point or disk source, default: 0.0)
    
    Returns
    -------
    float
        Geometrical efficiency (value between 0 and 1)
    
    Raises
    ------
    TypeError
        If detector type is not supported
    ValueError
        If geometry is invalid
    NotImplementedError
        If geometry configuration is not implemented
    
    Examples
    --------
    >>> detector = CylDetector(5.0, 30.0)  # 5cm radius, 30cm length
    >>> pnt = Point(10.0, 0.0)              # 10cm from detector face, on axis
    >>> eff = geoEff(detector, pnt)
    >>> print(f"Efficiency: {eff:.4f}")
    
    >>> # Disk source
    >>> eff_disk = geoEff(detector, pnt, src_radius=2.0)
    
    >>> # Cylindrical source
    >>> eff_cyl = geoEff(detector, pnt, src_radius=2.0, src_length=5.0)
    """
    if isinstance(detector, CylDetector):
        return _geoEff_cyl(detector, a_pnt, src_radius, src_length)
    elif isinstance(detector, BoreDetector):
        return _geoEff_bore(detector, a_pnt, src_radius, src_length)
    elif isinstance(detector, WellDetector):
        return _geoEff_well(detector, a_pnt, src_radius, src_length)
    else:
        raise TypeError(f"Unsupported detector type: {type(detector)}")
