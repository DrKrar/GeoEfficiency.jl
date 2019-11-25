var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#GeoEfficiency:-Accurate-Geometrical-Efficiency-Calculator-1",
    "page": "Home",
    "title": "GeoEfficiency: Accurate Geometrical Efficiency Calculator",
    "category": "section",
    "text": "An officially registered Julia program that provides a set of tools to calculate the geometrical efficiency in a fast and accurate way.  The Package models a radiation detector irradiated by a radioactive source.  The Package relay directly on numerical evaluation of closed form analytical formula describing the geometrical efficiency.Author Mohamed E. Krar (DrKrar@gmail.com)\nRepository GitHub.com\nDocumentation GitHub.io\nCurrent version v\"0.9.4-dev\"\nFirst Created Fri Aug 14 20:12:01 2015note: Portable Document Format\nThis documentation is also available in PDF format."
},

{
    "location": "index.html#Current/Planed-Features-1",
    "page": "Home",
    "title": "Current/Planed Features",
    "category": "section",
    "text": "The following list show the state of current feature and planed feature. the checked items represent already present feature.[x] support of widely used detector geometries.\n[x] cylinder detectors.\n[x] bore-hole detectors.\n[x] well-type detectors.\n[ ] support of specialized detector geometries.[x] support of isotropic radioactive sources.\n[x] point sources.\n[x] disc sources.\n[x] cylinder sources.\n[ ] support of anisotropic radioactive sources.\n[ ] point sources.\n[ ] consider more details of the measurement setup.\n[ ] the detector effect.\n[ ] the end cap effect.\n[ ] the medium and absorber effect.\n[ ] combine the effect of the source geometry and composition. "
},

{
    "location": "index.html#Requirements-1",
    "page": "Home",
    "title": "Requirements",
    "category": "section",
    "text": "Julia 1.1 or above.\nQuadGK 2.0.2 or above, will be installed automatically during the package Installation."
},

{
    "location": "index.html#Download/Installation-1",
    "page": "Home",
    "title": "Download/Installation",
    "category": "section",
    "text": "Getting the GeoEfficiency package to work involves two steps: "
},

{
    "location": "index.html#.-Installing-Julia-Language-1",
    "page": "Home",
    "title": "1. Installing Julia Language",
    "category": "section",
    "text": "Just head over to the Julia language download page and choose the suitable binary for your platform to download and install.  At the end of this step you should be able to run julia from your system. note: JuliaBox.com\nHead to JuliaBox.com to run julia in your browser without any local installation. no registration is required just a Google account."
},

{
    "location": "index.html#.-Installing-Package-1",
    "page": "Home",
    "title": "2. Installing Package",
    "category": "section",
    "text": "GeoEfficiency is registered officially and so the latest stable release can be installed through the Julia package management system just by typing the following into the julia REPL prompt.julia> import Pkg\njulia> Pkg.add(\"GeoEfficiency\") "
},

{
    "location": "index.html#Quick-Usage-1",
    "page": "Home",
    "title": "Quick Usage",
    "category": "section",
    "text": "After installing the package, you can load it to your current workspace by typing the following:julia> using GeoEfficiencyNow the package is available to use, try typing:julia> calc()see also: geoEff(), calcN(), batch()"
},

{
    "location": "index.html#Unit-Test-1",
    "page": "Home",
    "title": "Unit Test",
    "category": "section",
    "text": "For scientific calculation accuracy in calculation and being error free is a highly demanded objective. Thus, the package is extensively tested method-wise in each supported operating system. Operating system fully supported include Windows, Linus, Apple OSX.After installing the package can be tested in your own system by typing the following into the REPL prompt.julia> using Test, Pkg\njulia> Pkg.test(\"GeoEfficiency\") "
},

{
    "location": "index.html#Package-Overview-1",
    "page": "Home",
    "title": "Package Overview",
    "category": "section",
    "text": "The following constructor can be used to construct a specific type of detector CylDetector for cylindrical detector, \nBoreDetector for bore hole, \nWellDetector for well type detector.While the function Detector can be used to construct any of the above types. You may try also getDetectors.Point constructor is used to construct an anchoring point of a source. relative to source anchoring point the source position is specified. For a point source, the anchoring point is the source itself.  The source() method take input from the \'console\' and return a tuple describing the source.The efficiency calculation can be done by one of the functions: geoEff used with or without argument(s), \ncalc ask for the required information from the \'console\', \ncalcN just a repeat of the calc function \nbatch() which try to take required information from csv files located in   the home directory inside a folder called GeoEfficiency.For more on the function and its methods prefix the name of the function by ?.note: Note\nInput from the \'console\' can be numerical expression not just a number. 5/2 ; 5//2 ; pi ; π/2 ; exp(2) ; 1E-2 ; 5.2/3 ; sin(1) ;  sin(1)^2 are all valid expressions."
},

{
    "location": "index.html#Batch-Calculation-1",
    "page": "Home",
    "title": "Batch Calculation",
    "category": "section",
    "text": "The package can be used to perform batch calculations by calling one of the  methods of the function batch. The output results of batch calculations is  found by default in GeoEfficiency\\results folder inside the user home directory.For example  c:\\users\\yourusername\\GeoEfficiency\\results\\.The function batch() can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved  Values  [CSV] files, that can be easily edit by Microsoft Excel, located by default  in the GeoEfficiency folder.Those Comma Saved Values [CSV] files are:-Detectors.csv contains the detectors description (a detector per line); The line format is: \n  Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |\n  ---------------| ---------------|-------------|----------- |\nsrcHeights.csv contains the source heights; \n  Source_Heights | \n  ---------------|\nsrcRhos.csv contains the source off-axis distances;                        \n  Source_Rhos | \n  ------------|\nsrcRadii.csv contains the source radii for disc and cylindrical sources;             \n  Source_Radii| \n  ------------|\nsrcLengths.csv contains the source length for cylindrical sources;    \n  Source_Lengths| \n  --------------|note: Note\nFor Comma Saved Values [CSV] files each line represent an entry, the first line is always treated as the header.warning: Warning\nThe program expect each line to contain one number for all CSV files except for Detectors.csv each line should contain at least one number or at most four separated numbers"
},

