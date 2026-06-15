#!/usr/bin/env python
"""
Example usage of GeoEfficiency package.

This script demonstrates basic usage of the package including:
- Creating detectors and points
- Calculating efficiency
- Interactive calculations
- Batch processing
"""

from geoefficiency import (
    CylDetector,
    BoreDetector,
    WellDetector,
    Point,
    geoEff,
    calc,
    calcN,
    batch,
    show_splash,
)


def example_basic_calculation():
    """Example 1: Basic efficiency calculation."""
    print("\n" + "="*60)
    print("Example 1: Basic Point Source Calculation")
    print("="*60)
    
    # Create a cylindrical detector
    detector = CylDetector(
        cry_radius=5.0,      # 5 cm radius
        cry_length=30.0      # 30 cm length
    )
    
    # Create a point source on the detector axis
    pnt = Point(
        height=10.0,         # 10 cm from detector face
        rho=0.0              # on-axis (rho=0)
    )
    
    # Calculate efficiency
    efficiency = geoEff(detector, pnt)
    
    print(f"\nDetector: {detector}")
    print(f"Source Point: {pnt}")
    print(f"Geometrical Efficiency: {efficiency:.6f}")


def example_disk_source():
    """Example 2: Disk source calculation."""
    print("\n" + "="*60)
    print("Example 2: Disk Source Calculation")
    print("="*60)
    
    detector = CylDetector(5.0, 30.0)
    pnt = Point(10.0, 0.0)
    src_radius = 2.0
    
    efficiency = geoEff(detector, pnt, src_radius=src_radius)
    
    print(f"\nDetector: {detector}")
    print(f"Source: Disk at {pnt}")
    print(f"Disk Radius: {src_radius} cm")
    print(f"Geometrical Efficiency: {efficiency:.6f}")


def example_cylindrical_source():
    """Example 3: Cylindrical source calculation."""
    print("\n" + "="*60)
    print("Example 3: Cylindrical Source Calculation")
    print("="*60)
    
    detector = CylDetector(5.0, 30.0)
    pnt = Point(10.0, 0.0)
    src_radius = 1.5
    src_length = 5.0
    
    efficiency = geoEff(detector, pnt, src_radius=src_radius, src_length=src_length)
    
    print(f"\nDetector: {detector}")
    print(f"Source: Cylinder at {pnt}")
    print(f"Cylinder Radius: {src_radius} cm")
    print(f"Cylinder Length: {src_length} cm")
    print(f"Geometrical Efficiency: {efficiency:.6f}")


def example_bore_detector():
    """Example 4: Bore-hole detector calculation."""
    print("\n" + "="*60)
    print("Example 4: Bore-hole (Coaxial) Detector")
    print("="*60)
    
    detector = BoreDetector(
        cry_radius=5.0,      # Outer radius
        cry_length=30.0,     # Length
        hole_radius=1.0      # Hole radius
    )
    
    pnt = Point(0.0, 0.0)   # At detector center
    
    efficiency = geoEff(detector, pnt)
    
    print(f"\nDetector: {detector}")
    print(f"Source Point: {pnt}")
    print(f"Geometrical Efficiency: {efficiency:.6f}")


def example_well_detector():
    """Example 5: Well-type detector calculation."""
    print("\n" + "="*60)
    print("Example 5: Well-type Detector")
    print("="*60)
    
    detector = WellDetector(
        cry_radius=5.0,      # Outer radius
        cry_length=30.0,     # Length
        hole_radius=1.0,     # Well radius
        hole_depth=10.0      # Well depth
    )
    
    pnt = Point(15.0, 0.0)  # Above well
    
    efficiency = geoEff(detector, pnt)
    
    print(f"\nDetector: {detector}")
    print(f"Source Point: {pnt}")
    print(f"Geometrical Efficiency: {efficiency:.6f}")


def example_multiple_sources():
    """Example 6: Calculate efficiency for multiple source distances."""
    print("\n" + "="*60)
    print("Example 6: Efficiency vs. Source Distance")
    print("="*60)
    
    detector = CylDetector(5.0, 30.0)
    
    distances = [2.0, 5.0, 10.0, 20.0, 50.0]
    
    print(f"\nDetector: {detector}\n")
    print(f"{'Distance (cm)':<15} {'Efficiency':<15}")
    print("-"*30)
    
    for distance in distances:
        pnt = Point(distance, 0.0)
        efficiency = geoEff(detector, pnt)
        print(f"{distance:<15.1f} {efficiency:<15.6f}")


def example_offset_sources():
    """Example 7: Efficiency for off-axis sources."""
    print("\n" + "="*60)
    print("Example 7: Efficiency vs. Off-axis Distance")
    print("="*60)
    
    detector = CylDetector(5.0, 30.0)
    distance = 10.0
    
    offsets = [0.0, 1.0, 2.0, 3.0, 4.0]
    
    print(f"\nDetector: {detector}")
    print(f"Source Distance: {distance} cm\n")
    print(f"{'Off-axis (cm)':<15} {'Efficiency':<15}")
    print("-"*30)
    
    for offset in offsets:
        pnt = Point(distance, offset)
        try:
            efficiency = geoEff(detector, pnt)
            print(f"{offset:<15.1f} {efficiency:<15.6f}")
        except Exception as e:
            print(f"{offset:<15.1f} {'Error':<15}")


def main():
    """Run all examples."""
    show_splash()
    
    print("\nRunning GeoEfficiency Examples")
    print("="*60)
    
    # Run examples
    example_basic_calculation()
    example_disk_source()
    example_cylindrical_source()
    example_bore_detector()
    example_well_detector()
    example_multiple_sources()
    example_offset_sources()
    
    print("\n" + "="*60)
    print("Examples Complete")
    print("="*60)
    print("\nFor interactive calculations, use:")
    print("  calc()   - Single calculation")
    print("  calcN()  - Multiple calculations")
    print("  batch()  - Batch processing from CSV files")
    print()


if __name__ == "__main__":
    main()
