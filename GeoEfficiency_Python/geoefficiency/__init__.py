"""
GeoEfficiency: Accurate Geometrical Efficiency Calculator

A Python package for calculating the geometrical efficiency of radiation detectors
with various geometries (cylindrical, bore-hole, well-type) as seen from radioactive
sources (point, disc, cylinder).

Quick Usage
-----------
>>> from geoefficiency import CylDetector, Point, geoEff, calc, calcN, batch
>>> 
>>> # Calculate efficiency
>>> detector = CylDetector(5.0, 30.0)
>>> pnt = Point(10.0, 0.0)
>>> eff = geoEff(detector, pnt)
>>> print(f"Efficiency: {eff:.6f}")
>>>
>>> # Interactive calculation
>>> calc()
>>>
>>> # Batch processing
>>> batch()

For detailed documentation, see README.md and individual module docstrings.
"""

__version__ = "0.9.4-dev"
__author__ = "Mohamed E. Krar (Original Julia), Python Port"
__email__ = "DrKrar@gmail.com"

# Import core classes and functions
from .physics_model import (
    Point,
    Detector,
    CylDetector,
    BoreDetector,
    WellDetector,
    source,
    typeofSrc,
    setSrcToPoint,
)

from .calculations import geoEff

from .error import (
    GeoException,
    InValidDetectorDim,
    NotImplementedError,
    InValidGeometry,
    validate_detector,
    not_implemented_error,
    invalid_geometry,
)

from .input_console import (
    calc,
    calcN,
    get_float,
    get_int,
    get_yes_no,
    input_point,
    input_detector,
    input_source,
    show_splash,
)

from .input_batch import (
    get_detectors,
    get_sources,
    process_batch,
    batch_info,
)

from .output_interface import (
    batch,
    display_result,
    summary,
)

from .config import (
    version,
    data_dir,
    results_folder,
    max_display,
    relative_error,
    absolute_error,
)

__all__ = [
    # Physics model
    "Point",
    "Detector",
    "CylDetector",
    "BoreDetector",
    "WellDetector",
    "source",
    "typeofSrc",
    "setSrcToPoint",
    
    # Core calculation
    "geoEff",
    
    # Error handling
    "GeoException",
    "InValidDetectorDim",
    "NotImplementedError",
    "InValidGeometry",
    "validate_detector",
    "not_implemented_error",
    "invalid_geometry",
    
    # Interactive console
    "calc",
    "calcN",
    "get_float",
    "get_int",
    "get_yes_no",
    "input_point",
    "input_detector",
    "input_source",
    "show_splash",
    
    # Batch processing
    "get_detectors",
    "get_sources",
    "process_batch",
    "batch_info",
    
    # Output
    "batch",
    "display_result",
    "summary",
    
    # Configuration
    "version",
    "data_dir",
    "results_folder",
    "max_display",
    "relative_error",
    "absolute_error",
]