{
    "location": "manual/GeoEfficiency.html#",
    "page": "Summery",
    "title": "Summery",
    "category": "page",
    "text": ""
},

{
    "location": "manual/GeoEfficiency.html#GeoEfficiency.about",
    "page": "Summery",
    "title": "GeoEfficiency.about",
    "category": "function",
    "text": " **************************************************\n **            -=) GeoEfficiency (=-             **\n **  Accurate Geometrical Efficiency Calculator  **\n **   First Created on Fri Aug 14 20:12:01 2015  **\n **************************************************\n\n Author:        Mohamed E. Krar,  @e-mail: DrKrar@gmail.com \n Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3\n Repository:    https://github.com/DrKrar/GeoEfficiency.jl/\n Version:       v\"0.9.4-dev\" - (188 days old master)  \n Documentation: https://GeoEfficiency.GitHub.io/dev/index.html\n PDF_Manual:    https://GeoEfficiency.GitHub.io/dev/GeoEfficiency.jl.pdf\n\n\n\nBatch Mode Calculations \n-  read files by defaul from directory `/home/GeoEfficiency`\n-  save results by default to directory `/home/GeoEfficiency/results`\n\nfor more information see `batch`, `batchInfo`.\n\n\n\n\n\n"
},

{
    "location": "manual/GeoEfficiency.html#GeoEfficiency.GeoEfficiency",
    "page": "Summery",
    "title": "GeoEfficiency.GeoEfficiency",
    "category": "module",
    "text": "GeoEfficiency Package\n\nintroduce a fast and flexible tool to calculate in batch or individually the geometrical efficiency  for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form  a source. The source can be a point, a disc or even a cylinder.\n\nQuick Usage\n\ngeoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\ncalc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\ncalcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\nbatch()	: Calculate the geometrical efficiency using data in the /home/GeoEfficiency folder in batch mode.\n\nnote: Note\nfor more information and updates refer to the repository at GitHub.com\n\n\n\n\n\n"
},

{
    "location": "manual/GeoEfficiency.html#Summery-1",
    "page": "Summery",
    "title": "Summery",
    "category": "section",
    "text": "GeoEfficiency.aboutGeoEfficiency.GeoEfficiency"
},

{
    "location": "manual/Physics_Model.html#",
    "page": "Physics Model",
    "title": "Physics Model",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Physics_Model.html#Physics-Model-1",
    "page": "Physics Model",
    "title": "Physics Model",
    "category": "section",
    "text": "Geometrical efficiency of radioactive source measurement is a type of detection efficiency. A fully describe a radioactive source measurement at the most basic level three component should be provided. radioactive detector description\nradiation source description \nrelative position of the source to detector.this section will discus how to instruct the program to construct each of the aforementioned component."
},

