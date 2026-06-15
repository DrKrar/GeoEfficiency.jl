"""
Output interface for GeoEfficiency results.

This module provides functions for displaying and formatting results
in various output modes.
"""

import os
from .config import results_folder, max_display
from .input_console import calc, calcN
from .input_batch import process_batch, batch_info


def ensure_results_dir():
    """Ensure results directory exists."""
    if not os.path.exists(results_folder):
        os.makedirs(results_folder)
        print(f"Created results directory: {results_folder}")


def display_result(detector, source_point, src_radius, src_length, efficiency):
    """
    Display a single efficiency calculation result.
    
    Parameters
    ----------
    detector : Detector
        The detector used
    source_point : Point
        The source point
    src_radius : float
        Source radius
    src_length : float
        Source length
    efficiency : float
        Calculated efficiency
    """
    print("\n" + "-"*60)
    print("RESULT:")
    print(f"  Detector: {detector}")
    print(f"  Source Point: {source_point}")
    if src_radius > 0:
        print(f"  Source Radius: {src_radius:.4f} cm")
    if src_length > 0:
        print(f"  Source Length: {src_length:.4f} cm")
    print(f"  Geometrical Efficiency: {efficiency:.6f}")
    print("-"*60)


def display_table_header():
    """Display header for results table."""
    print("\n" + "="*100)
    print(f"{'Detector Type':<15} {'Radius':<10} {'Length':<10} {'Src Height':<12} "
          f"{'Src Radius':<12} {'Src Length':<12} {'Efficiency':<15}")
    print("="*100)


def display_table_row(result):
    """Display one row of results table."""
    print(f"{result.get('detector_type', ''):<15} "
          f"{result.get('detector_radius', ''):<10} "
          f"{result.get('detector_length', ''):<10} "
          f"{result.get('source_height', ''):<12} "
          f"{result.get('source_radius', ''):<12} "
          f"{result.get('source_length', ''):<12} "
          f"{result.get('efficiency', ''):<15}")


def display_batch_results(results):
    """
    Display batch processing results in table format.
    
    Parameters
    ----------
    results : list of dict
        List of results from batch processing
    """
    if not results:
        print("No results to display.")
        return
    
    ensure_results_dir()
    
    display_table_header()
    for result in results[:max_display]:
        display_table_row(result)
    print("="*100 + "\n")
    
    if len(results) > max_display:
        print(f"Showing {max_display} of {len(results)} results.\n")


def batch(max_results=None, save_results=True):
    """
    Process and display batch calculations.
    
    Parameters
    ----------
    max_results : int, optional
        Maximum number of results to process
    save_results : bool, optional
        Whether to save results to file (default: True)
    """
    print("\n" + "="*100)
    print("  Batch Processing - GeoEfficiency")
    print("="*100)
    
    batch_info()
    
    # Prepare results file path
    results_file = None
    if save_results:
        ensure_results_dir()
        results_file = os.path.join(results_folder, "batch_results.csv")
    
    # Process batch
    results = process_batch(results_path=results_file, max_results=max_results)
    
    # Display results
    display_batch_results(results)


def summary():
    """Display package summary and usage information."""
    print("\n" + "="*60)
    print("  GeoEfficiency - Package Summary")
    print("="*60)
    print("""
A Python package for calculating geometrical efficiency of radiation 
detectors. It accurately determines how efficiently a detector can detect
radiation from a given source using numerical integration of analytical
formulas.

QUICK START:
  calc()   - Interactive single calculation
  calcN()  - Interactive multiple calculations  
  batch()  - Batch processing from CSV files

SUPPORTED DETECTORS:
  - Cylindrical (CylDetector)
  - Bore-hole/Coaxial (BoreDetector)
  - Well-type (WellDetector)

SUPPORTED SOURCES:
  - Point sources
  - Disc sources
  - Cylindrical sources

EXAMPLE:
  from geoefficiency import CylDetector, Point, geoEff
  detector = CylDetector(5.0, 30.0)
  pnt = Point(10.0, 0.0)
  eff = geoEff(detector, pnt)
  print(f"Efficiency: {eff:.6f}")

For more information, see README.md
""")
    print("="*60 + "\n")
