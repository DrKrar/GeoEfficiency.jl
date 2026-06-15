# Configuration Guide for GeoEfficiency Python

## Installation

### Using pip

```bash
pip install -r requirements.txt
```

Or install in development mode:

```bash
pip install -e .
```

### Using setup.py

```bash
python setup.py install
```

## Configuration Files

### Data Directories

The package expects data files in the `.GeoEfficiency` folder in your home directory:

- `~/.GeoEfficiency/detectors.csv` - Detector configurations
- `~/.GeoEfficiency/sources.csv` - Source configurations

Sample CSV files are provided in `sample_data/` directory.

### Configuration Parameters

Core configuration is in `geoefficiency/config.py`:

```python
# Integration settings
integrate = scipy_integrate.quad  # Integration function
relative_error = 1.0e-4          # Relative error tolerance
absolute_error = 2.22e-16        # Absolute error tolerance

# Data folders
data_dir = ~/.GeoEfficiency/     # Data folder location
results_folder = "results"       # Output results folder
max_display = 20                 # Max results to display
```

## Using the Package

### As a Library

```python
from geoefficiency import CylDetector, Point, geoEff

# Create detector and point
detector = CylDetector(5.0, 30.0)
pnt = Point(10.0, 0.0)

# Calculate efficiency
efficiency = geoEff(detector, pnt)
print(f"Efficiency: {efficiency}")
```

### Interactive Mode

```python
from geoefficiency import calc, calcN, batch

# Single calculation (prompts for input)
calc()

# Multiple calculations
calcN()

# Batch processing
batch()
```

### Command Line

```bash
# Single interactive calculation
python -m geoefficiency.cli calc

# Multiple calculations
python -m geoefficiency.cli calcN

# Batch processing
python -m geoefficiency.cli batch

# Show summary
python -m geoefficiency.cli summary
```

## Batch Processing

### CSV File Format

#### detectors.csv

```csv
type,radius,length,hole_radius,hole_depth
cyl,5.0,30.0,,
bore,5.0,30.0,1.0,
well,5.0,30.0,1.0,10.0
```

Types:
- `cyl` - Cylindrical detector
- `bore` - Bore-hole (coaxial) detector
- `well` - Well-type detector

#### sources.csv

```csv
height,rho,radius,length
10.0,0.0,0.0,0.0
10.0,0.0,1.0,0.0
10.0,0.0,1.0,5.0
```

Fields:
- `height` - Source height (cm)
- `rho` - Off-axis distance (cm)
- `radius` - Source radius for disk/cylinder (cm)
- `length` - Source length for cylinder (cm)

### Running Batch Processing

```python
from geoefficiency import batch

batch()  # Uses default data folder
```

Results are saved to `results/batch_results.csv`

## Testing

Run tests with pytest:

```bash
pytest tests/
```

Run specific test:

```bash
pytest tests/test_geoefficiency.py::TestPoint::test_point_creation_axial
```

With coverage:

```bash
pytest --cov=geoefficiency tests/
```

## Examples

Run example calculations:

```bash
python examples/basic_examples.py
```

## Troubleshooting

### Import Errors

Make sure the package is installed:

```bash
pip install -e .
```

### Data File Not Found

Create data directory and CSV files:

```bash
mkdir ~/.GeoEfficiency
cp sample_data/detectors.csv ~/.GeoEfficiency/
cp sample_data/sources.csv ~/.GeoEfficiency/
```

### Integration Errors

If numerical integration fails, check:
- Point is not inside detector (invalid geometry)
- Detector dimensions are positive
- Source radius is less than detector radius

## Performance Notes

- Calculations use `scipy.integrate.quad` for numerical integration
- Default tolerances: relative 1e-4, absolute machine epsilon
- Typical single calculation: < 100ms
- Batch processing speed depends on number of configurations

## Python Version Compatibility

- Python 3.7+
- Requires numpy >= 1.19
- Requires scipy >= 1.5

## Further Reading

- Julia original package: https://github.com/DrKrar/GeoEfficiency.jl/
- Documentation: https://GeoEfficiency.GitHub.io/dev/index.html
- Physics model details in docstrings of `physics_model.py`
- Calculation details in `calculations.py`