{
    "location": "manual/Physics_Model.html#Detector-1",
    "page": "Physics Model",
    "title": "Detector",
    "category": "section",
    "text": "Currently, only cylindrical-like types of detectors are supported.  "
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.CylDetector",
    "page": "Physics Model",
    "title": "GeoEfficiency.CylDetector",
    "category": "type",
    "text": "CylDetector(CryRadius::Real, CryLength::Real)\n\nconstruct and return a cylindrical detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\n\nwarning: Invalid Arguments\nboth CryRadius and CryLength should be positive, while CryLength can also be set to zero.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.CylDetector-Tuple{Real}",
    "page": "Physics Model",
    "title": "GeoEfficiency.CylDetector",
    "category": "method",
    "text": "CylDetector(CryRadius::Real)\n\nconstruct and return a cylindrical (really disk) detector with crystal length equal to zero.\n\nsee also: CylDetector(CryRadius::Real, CryLength::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.CylDetector-Tuple{}",
    "page": "Physics Model",
    "title": "GeoEfficiency.CylDetector",
    "category": "method",
    "text": "CylDetector()\n\nconstruct and return a cylindrical detector according to the input from the console.\n\nsee also: CylDetector(CryRadius::Real, CryLength::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Cylindrical-Detector-1",
    "page": "Physics Model",
    "title": "Cylindrical Detector",
    "category": "section",
    "text": "To construct a cylinder detector type CylDetector(CryRadius, CryLength)GeoEfficiency.CylDetectorTo construct a planer cylinder  detector or Disc CylDetector(CryRadius)GeoEfficiency.CylDetector(CryRadius::Real)user may also just type CylDetector() to enter dimension from the console.GeoEfficiency.CylDetector()note: Note\nthe position of the source is reported relative to the detector anchoring point,  for a cylinder detector it is taking as a point in the plain surface nearest to the source  which lies on the detector axis of symmetry."
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.BoreDetector",
    "page": "Physics Model",
    "title": "GeoEfficiency.BoreDetector",
    "category": "type",
    "text": "BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)\n\nconstruct and return a bore-hole detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\nHoleRadius : the detector hole radius.\n\nwarning: Invalid Arguments\nCryRadius and CryLength, HoleRadius should be positive numbers, also  CryRadius should be greater than HoleRadius.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.BoreDetector-Tuple{}",
    "page": "Physics Model",
    "title": "GeoEfficiency.BoreDetector",
    "category": "method",
    "text": "BoreDetector()\n\nconstruct and return a bore-hole detector according to the input from the console.\n\nsee also: BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Bore-hole-Detector-1",
    "page": "Physics Model",
    "title": "Bore-hole Detector",
    "category": "section",
    "text": "To construct a bore-hole detector type BoreDetector(CryRadius, CryLength, HoleRadius). GeoEfficiency.BoreDetectoruser may also just type BoreDetector() to enter dimension from the console.GeoEfficiency.BoreDetector()note: Note\nthe position of the source is reported relative to the detector anchoring point,  for a bore-hole detector it is taking as the middle point of its axis of symmetry."
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.WellDetector",
    "page": "Physics Model",
    "title": "GeoEfficiency.WellDetector",
    "category": "type",
    "text": "WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)\n\nconstruct and return a Well-Type detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\nHoleRadius : the detector hole radius.\nHoleDepth : the detector hole length.\n\nwarning: Invalid Arguments\nall arguments should be positive numbers, also  CryRadius should be greater than HoleRadius and  CryLength should be greater than  HoleDepth. \n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.WellDetector-Tuple{}",
    "page": "Physics Model",
    "title": "GeoEfficiency.WellDetector",
    "category": "method",
    "text": "WellDetector()\n\nconstruct and return a Well-Type detector according to the input from the console.\n\nsee also: WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Well-type-Detector-1",
    "page": "Physics Model",
    "title": "Well-type Detector",
    "category": "section",
    "text": "GeoEfficiency.WellDetectorGeoEfficiency.WellDetector()note: Note\nthe position of the source is reported relative to the detector anchoring point,  for well-type detector it is taking as the point detector hole surface that  lies on the detector axis of symmetry.note: Note\nto let the program determine the detector type as well as dimension just type Detector()"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.source",
    "page": "Physics Model",
    "title": "GeoEfficiency.source",
    "category": "function",
    "text": "source(anchorPnt::Point = Point())\n\nreturn a tuple that describe the source (anchorPnt, SrcRadius, SrcLength) according to  the input from the console.\n\nanchorPnt : the source anchoring point. if it is missing the user is prompt   to input it via the console.\nSrcRadius : source radius.\nSrcLength : source length.\n\nwarning: Point/Cylinder Source\n\n\nif source type set to point source, both `SrcRadius` and `SrcLength` are set to zero. \nfor more information **see also:** [`typeofSrc()`](@ref) and [`typeofSrc(x::Int)`](@ref).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Source-1",
    "page": "Physics Model",
    "title": "Source",
    "category": "section",
    "text": "GeoEfficiency.source"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point",
    "page": "Physics Model",
    "title": "GeoEfficiency.Point",
    "category": "type",
    "text": "Point(Height::Real, Rho::Real)\n\nconstruct and return a Point source. The Point can be used as either a source by itself or an anchor point of a higher dimension source.\n\nHeight : point height relative to the detector surface.\nRho : point off-axis relative to the detector axis of symmetry.\n\nwarning: Interpretation of `Height`\nEach detector type give different interpretation to the Height as follow:-for CylDetector the point source height is consider to be measured   from the detector face surface. \nfor BoreDetector the point source height is consider to be measured   from the detector middle, +ve value are above the detector center while -ve are below. \nfor WellDetector the point source height is considered to be measured   from the detector hole surface. \n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point-Tuple{Real}",
    "page": "Physics Model",
    "title": "GeoEfficiency.Point",
    "category": "method",
    "text": "Point(Height::Real)\n\nconstruct and return an axial point.\n\nsee also: Point(Height::Real, Rho::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point-Tuple{}",
    "page": "Physics Model",
    "title": "GeoEfficiency.Point",
    "category": "method",
    "text": "Point()\n\nconstruct and return a point. prompt to input information via the console. \n\nsee also: Point(Height::Real, Rho::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point-Tuple{Real,Point}",
    "page": "Physics Model",
    "title": "GeoEfficiency.Point",
    "category": "method",
    "text": "Point(xHeight::Real, aPnt::Point)\n\nconstruct and return a point that has the same off-axis distance as aPnt but of new  height xHeight. \n\nsee also: Point(Height::Real, Rho::Real)\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point-Tuple{Point,Real}",
    "page": "Physics Model",
    "title": "GeoEfficiency.Point",
    "category": "method",
    "text": "Point(aPnt::Point, xRho::Real)\n\nconstruct and return a point that has the same height as aPnt but of new  off-axis distance Rho. \n\nsee also: Point(Height::Real, Rho::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Source-Anchoring-Point-1",
    "page": "Physics Model",
    "title": "Source Anchoring Point",
    "category": "section",
    "text": "GeoEfficiency.PointGeoEfficiency.Point(Height::Real)GeoEfficiency.Point()\nGeoEfficiency.Point(xHeight::Real, aPnt::Point)GeoEfficiency.Point(aPnt::Point, xRho::Real)"
},

