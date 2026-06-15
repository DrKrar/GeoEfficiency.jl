"""
Unit tests for GeoEfficiency package.

Tests cover the main functionality of physics model, calculations,
error handling, and configuration.
"""

import math
import unittest
from geoefficiency.physics_model import Point, CylDetector, BoreDetector, WellDetector
from geoefficiency.error import InValidDetectorDim, InValidGeometry, NotImplementedError
from geoefficiency.calculations import geoEff


class TestPoint(unittest.TestCase):
    """Test cases for Point class."""
    
    def test_point_creation_axial(self):
        """Test creating an axial point."""
        pnt = Point(10.0)
        self.assertEqual(pnt.height, 10.0)
        self.assertEqual(pnt.rho, 0.0)
    
    def test_point_creation_offset(self):
        """Test creating an offset point."""
        pnt = Point(10.0, 5.0)
        self.assertEqual(pnt.height, 10.0)
        self.assertEqual(pnt.rho, 5.0)
    
    def test_point_float_conversion(self):
        """Test that Point converts inputs to float."""
        pnt = Point(10, 5)
        self.assertIsInstance(pnt.height, float)
        self.assertIsInstance(pnt.rho, float)
    
    def test_point_equality(self):
        """Test Point equality comparison."""
        pnt1 = Point(10.0, 5.0)
        pnt2 = Point(10.0, 5.0)
        self.assertEqual(pnt1, pnt2)
    
    def test_point_inequality(self):
        """Test Point inequality comparison."""
        pnt1 = Point(10.0, 5.0)
        pnt2 = Point(10.0, 6.0)
        self.assertNotEqual(pnt1, pnt2)
    
    def test_point_less_than(self):
        """Test Point less-than comparison."""
        pnt1 = Point(10.0, 5.0)
        pnt2 = Point(11.0, 5.0)
        self.assertTrue(pnt1 < pnt2)
    
    def test_point_repr(self):
        """Test Point string representations."""
        pnt = Point(10.0, 5.0)
        self.assertIn("10.0", repr(pnt))
        self.assertIn("5.0", repr(pnt))


class TestCylDetector(unittest.TestCase):
    """Test cases for CylDetector class."""
    
    def test_valid_detector(self):
        """Test creating a valid cylindrical detector."""
        det = CylDetector(5.0, 30.0)
        self.assertEqual(det.cry_radius, 5.0)
        self.assertEqual(det.cry_length, 30.0)
    
    def test_detector_float_conversion(self):
        """Test that detector converts inputs to float."""
        det = CylDetector(5, 30)
        self.assertIsInstance(det.cry_radius, float)
        self.assertIsInstance(det.cry_length, float)
    
    def test_invalid_radius(self):
        """Test that negative radius raises error."""
        with self.assertRaises(InValidDetectorDim):
            CylDetector(-5.0, 30.0)
    
    def test_zero_radius(self):
        """Test that zero radius raises error."""
        with self.assertRaises(InValidDetectorDim):
            CylDetector(0.0, 30.0)
    
    def test_invalid_length(self):
        """Test that negative length raises error."""
        with self.assertRaises(InValidDetectorDim):
            CylDetector(5.0, -30.0)
    
    def test_detector_equality(self):
        """Test detector equality."""
        det1 = CylDetector(5.0, 30.0)
        det2 = CylDetector(5.0, 30.0)
        self.assertEqual(det1, det2)
    
    def test_detector_inequality(self):
        """Test detector inequality."""
        det1 = CylDetector(5.0, 30.0)
        det2 = CylDetector(6.0, 30.0)
        self.assertNotEqual(det1, det2)


class TestBoreDetector(unittest.TestCase):
    """Test cases for BoreDetector class."""
    
    def test_valid_bore_detector(self):
        """Test creating a valid bore detector."""
        det = BoreDetector(5.0, 30.0, 1.0)
        self.assertEqual(det.cry_radius, 5.0)
        self.assertEqual(det.cry_length, 30.0)
        self.assertEqual(det.hole_radius, 1.0)
    
    def test_hole_larger_than_radius(self):
        """Test that hole radius > crystal radius raises error."""
        with self.assertRaises(InValidDetectorDim):
            BoreDetector(5.0, 30.0, 6.0)
    
    def test_hole_equal_to_radius(self):
        """Test that hole radius = crystal radius raises error."""
        with self.assertRaises(InValidDetectorDim):
            BoreDetector(5.0, 30.0, 5.0)
    
    def test_zero_hole_radius(self):
        """Test bore detector with zero hole (should be valid)."""
        det = BoreDetector(5.0, 30.0, 0.0)
        self.assertEqual(det.hole_radius, 0.0)
    
    def test_bore_detector_equality(self):
        """Test bore detector equality."""
        det1 = BoreDetector(5.0, 30.0, 1.0)
        det2 = BoreDetector(5.0, 30.0, 1.0)
        self.assertEqual(det1, det2)


