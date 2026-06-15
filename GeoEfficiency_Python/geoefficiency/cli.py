"""
Command-line interface for GeoEfficiency package.

Provides command-line entry point for running calculations.
"""

import sys
import argparse
from . import calc, calcN, batch, show_splash, summary


def create_parser():
    """Create command-line argument parser."""
    parser = argparse.ArgumentParser(
        description="GeoEfficiency - Accurate Geometrical Efficiency Calculator",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  geoefficiency calc      - Interactive single calculation
  geoefficiency calcN     - Interactive multiple calculations
  geoefficiency batch     - Batch processing from CSV files
  geoefficiency summary   - Show package summary
  geoefficiency --version - Show version information
        """
    )
    
    parser.add_argument(
        "--version",
        action="version",
        version="GeoEfficiency 0.9.4-dev"
    )
    
    parser.add_argument(
        "--splash",
        action="store_true",
        help="Show splash screen"
    )
    
    subparsers = parser.add_subparsers(dest="command", help="Command to run")
    
    # calc command
    subparsers.add_parser("calc", help="Interactive single calculation")
    
    # calcN command
    subparsers.add_parser("calcN", help="Interactive multiple calculations")
    
    # batch command
    batch_parser = subparsers.add_parser("batch", help="Batch processing")
    batch_parser.add_argument(
        "--max",
        type=int,
        default=None,
        help="Maximum number of results to process"
    )
    batch_parser.add_argument(
        "--no-save",
        action="store_true",
        help="Don't save results to file"
    )
    
    # summary command
    subparsers.add_parser("summary", help="Show package summary")
    
    return parser


def main():
    """Main CLI entry point."""
    parser = create_parser()
    args = parser.parse_args()
    
    # Show splash if requested or if no command given
    if args.splash or not args.command:
        show_splash()
    
    # Execute command
    if args.command == "calc":
        calc()
    elif args.command == "calcN":
        calcN()
    elif args.command == "batch":
        save = not args.no_save
        batch(max_results=args.max, save_results=save)
    elif args.command == "summary":
        summary()
    elif not args.command:
        # Show interactive menu if no command
        print("\nAvailable commands:")
        print("  calc    - Single calculation")
        print("  calcN   - Multiple calculations")
        print("  batch   - Batch processing")
        print("  summary - Show package information")
        
        choice = input("\nSelect option (or press Enter for interactive calc): ").strip()
        
        if choice == "calc" or choice == "":
            calc()
        elif choice == "calcN":
            calcN()
        elif choice == "batch":
            batch()
        elif choice == "summary":
            summary()
        else:
            print("Unknown option")


if __name__ == "__main__":
    main()