{
    "location": "manual/Calculations.html#",
    "page": "Calculations",
    "title": "Calculations",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Calculations.html#GeoEfficiency.geoEff",
    "page": "Calculations",
    "title": "GeoEfficiency.geoEff",
    "category": "function",
    "text": "geoEff(detector::Detector, aPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)::Float64\n\nreturn the geometrical efficiency for a source (point, disk or cylinder) with  the detector detector. \n\nArguments\n\ndetector can be any of the leaf detectors types (CylDetector, BoreDetector, WellDetector).\naPNT: a point represent the anchoring point of the source.\nSrcRadius: Radius of the source.\nsrcHeight:  the height of an upright cylinder source.\n\nThrow\n\nan InValidGeometry if the point location is invalide.\nan NotImplementedError if source-to-detector geometry not supported yet.\n\nwarning: Warning\nthe point height of aPnt is measured differently for different detectors types. for the details, please refer to each detector entry.\n\nnote: Note\nif SrcLength equal to zero; the method return Geometrical Efficiency of a disc   source of Radius = SrcRadius and center at the point aPNT.\nif both SrcRadius and SrcLength equal to zero;   the method returns the Geometrical Efficiency of a point source at the anchoring point.\n\nExample\n\nto obtain the efficiency of a cylindrical detector of crystal radius 2.0 cm for axial    source cylinder of radius 1.0 cm and height 2.5 cm on the detector surface. \n\njulia> using GeoEfficiency\n\njulia> geoEff(CylDetector(2.0), Point(0.0), 1.0, 2.5)\n0.2923777934922748\n\nto obtain the efficiency for a bore-hole detector of crystal radius of 2.0 and height of 3.0 with    hole radius of 1.5 cm for axial source cylinder of radius 1.0 cm and height 2.5 cm starting from detector center.\n\njulia> using GeoEfficiency\n\njulia> newDet = BoreDetector(2.0, 3.0, 1.5);\n\njulia> geoEff(newDet, Point(0.0), 1.0, 2.5)\n0.5678174038944723\n\nto obtain the efficiency for a well-type detector of crystal radius of 2.0 cm and    height 3.0 cm with hole radius of 1.5 cm and depth of 1.0 cm for axial source cylinder of    radius 1.0 cm and height 2.5 cm at the hole surface.\n\njulia> using GeoEfficiency\n\njulia> newDet = WellDetector(2.0, 3.0, 1.5, 1.0);\n\njulia> geoEff(newDet, Point(0.0), 1.0, 2.5)\n0.4669614527701105\n\n\n\n\n\n"
},

{
    "location": "manual/Calculations.html#Calculations-1",
    "page": "Calculations",
    "title": "Calculations",
    "category": "section",
    "text": "calculation of the geometrical efficiency can be done via a call to the function geoEff.GeoEfficiency.geoEffnote: Information\nthe function has another method geoEff() that prompt the user to input a source and a detector via the console."
},

