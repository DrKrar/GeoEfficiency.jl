"""
Configuration parameters for GeoEfficiency package.

This module contains all configurable parameters including integration method,
precision settings, and data folder locations.
"""

import os
from pathlib import Path
from scipy import integrate as scipy_integrate

# ============================================================================
# Integration Configuration
# ============================================================================

# Integration function: uses scipy's quadrature integration
integrate = scipy_integrate.quad

# Relative error tolerance for numerical integration
relative_error = 1.0e-4

# Absolute error tolerance for numerical integration
absolute_error = float('eps' if hasattr(float, 'eps') else 1.0) * 2.220446049250313e-16

# ============================================================================
# Data Configuration
# ============================================================================

# Data folder for batch processing
data_folder = ".GeoEfficiency"
data_dir = os.path.join(Path.home(), data_folder)

# Results folder for output files
results_folder = "results"

# Maximum display items for batch processing
max_display = 20

# ============================================================================
# Package Version
# ============================================================================

version = "0.9.4-dev"
