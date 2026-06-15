"""
Interactive console input handling for GeoEfficiency.

This module provides functions for prompting users to input detector
and source parameters via the console.
"""

import sys
from .physics_model import Point, CylDetector, BoreDetector, WellDetector
from .calculations import geoEff
from .error import InValidDetectorDim


def get_float(prompt, default=None):
    """
    Prompt user for a float input.
    
    Parameters
    ----------
    prompt : str
        The prompt message
    default : float, optional
        Default value if user enters nothing
    
    Returns
    -------
    float
        The entered or default value
    """
    while True:
        try:
            user_input = input(prompt).strip()
            if not user_input and default is not None:
                return default
            return float(user_input)
        except ValueError:
            print("Invalid input. Please enter a valid number.")


def get_int(prompt, default=None):
    """
    Prompt user for an integer input.
    
    Parameters
    ----------
    prompt : str
        The prompt message
    default : int, optional
        Default value if user enters nothing
    
    Returns
    -------
    int
        The entered or default value
    """
    while True:
        try:
            user_input = input(prompt).strip()
            if not user_input and default is not None:
                return default
            return int(user_input)
        except ValueError:
            print("Invalid input. Please enter a valid integer.")


def get_yes_no(prompt, default=True):
    """
    Prompt user for a yes/no input.
    
    Parameters
    ----------
    prompt : str
        The prompt message
    default : bool, optional
        Default value if user enters nothing
    
    Returns
    -------
    bool
        True for yes, False for no
    """
    while True:
        user_input = input(prompt).strip().lower()
        if not user_input:
            return default
        if user_input in ('y', 'yes'):
            return True
        elif user_input in ('n', 'no'):
            return False
        else:
            print("Please enter 'y' or 'n'.")


def input_point(label="Source Point"):
    """
    Prompt user to input a Point.
    
    Parameters
    ----------
    label : str, optional
        Label for the point being input
    
    Returns
    -------
    Point
        The input point
    """
    print(f"\n--- {label} ---")
    height = get_float("  Height (cm): ")
    rho = get_float("  Off-axis (cm): ", default=0.0)
    return Point(height, rho)


def input_detector():
    """
    Prompt user to input a Detector.
    
    Returns
    -------
    Detector
        The input detector (CylDetector, BoreDetector, or WellDetector)
    """
    print("\n--- Detector Selection ---")
    print("1. Cylindrical Detector")
    print("2. Bore-hole (Coaxial) Detector")
    print("3. Well-type Detector")
    
    choice = get_int("Select detector type (1-3): ")
    
    if choice == 1:
        print("\n--- Cylindrical Detector Parameters ---")
        radius = get_float("  Crystal radius (cm): ")
        length = get_float("  Crystal length (cm): ")
        try:
            return CylDetector(radius, length)
        except InValidDetectorDim as e:
            print(f"Error: {e}")
            return input_detector()
    
    elif choice == 2:
        print("\n--- Bore-hole Detector Parameters ---")
        radius = get_float("  Outer radius (cm): ")
        length = get_float("  Crystal length (cm): ")
        hole_radius = get_float("  Hole radius (cm): ")
        try:
            return BoreDetector(radius, length, hole_radius)
        except InValidDetectorDim as e:
            print(f"Error: {e}")
            return input_detector()
    
    elif choice == 3:
        print("\n--- Well-type Detector Parameters ---")
        radius = get_float("  Crystal radius (cm): ")
        length = get_float("  Crystal length (cm): ")
        hole_radius = get_float("  Well radius (cm): ")
        hole_depth = get_float("  Well depth (cm): ")
        try:
            return WellDetector(radius, length, hole_radius, hole_depth)
        except InValidDetectorDim as e:
            print(f"Error: {e}")
            return input_detector()
    
    else:
        print("Invalid choice. Please select 1, 2, or 3.")
        return input_detector()


def input_source():
    """
    Prompt user to input source parameters.
    
    Returns
    -------
    tuple
        (anchor_point, src_radius, src_length)
    """
    print("\n--- Source Parameters ---")
    anchor_pnt = input_point("Source Anchor Point")
    
    src_radius = get_float("  Source radius (cm): ", default=0.0)
    
    if src_radius > 0:
        src_length = get_float("  Source length (cm): ", default=0.0)
    else:
        src_length = 0.0
    
    return (anchor_pnt, src_radius, src_length)


# ============================================================================
# Interactive Calculation Functions
# ============================================================================

def calc():
    """
    Calculate geometrical efficiency for one configuration.
    
    Prompts user for detector and source parameters, calculates efficiency,
    and displays full information on the console.
    """
    print("\n" + "="*60)
    print("  GeoEfficiency - Calculate Geometrical Efficiency")
    print("="*60)
    
    try:
        detector = input_detector()
        anchor_pnt, src_radius, src_length = input_source()
        
        efficiency = geoEff(detector, anchor_pnt, src_radius, src_length)
        
        print("\n" + "-"*60)
        print("RESULTS:")
        print("-"*60)
        print(f"Detector: {detector}")
        print(f"Source Point: {anchor_pnt}")
        print(f"Source Radius: {src_radius:.4f} cm")
        print(f"Source Length: {src_length:.4f} cm")
        print(f"\nGeometrical Efficiency: {efficiency:.6f}")
        print("-"*60 + "\n")
        
    except Exception as e:
        print(f"\nError: {e}\n")


def calcN():
    """
    Calculate geometrical efficiency for multiple configurations.
    
    Repeatedly prompts for configurations and displays results until
    the user chooses to quit.
    """
    print("\n" + "="*60)
    print("  GeoEfficiency - Multiple Calculations")
    print("="*60)
    
    while True:
        try:
            calc()
            if not get_yes_no("Calculate another? (y/n): ", default=True):
                print("Exiting...\n")
                break
        except KeyboardInterrupt:
            print("\n\nInterrupted by user.\n")
            break
        except Exception as e:
            print(f"Error: {e}")
            if not get_yes_no("Try again? (y/n): ", default=True):
                print("Exiting...\n")
                break


# ============================================================================
# Splash Screen
# ============================================================================

def show_splash():
    """Display GeoEfficiency welcome message."""
    print("\n" + "="*60)
    print("  GeoEfficiency")
    print("  Accurate Geometrical Efficiency Calculator")
    print("="*60)
    print("\n  Author: Mohamed E. Krar (Python Port)")
    print("  Repository: https://github.com/DrKrar/GeoEfficiency.jl/")
    print("\n  Start a calculation by using:")
    print("    calc()   - Single calculation")
    print("    calcN()  - Multiple calculations")
    print("    batch()  - Batch processing")
    print("\n" + "="*60 + "\n")