{
    "location": "manual/Output_Interface.html#",
    "page": "Output Interface",
    "title": "Output Interface",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Output_Interface.html#Output-Interface-1",
    "page": "Output Interface",
    "title": "Output Interface",
    "category": "section",
    "text": "Calculation of the geometrical efficiency can be run in one of two modes aside from using geoEff,  the interactive/direct mode and the batch mode."
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.calc",
    "page": "Output Interface",
    "title": "GeoEfficiency.calc",
    "category": "function",
    "text": "calc(detector::Detector = Detector(), aSource::Tuple{Point, Float64, Float64,} = source())\n\ncalculate and display on the console the geometrical efficiency of the  detector detector for the tuple aSource describing the source.\n\nThrow an  inValidGeometry if the source location is inappropriate.\n\nsee also: geoEff(::Detector, ::Tuple{Point, Float64, Float64})\n\nnote: Missing/No Argument(s)\nif source description aSource alone or even both source description and detector detect   are missing, the method prompt the user to complete the missing data via the console.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.calcN",
    "page": "Output Interface",
    "title": "GeoEfficiency.calcN",
    "category": "function",
    "text": "calcN()\n\ncalculate and display the geometrical efficiency repeatedly.  Prompt the user to input a detector and a source from the console. Prompt the user repeatedly until it exit (give a choice to use the same  detector or a new detector).\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#Interactive/Direct-Mode-1",
    "page": "Output Interface",
    "title": "Interactive/Direct Mode",
    "category": "section",
    "text": "GeoEfficiency.calcfor repeated calculations.GeoEfficiency.calcN"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.batch",
    "page": "Output Interface",
    "title": "GeoEfficiency.batch",
    "category": "function",
    "text": "batch()\n\nprovide batch calculation of the geometrical efficiency based on the information provided  by the CSV files by default located in /home/travis/GeoEfficiency.\n\nresults are saved on a CSV  file(s) named after the detector(s). the CSV  file(s)  by default found in /home/travis/GeoEfficiency/results, also a log of the results are displayed on the console.\n\nfor more information on batch refer to batchInfo.\n\n\n\n\n\nbatch(\n	detector::Detector,\n	srcHeights_array::Vector{S},\n	srcRhos_array::Vector{S}=[0.0],\n	srcRadii_array::Vector{S}=[0.0],\n	srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::String 	where S <: Real\n\nprovide batch calculation of the geometrical efficiency for the detector detector.  results are saved on a CSV  file named after the detector.  the CSV  file by default found in /home/travis/GeoEfficiency/results. this method return the actual  path to the CSV file.  also a log of the results are displayed on the console.\n\nsrcHeights_array: list of source heights to feed to batch.\nsrcRhos_array: list of source off-axis distances to feed to batch. \nsrcRadii_array: list of source radii to feed to batch.\nsrcLengths_array: list of source lengths to feed to batch.\n\nA set of sources is constructed of every valid combination of parameter in the srcRhos_array, srcRadii_array and srcLengths_array arrays with conjunction with ispoint.\n\nwarning: point/cylinder source\nIf ispoint is true (the default) the source type is a point source and the parameters   in srcRadii_array and srcLengths_array arrays is completely ignored.\nIf ispoint is false the parameters in srcRhos_array is completely ignored.\n\n\n\n\n\nbatch( \n	detectors_array::Vector{<: Detector},\n    srcHeights_array::Vector{S},\n    srcRhos_array::Vector{S}=[0.0],\n    srcRadii_array::Vector{S}=[0.0],\n    srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::Vector{String} where S <: Real\n\nsame as batch(::Detector, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool) but accept a list of detectors detectors_array. return a list of paths to the CSV of files (file for each detector) storing the results.\n\n\n\n\n\nbatch(\n	detector_info_array::Matrix{S},\n	srcHeights_array::Vector{S},\n	srcRhos_array::Vector{S}=[0.0],\n	srcRadii_array::Vector{S}=[0.0],\n	srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::Vector{String} 	where S <: Real\n\nsame as batch(::Vector{Detector}, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool) but provide batch calculation of the  geometrical efficiency for the detector in the detector_info_array after applying getDetectors. return a list of paths to the CSV of files (file for each detector) storing the results.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.batchInfo",
    "page": "Output Interface",
    "title": "GeoEfficiency.batchInfo",
    "category": "constant",
    "text": "The function batch() can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved   Values [CSV] files, that can be easily edit by Microsoft Excel,  by default located in the directory /home/travis/GeoEfficiency .\n\nresults of batch calculation are saved on a CSV  file(s) named after the detector(s).  the CSV  file by default found in /home/travis/GeoEfficiency/results.\n\nCSV input files\n\nDetectors.csv contains the detectors description; The line format is: \n\n	 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |\n	 ---------------| ---------------|-------------|----------- |\n\nsrcHeights.csv contains the source heights; \n\n	 Source_Heights | \n	 ---------------|\n\nsrcRhos.csv contains the source off-axis distances; 	 				\n\n	 Source_Rhos | \n 	 ------------|\n\nsrcRadii.csv contains the source radii for disc and cylindrical sources; 			\n\n	 Source_Radii| \n	 ------------|\n\nsrcLengths.csv contains the source length for cylindrical sources; 	\n\n	 Source_Lengths| \n	 --------------|\n\nCSV results files\n\nCSV  file containing the results has columns of headers   AnchorHeight, AnchorRho, srcRadius, srcLength, GeoEfficiency for non-point sources   and columns of headers Height, Rho, GeoEfficiency for point sources.\n\nnote: Note\nfor Comma Saved Values [CSV] files each line represent an entry,   the first line is always treated as the header.\n\nwarning: Warning\nthe program expect each line to contain one number for all CSV files except  for Detectors.csv each line should contain at least one number or at   most four separated numbers.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.max_batch-Tuple{Real}",
    "page": "Output Interface",
    "title": "GeoEfficiency.max_batch",
    "category": "method",
    "text": "max_batch(n::Real)\n\nset the value of _max_batch which give a hint to the program on maximum number of entries per  detector displayed on the console in batch mode. This function do not affect the saving of the batch calculation. \n\nnote: Special Values\n\n\nNegative value will display prevent batch results from printed to the `console`. \nwhile `Inf` will print all  batch results to the `console`.\n\nsee also: max_batch()\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.max_batch-Tuple{}",
    "page": "Output Interface",
    "title": "GeoEfficiency.max_batch",
    "category": "method",
    "text": "max_batch()\n\nset the value of _max_batch which give a hint to the program on maximum number of entries per  detector displayed on the console in batch mode. to its default value set by the constant max_display.\n\nsee also: max_batch(n::Real)\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#Batch-Mode-1",
    "page": "Output Interface",
    "title": "Batch Mode",
    "category": "section",
    "text": "Use batch() to let the program inspect the excel files containing the required information and run the calculations.GeoEfficiency.batchAs mentioned above, the batch calculation controlled by CSV files. the following refer to information on the CSV files structure and location.GeoEfficiency.batchInfoThe result of the batch calculation is also displayed in the console. the function max_batch(n::Real) can be used to give a hint (thus it may or may not apply) to the program to limit displayed results.GeoEfficiency.max_batch(n::Real)Also the without arguments max_batch() restore back the default value.GeoEfficiency.max_batch()Before the batch mode start  the user is asked to decide the source type. once the calculation is done the user can check the current setting for the source or modify it. for details see the next section."
},

{
    "location": "manual/Input_Batch.html#",
    "page": "Batch Mode Input",
    "title": "Batch Mode Input",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.typeofSrc",
    "page": "Batch Mode Input",
    "title": "GeoEfficiency.typeofSrc",
    "category": "function",
    "text": "typeofSrc()::SrcType\n\nreturn the current value of the global GeoEfficiency.srcType.\n\n\n\n\n\ntypeofSrc(x::Int)::SrcType\n\nset and return the value of the global GeoEfficiency.srcType corresponding to x.\n\nsrcUnknown = -1 also any negative integer treated as so, \nsrcPoint   = 0, \nsrcLine    = 1, \nsrcDisk    = 2, \nsrcVolume  = 3, \nsrcNotPoint = 4 also any greater than 4 integer treated as so.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.setSrcToPoint",
    "page": "Batch Mode Input",
    "title": "GeoEfficiency.setSrcToPoint",
    "category": "function",
    "text": "setSrcToPoint()::Bool\n\nreturn whether the source type is a point or not.\n\n\n\n\n\nsetSrcToPoint(yes::Bool)::Bool\n\nreturn whether the source type is a point or not after setting srcType to srcPoint if  yes = true else if yes = false setting it to srcNotPoint if it was not already  set to other non-point type (srcDisk, srcLine, srcVolume).\n\nnote: Note\nThe user can use this function to change the source type any time.\nThe source type is set the fist time asked for source.\n\nsee also: typeofSrc(::Int).\n\n\n\n\n\nsetSrcToPoint(prompt::AbstractString)::Bool\n\nreturn whether the source type is a point or not. only prompt the user to set the source  type if it were not already set before. \n\nsee also: typeofSrc(::Int), setSrcToPoint(::Bool).\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#Batch-Mode-Input-1",
    "page": "Batch Mode Input",
    "title": "Batch Mode Input",
    "category": "section",
    "text": "GeoEfficiency.typeofSrcGeoEfficiency.setSrcToPointwarnning: Warnning\nCurrently, the source type has no effect but to decide if the source is a point source or a higher dimension source. "
},

