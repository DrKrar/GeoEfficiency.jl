"""
Batch processing for GeoEfficiency.

This module provides functions for reading detector and source configurations
from files and processing them in batch mode.
"""

import os
import csv
from pathlib import Path
from .config import data_dir, max_display
from .physics_model import Point, CylDetector, BoreDetector, WellDetector
from .calculations import geoEff


def get_detectors(data_path=None):
    """
    Read detectors from a CSV file.
    
    Parameters
    ----------
    data_path : str, optional
        Path to detectors file. If None, uses default data directory.
    
    Returns
    -------
    list of dict
        List of detector configurations
    """
    if data_path is None:
        data_path = os.path.join(data_dir, "detectors.csv")
    
    detectors = []
    
    if not os.path.exists(data_path):
        print(f"Detectors file not found: {data_path}")
        return detectors
    
    try:
        with open(data_path, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                detectors.append(row)
    except Exception as e:
        print(f"Error reading detectors file: {e}")
    
    return detectors


def get_sources(data_path=None):
    """
    Read sources from a CSV file.
    
    Parameters
    ----------
    data_path : str, optional
        Path to sources file. If None, uses default data directory.
    
    Returns
    -------
    list of dict
        List of source configurations
    """
    if data_path is None:
        data_path = os.path.join(data_dir, "sources.csv")
    
    sources = []
    
    if not os.path.exists(data_path):
        print(f"Sources file not found: {data_path}")
        return sources
    
    try:
        with open(data_path, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                sources.append(row)
    except Exception as e:
        print(f"Error reading sources file: {e}")
    
    return sources


def setSrcToPoint(value=True):
    """
    Set source type to point source globally.
    
    Parameters
    ----------
    value : bool, optional
        If True, set to point source
    
    Returns
    -------
    bool
        New source type setting
    """
    from .physics_model import setSrcToPoint as set_src
    return set_src(value)


def typeofSrc():
    """
    Get current source type.
    
    Returns
    -------
    int
        Current source type code
    """
    from .physics_model import typeofSrc as type_src
    return type_src()


def process_batch(results_path=None, max_results=None):
    """
    Process batch calculations from data files.
    
    Parameters
    ----------
    results_path : str, optional
        Path to save results CSV file
    max_results : int, optional
        Maximum number of results to process. If None, processes all.
    
    Returns
    -------
    list of dict
        List of calculation results
    """
    if max_results is None:
        max_results = max_display
    
    detectors = get_detectors()
    sources = get_sources()
    
    if not detectors or not sources:
        print("No detectors or sources found. Cannot process batch.")
        return []
    
    results = []
    count = 0
    
    for detector_config in detectors:
        for source_config in sources:
            if count >= max_results:
                break
            
            try:
                # Parse detector
                det_type = detector_config.get('type', 'cyl').lower()
                
                if det_type == 'cyl':
                    radius = float(detector_config.get('radius', 5.0))
                    length = float(detector_config.get('length', 30.0))
                    detector = CylDetector(radius, length)
                
                elif det_type == 'bore':
                    radius = float(detector_config.get('radius', 5.0))
                    length = float(detector_config.get('length', 30.0))
                    hole_radius = float(detector_config.get('hole_radius', 1.0))
                    detector = BoreDetector(radius, length, hole_radius)
                
                elif det_type == 'well':
                    radius = float(detector_config.get('radius', 5.0))
                    length = float(detector_config.get('length', 30.0))
                    hole_radius = float(detector_config.get('hole_radius', 1.0))
                    hole_depth = float(detector_config.get('hole_depth', 10.0))
                    detector = WellDetector(radius, length, hole_radius, hole_depth)
                else:
                    continue
                
                # Parse source
                height = float(source_config.get('height', 0.0))
                rho = float(source_config.get('rho', 0.0))
                src_radius = float(source_config.get('radius', 0.0))
                src_length = float(source_config.get('length', 0.0))
                
                pnt = Point(height, rho)
                
                # Calculate efficiency
                efficiency = geoEff(detector, pnt, src_radius, src_length)
                
                result = {
                    'detector_type': det_type,
                    'detector_radius': detector_config.get('radius', ''),
                    'detector_length': detector_config.get('length', ''),
                    'source_height': height,
                    'source_rho': rho,
                    'source_radius': src_radius,
                    'source_length': src_length,
                    'efficiency': f"{efficiency:.6f}"
                }
                
                results.append(result)
                count += 1
                
            except Exception as e:
                print(f"Error processing configuration: {e}")
    
    # Save results if path provided
    if results_path and results:
        try:
            with open(results_path, 'w', newline='') as f:
                writer = csv.DictWriter(f, fieldnames=results[0].keys())
                writer.writeheader()
                writer.writerows(results)
            print(f"Results saved to {results_path}")
        except Exception as e:
            print(f"Error saving results: {e}")
    
    return results


def batch_info():
    """Display information about batch processing setup."""
    print("\n" + "="*60)
    print("  Batch Processing Information")
    print("="*60)
    print(f"\nData directory: {data_dir}")
    print(f"Expected files:")
    print(f"  - {os.path.join(data_dir, 'detectors.csv')}")
    print(f"  - {os.path.join(data_dir, 'sources.csv')}")
    print(f"\nMax display: {max_display} results")
    print("\n" + "="*60 + "\n")