class TestWellDetector(unittest.TestCase):
    """Test cases for WellDetector class."""
    
    def test_valid_well_detector(self):
        """Test creating a valid well detector."""
        det = WellDetector(5.0, 30.0, 1.0, 10.0)
        self.assertEqual(det.cry_radius, 5.0)
        self.assertEqual(det.cry_length, 30.0)
        self.assertEqual(det.hole_radius, 1.0)
        self.assertEqual(det.hole_depth, 10.0)
    
    def test_hole_deeper_than_length(self):
        """Test that hole depth > length raises error."""
        with self.assertRaises(InValidDetectorDim):
            WellDetector(5.0, 30.0, 1.0, 31.0)
    
    def test_zero_hole_depth(self):
        """Test that zero hole depth raises error."""
        with self.assertRaises(InValidDetectorDim):
            WellDetector(5.0, 30.0, 1.0, 0.0)
    
    def test_well_detector_equality(self):
        """Test well detector equality."""
        det1 = WellDetector(5.0, 30.0, 1.0, 10.0)
        det2 = WellDetector(5.0, 30.0, 1.0, 10.0)
        self.assertEqual(det1, det2)


class TestCalculations(unittest.TestCase):
    """Test cases for efficiency calculations."""
    
    def setUp(self):
        """Set up test fixtures."""
        self.detector = CylDetector(5.0, 30.0)
    
    def test_axial_point_source(self):
        """Test efficiency for axial point source."""
        pnt = Point(10.0, 0.0)
        eff = geoEff(self.detector, pnt)
        
        # Result should be between 0 and 1
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)
    
    def test_efficiency_range(self):
        """Test that efficiency is always in valid range [0, 1]."""
        pnt = Point(10.0, 2.0)
        eff = geoEff(self.detector, pnt)
        
        self.assertGreaterEqual(eff, 0.0)
        self.assertLessEqual(eff, 1.0)
    
    def test_disk_source(self):
        """Test efficiency for disk source."""
        pnt = Point(10.0, 0.0)
        eff = geoEff(self.detector, pnt, src_radius=1.0)
        
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)
    
    def test_cylindrical_source(self):
        """Test efficiency for cylindrical source."""
        pnt = Point(10.0, 0.0)
        eff = geoEff(self.detector, pnt, src_radius=1.0, src_length=5.0)
        
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)
    
    def test_unsupported_detector_type(self):
        """Test that unsupported detector type raises error."""
        pnt = Point(10.0, 0.0)
        
        with self.assertRaises(TypeError):
            geoEff("not a detector", pnt)
    
    def test_bore_detector(self):
        """Test efficiency calculation with bore detector."""
        detector = BoreDetector(5.0, 30.0, 1.0)
        pnt = Point(0.0, 0.0)  # At center
        eff = geoEff(detector, pnt)
        
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)
    
    def test_well_detector(self):
        """Test efficiency calculation with well detector."""
        detector = WellDetector(5.0, 30.0, 1.0, 10.0)
        pnt = Point(10.0, 0.0)
        eff = geoEff(detector, pnt)
        
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)


class TestIntegrationScenarios(unittest.TestCase):
    """Integration tests with realistic scenarios."""
    
    def test_common_geometry_1(self):
        """Test with common detector geometry 1."""
        detector = CylDetector(5.0, 30.0)
        pnt = Point(5.0, 0.0)
        
        eff = geoEff(detector, pnt)
        
        # For this geometry, efficiency should be around 0.1-0.3
        self.assertGreater(eff, 0.05)
        self.assertLess(eff, 0.5)
    
    def test_common_geometry_2(self):
        """Test with common detector geometry 2."""
        detector = CylDetector(10.0, 50.0)
        pnt = Point(10.0, 0.0)
        
        eff = geoEff(detector, pnt)
        
        self.assertGreater(eff, 0.0)
        self.assertLess(eff, 1.0)
    
    def test_reproducibility(self):
        """Test that same input produces same output."""
        detector = CylDetector(5.0, 30.0)
        pnt = Point(10.0, 0.0)
        
        eff1 = geoEff(detector, pnt)
        eff2 = geoEff(detector, pnt)
        
        self.assertAlmostEqual(eff1, eff2, places=10)
    
    def test_increasing_distance_decreases_efficiency(self):
        """Test that efficiency decreases with distance."""
        detector = CylDetector(5.0, 30.0)
        
        pnt1 = Point(5.0, 0.0)
        pnt2 = Point(20.0, 0.0)
        
        eff1 = geoEff(detector, pnt1)
        eff2 = geoEff(detector, pnt2)
        
        # Efficiency should decrease with distance
        self.assertGreater(eff1, eff2)


if __name__ == '__main__':
    unittest.main()