{
    "location": "manual/Development.html#",
    "page": "Development",
    "title": "Development",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Development.html#Introduction-1",
    "page": "Development",
    "title": "Introduction",
    "category": "section",
    "text": "This section is provided for developer who are interested in extending the functionality of the GeoEfficiency package or just make use of some of its functionality. this software is licensed under the MIT license. "
},

{
    "location": "manual/Development.html#Configuration-1",
    "page": "Development",
    "title": "Configuration",
    "category": "section",
    "text": "The package contain many parameters that can be set within the program sourcecode. they can be found in the source file Config.jlparameter description default value\ndataFolder name of the root directory \"GeoEfficiency\"\ndataDir root directory joinpath(homedir(), dataFolder)\nintegrate use the package QuadGK to perform integration begin using QuadGK; QuadGK.quadgk; end\nrelativeError  1.0E-4\nabsoluteError  eps(1.0)\nresultsFolder name of the result directory inside the root directory \"results\"\nmax_display define the default for maximum number of entries shown in the console in batch mode 20 see max_batch"
},

{
    "location": "manual/Development.html#GeoEfficiency.GeoException",
    "page": "Development",
    "title": "GeoEfficiency.GeoException",
    "category": "type",
    "text": "custom abstract Exception that is the parent of all Exception in the GeoEfficiency package\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.InValidDetectorDim",
    "page": "Development",
    "title": "GeoEfficiency.InValidDetectorDim",
    "category": "type",
    "text": "custom Exception indicating invalid radiation detector dimensions\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.@validateDetector",
    "page": "Development",
    "title": "GeoEfficiency.@validateDetector",
    "category": "macro",
    "text": "@validateDetector cond [text]\n\nthrow an InValidDetectorDim if cond is false.  Message text is optionally displayed upon validation failure.\n\nExamples\n\njulia> @validateDetector iseven(3) \"3 is an odd number!\"\nERROR: InValidDetectorDim: 3 is an odd number!\n\njulia> @validateDetector isodd(3) \"What even are numbers?\"\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.InValidGeometry",
    "page": "Development",
    "title": "GeoEfficiency.InValidGeometry",
    "category": "type",
    "text": "custom Exception indicating a not valid source to detector geometry\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.@inValidGeometry",
    "page": "Development",
    "title": "GeoEfficiency.@inValidGeometry",
    "category": "macro",
    "text": "@inValidGeometry [msg]\n\ncustom macro to throw NotImplementedError Exception.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.NotImplementedError",
    "page": "Development",
    "title": "GeoEfficiency.NotImplementedError",
    "category": "type",
    "text": "custom Exception indicating a source-to-detector geometry which may be valid but not implemented yet\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.@notImplementedError",
    "page": "Development",
    "title": "GeoEfficiency.@notImplementedError",
    "category": "macro",
    "text": "@notImplementedError [msg]\n\ncustom macro to throw NotImplementedError Exception.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#Error-System-1",
    "page": "Development",
    "title": "Error System",
    "category": "section",
    "text": "GeoEfficiency.GeoExceptionGeoEfficiency.InValidDetectorDimGeoEfficiency.@validateDetectorGeoEfficiency.InValidGeometryGeoEfficiency.@inValidGeometry\nGeoEfficiency.NotImplementedErrorGeoEfficiency.@notImplementedError\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.input",
    "page": "Development",
    "title": "GeoEfficiency.input",
    "category": "function",
    "text": "UnExported\n\ninput(prompt::AbstractString = \"?: \", incolor::Symbol = :green)\n\nreturn a string represent the user respond delimited by new line excluding the new line. prompt the user with the massage prompt defaults to ?.  wait until the user type its respond and press return.  incolor specify the prompt text color, default to green may take any of the values  :black, :blue, :cyan, :green, :light_black, :light_blue, :light_cyan, :light_green, :light_magenta, :light_red, :light_yellow, :magenta, :red, :white, or :yellow.\n\ncolor: Color\n\n\n	The effect of color is not allways respected in all teriminals as some color may be simplly \n	ignored by some teriminals.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.getfloat",
    "page": "Development",
    "title": "GeoEfficiency.getfloat",
    "category": "function",
    "text": "UnExported\n\ngetfloat(prompt::AbstractString = \"?: \", from::Real = -Inf, to::Real = Inf; KW...)::Float64\n\nprompts the user with the massage prompt defaults to ?: to input a numerical expression  evaluate to a numerical value. check that the numerical value is in interval [from, to[ by default [-∞,	∞[ before returning it as a Float64.  throws ArgumentError when the given interval is not valid. if the numerical expression fail to evaluated to numerical value or the numerical value is not in the valid interval  the function will warn the user and reprompt him to give a valid expresion.\n\nKW arguments\n\nvalue::AbstractString=\"nothing\" : if provided the function will not ask for input from the   console and take it as if it where inputted from the  console [for test propose mainly].\nlower::Bool=true : whether or not to inculde from as accepted value.\nupper::Bool=false : whether or not to inculde to as accepted value.\n\nnote: Note\n\n\n	A blank input (i.e just a return) is considered as being `0.0`. \n	Input from the `console` can be numerical expression not just a number. \n	expression like ``5/2`` ; ``5//2`` ; ``pi`` ; ``π/2`` ; ``exp(2)`` ; ``1E-2 `` ; ``5.2/3`` ; \n	``sin(1)`` ;  ``sin(1)^2`` are all valid expressions.\n\nExamples\n\njulia> getfloat(\"input a number:\", value=\"3\")\n3.0\n\njulia> getfloat(\"input a number:\", value=\"\")\n0.0\n\njulia> getfloat(\"input a number:\", value=\"5/2\")\n2.5\n\njulia> getfloat(\"input a number:\", value=\"5//2\")\n2.5\n\njulia> getfloat(\"input a number:\", value=\"pi\")\n3.141592653589793\n\njulia> getfloat(\"input a number:\", value=\"-2\")\n-2.0\n\njulia> getfloat(\"input a number:\", value=\"sin(1)^2\")\n0.7080734182735712\n\njulia> getfloat(\"input a number:\", 1, 5, value=\"5\", upper=true)\n5.0\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#Console-Input-1",
    "page": "Development",
    "title": "Console Input",
    "category": "section",
    "text": "Julia language is quite reach language but it seems a good idea thought to collect repeated tasks involving input from console in compact and customized to the need function. this section provide two essential functions to deal with inputs from the console. the first:GeoEfficiency.inputwhile the second is a more complex function:GeoEfficiency.getfloatThose function are not exported that is normally the user will not need to use them but they are documented here to allow a developer ranked user to make use of them."
},

