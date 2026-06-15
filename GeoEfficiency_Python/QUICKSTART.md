# Quick Start Guide

## Installation

```bash
# Install dependencies
pip install -r requirements.txt

# Install package in development mode
pip install -e .
```

## Quick Examples

### Example 1: Simple Calculation
```python
from geoefficiency import CylDetector, Point, geoEff

detector = CylDetector(5.0, 30.0)
source = Point(10.0, 0.0)
efficiency = geoEff(detector, source)
print(f"Efficiency: {efficiency:.6f}")
```

### Example 2: Interactive Mode
```python
from geoefficiency import calc

# Prompts you for detector and source parameters
calc()
```

### Example 3: All Examples
```bash
python examples/basic_examples.py
```

## Command Line Usage

```bash
# Interactive single calculation
python -m geoefficiency.cli calc

# Interactive multiple calculations
python -m geoefficiency.cli calcN

# Batch processing
python -m geoefficiency.cli batch

# Show package info
python -m geoefficiency.cli summary
```

## Running Tests

```bash
# All tests
pytest tests/

# With coverage report
pytest --cov=geoefficiency tests/
```

## Key Classes

### Point
Represents a source point with height and off-axis distance:
```python
pnt = Point(10.0, 0.0)  # 10cm height, on-axis
```

### Detectors
- **CylDetector**: Cylindrical detector
```python
det = CylDetector(radius=5.0, length=30.0)
```

- **BoreDetector**: Bore-hole detector
```python
det = BoreDetector(radius=5.0, length=30.0, hole_radius=1.0)
```

- **WellDetector**: Well-type detector
```python
det = WellDetector(radius=5.0, length=30.0, hole_radius=1.0, hole_depth=10.0)
```

### Main Function
```python
efficiency = geoEff(detector, source_point, src_radius=0.0, src_length=0.0)
```

## Data Format for Batch Processing

### Detectors CSV (~/.GeoEfficiency/detectors.csv)
```csv
type,radius,length,hole_radius,hole_depth
cyl,5.0,30.0,,
bore,5.0,30.0,1.0,
well,5.0,30.0,1.0,10.0
```

### Sources CSV (~/.GeoEfficiency/sources.csv)
```csv
height,rho,radius,length
10.0,0.0,0.0,0.0
10.0,2.0,0.0,0.0
10.0,0.0,1.0,0.0
```

## Documentation Files

- **README.md** - Main documentation
- **CONFIGURATION.md** - Setup and advanced configuration
- **MIGRATION.md** - Julia to Python migration guide
- **PROJECT_SUMMARY.md** - Detailed project overview
- **QUICKSTART.md** - This file

## Support

For issues or questions:
1. Check CONFIGURATION.md for setup help
2. Check MIGRATION.md if coming from Julia version
3. Run examples: `python examples/basic_examples.py`
4. Run tests: `pytest tests/`
5. Read docstrings: `help(geoefficiency.geoEff)`

## What's Included

✅ All core physics calculations  
✅ All detector types (Cyl, Bore, Well)  
✅ Point, disc, and cylindrical sources  
✅ Interactive console interface  
✅ Batch CSV processing  
✅ Comprehensive error checking  
✅ Full test suite (47 tests)  
✅ Example scripts  
✅ CLI interface  
✅ Complete documentation  

Enjoy using GeoEfficiency!
