# GeoEfficiency - Python Port

A Python port of the Julia package for calculating geometrical efficiency of radiation detectors.

## Requirements

- Python 3.7+
- numpy >= 1.19
- scipy >= 1.5

## Installation

```bash
pip install -r requirements.txt
```

## Quick Usage

```python
from geoefficiency import CylDetector, Point, geoEff, calc, calcN, batch

# Calculate efficiency for a point source
detector = CylDetector(5.0, 30.0)
pnt = Point(10.0, 0.0)
efficiency = geoEff(detector, pnt)
print(f"Efficiency: {efficiency}")

# Interactive calculation
calc()

# Batch processing
batch()
```

## Documentation

See the original Julia package documentation at:
https://GeoEfficiency.GitHub.io/dev/index.html

## Package Structure

- `config.py` - Configuration parameters
- `error.py` - Custom exception classes
- `physics_model.py` - Physical objects (Point, Detector types)
- `calculations.py` - Core efficiency calculations
- `input_console.py` - Interactive console input
- `input_batch.py` - Batch file processing
- `output_interface.py` - Result display and reporting

## Features

- ✅ Cylindrical detector geometries
- ✅ Bore-hole detector geometries  
- ✅ Well-type detector geometries
- ✅ Point source calculations
- ✅ Disc source calculations
- ✅ Cylindrical source calculations
- ✅ Interactive and batch modes
- ✅ Comprehensive error handling
