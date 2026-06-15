#!/usr/bin/env python
"""
Setup configuration for GeoEfficiency Python package.

Provides installation and distribution configuration using setuptools.
"""

from setuptools import setup, find_packages
import os

# Read the README file
with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="geoefficiency",
    version="0.9.4-dev",
    author="Mohamed E. Krar",
    author_email="DrKrar@gmail.com",
    description="Accurate Geometrical Efficiency Calculator for Radiation Detectors",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/DrKrar/GeoEfficiency.jl",
    project_urls={
        "Bug Tracker": "https://github.com/DrKrar/GeoEfficiency.jl/issues",
        "Documentation": "https://GeoEfficiency.GitHub.io/dev/index.html",
        "Repository": "https://github.com/DrKrar/GeoEfficiency.jl/",
    },
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Science/Research",
        "Topic :: Scientific/Engineering :: Physics",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Natural Language :: English",
    ],
    python_requires=">=3.7",
    install_requires=[
        "numpy>=1.19",
        "scipy>=1.5",
    ],
    extras_require={
        "dev": [
            "pytest>=6.0",
            "pytest-cov>=2.10",
            "black>=20.8b1",
            "flake8>=3.8",
            "mypy>=0.800",
        ],
    },
    entry_points={
        "console_scripts": [
            "geoefficiency=geoefficiency.cli:main",
        ],
    },
)