{
    "location": "manual/Development.html#GeoEfficiency.RadiationDetector",
    "page": "Development",
    "title": "GeoEfficiency.RadiationDetector",
    "category": "type",
    "text": "abstract super-supertype of all detectors types\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "type",
    "text": "Detector\n\nabstract supertype of all detectors types of cylidericalish shapes. also can be used to construct any leaf type.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector-Tuple{}",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "method",
    "text": "Detector()\n\nconstruct and return an object of the Detector leaf types  (CylDetector, BoreDetector or WellDetector) according to the input from the console.\n\nnote: Note\nall required information is acquired from the console and would warn user on invalid data.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector-NTuple{4,Real}",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "method",
    "text": "Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)\n\nconstruct and return well-type, bore-hole or cylindrical detector according to the arguments.  it inspect the arguments and call the appropriate leaf type constructor.\n\nnote: Missing Argument(s)\nif the value(s) of the last argument(s) isre zero, it acts as a missing argument(s).\n\nsee also: CylDetector, BoreDetector, WellDetector.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector-Tuple{Real}",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "method",
    "text": "Detector(CryRadius::Real)\n\nsame as CylDetector(CryRadius::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector-Tuple{Real,Real}",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "method",
    "text": "Detector(CryRadius::Real, CryLength::Real)\n\nsame as CylDetector(CryRadius::Real, CryLength::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.Detector-Tuple{Real,Real,Real}",
    "page": "Development",
    "title": "GeoEfficiency.Detector",
    "category": "method",
    "text": "Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)\n\nsame as BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real) except when HoleRadius = 0.0 it acts as  CylDetector(CryRadius::Real, CryLength::Real).\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#Physics-Model-1",
    "page": "Development",
    "title": "Physics Model",
    "category": "section",
    "text": "Two abstract detector types defined in the package to classify the detectors, the top most super type,GeoEfficiency.RadiationDetectorany future detector definition should inherit from RadiationDetector. The second abstract detector   Detector is also a sub-type of RadiationDetector but it only accommodates cylindrical type only.GeoEfficiency.Detectorcan be used to construct leaf detector.Detector()also it can be used to construct a concrete detector depend on the provided arguments.Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)Detector(CryRadius::Real)Detector(CryRadius::Real, CryLength::Real)Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)"
},

{
    "location": "manual/Development.html#GeoEfficiency.detector_info_from_csvFile",
    "page": "Development",
    "title": "GeoEfficiency.detector_info_from_csvFile",
    "category": "function",
    "text": "UnExported\n\n detector_info_from_csvFile(detectors::AbstractString = Detectors, \n                                  datadir::AbstractString = dataDir)\n\nreturn a vector{Detector} based on information in the file of name detectors found in the  directory datadir.\n\nnote: Note\nif no path is given the second argument datadir is default to /home/travis/GeoEfficiency as set by   the constant dataDir. \nif no file name is specified the name of the predefined file Detectors.csv as set by   the constant Detectors. \nthe no argument method is the most useful; other methods are mainly for test propose.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.read_from_csvFile",
    "page": "Development",
    "title": "GeoEfficiency.read_from_csvFile",
    "category": "function",
    "text": "UnExported\n\nread_from_csvFile(csv_data::AbstractString, \n                   datadir::AbstractString = dataDir)::Vector{Float64}\n\nreturn Vector{Float64} based on data in csv file named csv_data. directory datadir point to    where the file is located default to hometravisGeoEfficiency as set by the constant dataDir.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.read_batch_info",
    "page": "Development",
    "title": "GeoEfficiency.read_batch_info",
    "category": "function",
    "text": "UnExported\n\nread_batch_info()\n\nread detectors and sources parameters from the predefined csv files.\n\nReturn a tuple 	   (detectorsarray, 		srcHeightsarray, 		srcRhosarray, 		srcRadiiarray, 		srcLengthsarray, 		GeoEfficiencyisPoint)\n\n\n\n\n\nUnExported\n\nread_batch_info(datadir::AbstractString,\n              detectors::AbstractString, \n             srcHeights::AbstractString,\n                srcRhos::AbstractString,\n               srcRadii::AbstractString,\n             srcLengths::AbstractString)\n\nread detectors and sources parameters from the location given in the argument list.\n\nReturn a tuple\n\n   (detectors_array,\n	srcHeights_array,\n	srcRhos_array,\n	srcRadii_array,\n	srcLengths_array,\n	isPoint)\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.getDetectors",
    "page": "Development",
    "title": "GeoEfficiency.getDetectors",
    "category": "function",
    "text": "getDetectors(detectors_array::Vector{<:Detector} = Detector[])::Vector{Detector}\n\nreturn the detectors_array as Vector{Detector} extended by the entered detectors and sorted according to the  detector volume.  prompt the user to input detector parameters from the console.\n\nnote: Note\nIf no array received in the input an empty array will be created to receive the converted detectors.\n\n\n\n\n\ngetDetectors(detector_info_array::Matrix{<:Real}, \n				 detectors_array::Vector{<:Detector} = Detector[]; \n				 						   console_FB=true)::Vector{Detector}\n\nreturn detectors_array as Vector{Detector}, after extending it with the successfully converted detectors. while,  attempt to convert detectors from the information in detector_info_array. \n\nnote: Note\nif console_FB argument is set to true , the function will call getDetectors() to take input from the console if the detector_info_array is empty or contain no numerical element.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#Batch-Mode-Input-1",
    "page": "Development",
    "title": "Batch Mode Input",
    "category": "section",
    "text": "GeoEfficiency.detector_info_from_csvFileGeoEfficiency.read_from_csvFileGeoEfficiency.read_batch_infoGeoEfficiency.getDetectors"
},

