"""
Custom exception classes for GeoEfficiency package.

This module defines custom exceptions for various error conditions specific
to geometrical efficiency calculations.
"""


class GeoException(Exception):
    """
    Base exception class for all GeoEfficiency-specific exceptions.
    All custom exceptions in this package inherit from this class.
    """
    
    def __init__(self, message=""):
        self.msg = message
        super().__init__(message)
    
    def __str__(self):
        return f"{self.__class__.__name__}: {self.msg}"


class InValidDetectorDim(GeoException):
    """
    Exception raised when detector dimensions are invalid.
    
    This is thrown when a detector is created with invalid or impossible
    physical dimensions.
    """
    pass


class NotImplementedError(GeoException):
    """
    Exception raised for geometry configurations not yet implemented.
    
    This indicates a source-to-detector geometry which may be valid but
    is not currently implemented.
    """
    pass


class InValidGeometry(GeoException):
    """
    Exception raised for invalid source-to-detector geometry.
    
    This is thrown when the geometric relationship between source and detector
    is physically impossible or invalid.
    """
    pass


def validate_detector(condition, message="Detector dimension is not valid"):
    """
    Validate detector dimensions.
    
    Raises InValidDetectorDim if condition is False.
    
    Parameters
    ----------
    condition : bool
        The condition to validate
    message : str, optional
        Error message if validation fails
    
    Raises
    ------
    InValidDetectorDim
        If condition is False
    """
    if not condition:
        raise InValidDetectorDim(message)


def not_implemented_error(message="This configuration is not implemented yet"):
    """
    Raise NotImplementedError with the given message.
    
    Parameters
    ----------
    message : str, optional
        Error message
    
    Raises
    ------
    NotImplementedError
        Always raises this exception
    """
    raise NotImplementedError(message)


def invalid_geometry(message="Invalid source-detector geometry"):
    """
    Raise InValidGeometry with the given message.
    
    Parameters
    ----------
    message : str, optional
        Error message
    
    Raises
    ------
    InValidGeometry
        Always raises this exception
    """
    raise InValidGeometry(message)