{
    "location": "manual/Development.html#GeoEfficiency.checkResultsDirs",
    "page": "Development",
    "title": "GeoEfficiency.checkResultsDirs",
    "category": "function",
    "text": "UnExported\n\ncheckResultsDirs()\n\nmake sure that directories for saving the results are already exist or create  them if necessary.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.writecsv_head",
    "page": "Development",
    "title": "GeoEfficiency.writecsv_head",
    "category": "function",
    "text": "UnExported\n\nwritecsv_head(filename::AbstractString, content::VecOrMat{<:Union{Int,Float64}}, head=[])\n\nWrite content to the comma delimited values file filename.  optionally with header head.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency._max_batch",
    "page": "Development",
    "title": "GeoEfficiency._max_batch",
    "category": "constant",
    "text": "Global variable that give a hint to the program on maxumam number of entries per detector displayed  on the console in btach mode.\n\nnote: Special Values\n\n\nNegative value will display prevent batch results from printed to the `console`. \nwhile `Inf` will print all batch results to the `console`.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency.max_display",
    "page": "Development",
    "title": "GeoEfficiency.max_display",
    "category": "constant",
    "text": "set the default value for the global variable _max_batch\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#GeoEfficiency._batch",
    "page": "Development",
    "title": "GeoEfficiency._batch",
    "category": "function",
    "text": "UnExported\n\n_batch(\n	::Val{true},\n	detector::Detector,\n	srcHeights_array::Vector{Float64},\n	srcRhos_array::Vector{Float64},\n	srcRadii_array::Vector{Float64},\n	srcLengths_array::Vector{Float64}\n	)\n\nbatch calculation for specialized for point sources.  return a tuple of three arrays the detector, the resultsand the path of the CSV  file containing results. \n\nThe results has columns of headers Height, Rho, GeoEfficiency.\n\nnote: Note\nfor all arrays srcHeights_array, srcRhos_array, srcRadii_array and srcLengths_array   element type should be Float64. if any of them have other numerical element type it   should converted to Float64 using float before passing it to this method.\n\nwarning: Warning\nboth srcRadii_array, srcLengths_array are completely ignored as this method is for point sources.\n\n\n\n\n\nUnExported\n\n_batch(\n	::Val{false},\n	detector::Detector,\n	srcHeights_array::Vector{Float64},\n	srcRhos_array::Vector{Float64},\n	srcRadii_array::Vector{Float64},\n	srcLengths_array::Vector{Float64},\n	)\n\nbatch calculation for specialized for non-point sources.  return a tuple of three arrays the detector, the resultsand the path of the CSV  file containing results. \n\nThe results has columns of headers  AnchorHeight, AnchorRho, srcRadius, srcLength, GeoEfficiency.\n\nnote: Note\nfor all arrays srcHeights_array, srcRhos_array, srcRadii_array and srcLengths_array  element type should be Float64. if any of them have other numerical element type it  should converted to Float64 using float before passing it to this method.\n\n\n\n\n\n"
},

{
    "location": "manual/Development.html#Output-Interface-1",
    "page": "Development",
    "title": "Output Interface",
    "category": "section",
    "text": "GeoEfficiency.checkResultsDirsGeoEfficiency.writecsv_headGeoEfficiency._max_batchGeoEfficiency.max_displayGeoEfficiency._batch"
},

{
    "location": "list.html#",
    "page": "Index",
    "title": "Index",
    "category": "page",
    "text": ""
},

{
    "location": "list.html#Index-1",
    "page": "Index",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "LICENSE.html#",
    "page": "LICENSE",
    "title": "LICENSE",
    "category": "page",
    "text": ""
},

{
    "location": "LICENSE.html#LICENSE-1",
    "page": "LICENSE",
    "title": "LICENSE",
    "category": "section",
    "text": "The GeoEfficiency.jl package is licensed under the MIT \"Expat\" LicenseCopyright (c) 2019: Mohamed E. Krar <DrKrar@gmail.com>.Permission is hereby granted, free of charge, to any person obtaining a copy  of this software and associated documentation files (the \"Software\"), to deal  in the Software without restriction, including without limitation the rights  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  copies of the Software, and to permit persons to whom the Software is  furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all  copies or substantial portions of the Software with an appropriate reference to   the original work.THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  SOFTWARE."
},

]}
