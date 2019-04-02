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
    "text": "The Package GeoEfficiency, an officially registered Julia program, provides a set of tools  to calculate the geometrical efficiency in a fast and accurate way.  The Package models a radiation detector irradiated by a radioactive source.  The Package relay directly on numerical evaluation of closed form analytical formula describing the geometrical efficiency.Author Mohamed Krar (DrKrar@gmail.com)\nRepository GitHub.com\nDocumentation ReadTheDocs(stale)\nCurrent version v\"0.9.2\"\nFirst Created Fri Aug 14 20:12:01 2015"
},

{
    "location": "index.html#The-following-list-show-the-current-and-planed-features:-1",
    "page": "Home",
    "title": "The following list show the current and planed features:-",
    "category": "section",
    "text": "the checked items represent allready present feature.[x] support of widely used detector geometries.\n[x] cylinder detectors.\n[x] bore-hole detectors.\n[x] well-type detectors.[ ] support of specialized detector geometries.[x] support of isotropic radioactive sources.\n[x] point sources.\n[x] disc sources.\n[x] cylinder sources.[ ] support of anisotropic radioactive sources.\n[ ] point sources.[ ] consider more details of the measurement setup.\n[ ] the detector effect.\n[ ] the end cap effect.\n[ ] the medium and absorber effect.\n[ ] combine the effect of the source geometry and composition. "
},

{
    "location": "index.html#Requirements-1",
    "page": "Home",
    "title": "Requirements",
    "category": "section",
    "text": "Julia 0.6 or above.\nQuadGK 0.3.0 or above, will be installed automatically during the package Installation.\nCompat 0.63.0 or above, will be installed automatically during the package Installation."
},

{
    "location": "index.html#Download-and-Install-the-Package-1",
    "page": "Home",
    "title": "Download and Install the Package",
    "category": "section",
    "text": "The package is registered and so can be installed through the Julia package system by running julia> using Pkg\r\njulia> Pkg.add(\"GeoEfficiency\") "
},

{
    "location": "index.html#Quick-Usage-1",
    "page": "Home",
    "title": "Quick Usage",
    "category": "section",
    "text": "julia> using GeoEfficiency\r\njulia> calc()see also: geoEff(), calcN(), batch()"
},

{
    "location": "index.html#Package-Overview-1",
    "page": "Home",
    "title": "Package Overview",
    "category": "section",
    "text": "The following constructor can be used to construct a specific type of detector CylDetector for cylindrical detector, \nBoreDetector for bore hole, \nWellDetector for well type detector.While the function Detector can be used to construct any of the above types. You may try also getDetectors.Point constructor is used to construct an anchoring point of a source relative to it its position to the detector is specified. For a point source, the anchoring point is the source itself.  The source() method take input from the \'console\' and return a tuple describing the source.The efficiency calculation can be done by one of the functions: geoEff used with or without argument(s), \ncalc ask for the required information from the \'console\', \ncalcN just a repeat of the calc function \nbatch() which try to take required information from csv files located in   the home directory inside a folder called GeoEfficiency.For more on the function and its methods prefix the name of the function by ?.note: Note\nInput from the \'console\' can be numerical expression not just a number.5/2, 5//2, pi, exp(2) , 1E-2, 5.2/3, sin(1), pi/2/3 All are valid expressions."
},

{
    "location": "index.html#Batch-Calculation-1",
    "page": "Home",
    "title": "Batch Calculation",
    "category": "section",
    "text": "The package can be used to perform batch calculations by calling one of the  methods of the function batch. The output results of batch calculations is  found by default in GeoEfficiency\\results folder inside the user home.For example	c:\\users\\yourusername\\GeoEfficiency\\results\\.The function batch() can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved  Values  [CSV] files, that can be easily edit by Microsoft Excel, located by default  in the GeoEfficiency folder.Those Comma Saved  Values [CSV] files are:-Detectors.csv contains the detectors description; The line format is: 	 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |\r\n	 ---------------| ---------------|-------------|----------- |srcHeights.csv contains the source heights; 	     Source_Heights | \r\n	 ---------------|srcRhos.csv contains the source off-axis distances; 	 					 Source_Rhos | \r\n 	 ------------|srcRadii.csv contains the source radii for disc and cylindrical sources; 				 Source_Radii| \r\n	 ------------|srcLengths.csv contains the source length for cylindrical sources; 		 Source_Lengths| \r\n	 --------------|note: Note\nfor Comma Saved Values [CSV] files each line represent an entry, the first line is always treated as the header.warning: Warning\nthe program expect each line to contain one number for all CSV files except for Detectorscsv each line should contain at least one number or at most four separated numbers"
},

{
    "location": "manual/GeoEfficiency.html#",
    "page": "GeoEfficiency",
    "title": "GeoEfficiency",
    "category": "page",
    "text": ""
},

{
    "location": "manual/GeoEfficiency.html#GeoEfficiency.GeoEfficiency",
    "page": "GeoEfficiency",
    "title": "GeoEfficiency.GeoEfficiency",
    "category": "module",
    "text": "GeoEfficiency Package\n\nintroduce a fast and flexible tool to calculate in batch or individually the geometrical efficiency  for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form  a source. The source can be a point, a disc or even a cylinder.\n\nQuick Usage\n\ngeoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.\ncalc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.\ncalcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.\nbatch()	: Calculate the geometrical efficiency using data in the C:\\Users\\Mohamed\\GeoEfficiency folder in batch mode.\n\nfor more information and updates refer to the repository at GitHub.com\n\n\n\n\n\n"
},

{
    "location": "manual/GeoEfficiency.html#GeoEfficiency.about",
    "page": "GeoEfficiency",
    "title": "GeoEfficiency.about",
    "category": "function",
    "text": " *************************************************\n **            -=) GeoEfficiency (=-            **\n **  Accurate Geometrical Efficiency Calculator **\n **   First Created on Fri Aug 14 20:12:01 2015 **\n *************************************************\n\n Author:        Mohamed E. Krar,  @e-mail: DrKrar@gmail.com \n Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3\n Repository:    https://github.com/DrKrar/GeoEfficiency.jl/\n Version:       v\"0.9.3-DEV\" - (4 days old master)  \n Documentation: http://geoefficiencyjl.readthedocs.org\n\n\n\nBatch mode \n-  read files by defaul from directory `C:\\Users\\Mohamed\\GeoEfficiency`\n-  save results by default to directory `C:\\Users\\Mohamed\\GeoEfficiency\\results`\n\nfor more information see `batch`, `batchInfo`.\n\n\n\n\n\n"
},

{
    "location": "manual/GeoEfficiency.html#GeoEfficiency-1",
    "page": "GeoEfficiency",
    "title": "GeoEfficiency",
    "category": "section",
    "text": "GeoEfficiency.GeoEfficiency\r\nGeoEfficiency.about"
},

{
    "location": "manual/Error.html#",
    "page": "Error",
    "title": "Error",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Error.html#GeoEfficiency.GeoException",
    "page": "Error",
    "title": "GeoEfficiency.GeoException",
    "category": "type",
    "text": "coustom abstract Exception that is the parent of all exception in the GeoEfficiency package\n\n\n\n\n\n"
},

{
    "location": "manual/Error.html#GeoEfficiency.InValidDetectorDim",
    "page": "Error",
    "title": "GeoEfficiency.InValidDetectorDim",
    "category": "type",
    "text": "coustom Exception indicating inValid radiation detector dimentions\n\n\n\n\n\n"
},

{
    "location": "manual/Error.html#GeoEfficiency.@validateDetector",
    "page": "Error",
    "title": "GeoEfficiency.@validateDetector",
    "category": "macro",
    "text": "@validateDetector cond [text]\n\nThrow an InValidDetectorDim if cond is false.  Message text is optionally displayed upon validation failure.\n\nExamples\n\njulia> @validateDetector iseven(3) \"3 is an odd number!\"\nERROR: InValidDetectorDim: 3 is an odd number!\n\njulia> @validateDetector isodd(3) \"What even are numbers?\"\n\n\n\n\n\n"
},

{
    "location": "manual/Error.html#GeoEfficiency.NotImplementedError",
    "page": "Error",
    "title": "GeoEfficiency.NotImplementedError",
    "category": "type",
    "text": "coustom Exception source to detector condation which may be valid but not implemented yet\n\n\n\n\n\n"
},

{
    "location": "manual/Error.html#GeoEfficiency.@notImplementedError",
    "page": "Error",
    "title": "GeoEfficiency.@notImplementedError",
    "category": "macro",
    "text": "coustom macro to throw NotImplementedError Exception \n\n\n\n\n\n"
},

{
    "location": "manual/Error.html#Error-1",
    "page": "Error",
    "title": "Error",
    "category": "section",
    "text": "GeoEfficiency.GeoException\r\nGeoEfficiency.InValidDetectorDim\r\nGeoEfficiency.@validateDetector\r\nGeoEfficiency.NotImplementedError\r\nGeoEfficiency.@notImplementedError\r\n"
},

{
    "location": "manual/Input_Console.html#",
    "page": "Input_Console",
    "title": "Input_Console",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Input_Console.html#GeoEfficiency.input",
    "page": "Input_Console",
    "title": "GeoEfficiency.input",
    "category": "function",
    "text": "UnExported\n\ninput(prompt::AbstractString = \"? \", incolor::Symbol = :green)\n\nreturn a string delimited by new line excluding the new line. prompt the user with the massage prompt defaults to ?.  incolor specify the prompt text color, default to green.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Console.html#GeoEfficiency.getfloat",
    "page": "Input_Console",
    "title": "GeoEfficiency.getfloat",
    "category": "function",
    "text": "UnExported\n\ngetfloat(prompt::AbstractString = \"? \", from::Real = -Inf, to::Real = Inf; KW...)::Float64\n\nprompts the user with the massage prompt defaults to ? to input a numerical expression  evaluate to a numerical value and asserts that the value is by default in the semi open interval [from, to[ before returning it as a Float64. throws ArgumentError when the given interval is not valid.\n\nKW arguments\n\nvalue::AbstractString=\"nothing\" : if provided the function will not ask for input from the   console and take it as if it where inputted from the  console [for test propose mainly].\nlower::Bool=true : whether or not to inculde from as accepted value.\nupper::Bool=false : whether or not to inculde to as accepted value.\n\nnote: Note\na blank input (i.e just a return) is considered as being 0.0.\ninput from the console can be numerical expression not just a number.\nAll 5/2, 5//2, exp(2), pi, 1E-2, 5.2/3, sin(1), pi/2/3   are valid mathematical expressions.\n\nExamples\n\njulia> getfloat(\"input a number:\", value=\"3\")\n3.0\n\njulia> getfloat(\"input a number:\", value=\"\")\n0.0\n\njulia> getfloat(\"input a number:\", value=\"5/2\")\n2.5\n\njulia> getfloat(\"input a number:\", value=\"5//2\")\n2.5\n\njulia> getfloat(\"input a number:\", value=\"pi\")\n3.141592653589793\n\njulia> getfloat(\"input a number:\", value=\"-2\")\n-2.0\n\njulia> getfloat(\"input a number:\", 1, 5, value=\"5\", upper=true)\n5.0\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Console.html#Input_Console-1",
    "page": "Input_Console",
    "title": "Input_Console",
    "category": "section",
    "text": "GeoEfficiency.input\r\nGeoEfficiency.getfloat"
},

{
    "location": "manual/Physics_Model.html#",
    "page": "Physics_Module",
    "title": "Physics_Module",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Point",
    "page": "Physics_Module",
    "title": "GeoEfficiency.Point",
    "category": "type",
    "text": "Point(Height::Real, Rho::Real)\n\nconstruct and return a Point source that can be used as either a source by itself or an anchor point of a higher dimension source.\n\nHeight : point height relative to the detector surface.\nRho : point off-axis relative to the detector axis of symmetry.\n\nnote: Note\nEach detector type give different interpretation to the height as follow:-for CylDetector the point source height is consider to be measured   from the detector face surface. \nfor BoreDetector the point source height is consider to be measured   from the detector middle, +ve value are above the detector center while -ve are below. \nfor WellDetector the point source height is considered to be measured   from the detector hole surface. \n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.source",
    "page": "Physics_Module",
    "title": "GeoEfficiency.source",
    "category": "function",
    "text": "source(anchorPnt::Point = Point())\n\nreturn a tuple that describe the source (anchorPnt, SrcRadius, SrcLength) according to  the input from the console.\n\nanchorPnt : the source anchoring point. if it is missing the user is prompt   to input it via the console.\nSrcRadius : source radius.\nSrcLength : source length.\n\nwarning: Warning\nIf the global variable srcType is set to srcPoint, both SrcRadius and SrcLength  are set to zero.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.CylDetector",
    "page": "Physics_Module",
    "title": "GeoEfficiency.CylDetector",
    "category": "type",
    "text": "CylDetector(CryRadius::Real, CryLength::Real)\n\nconstruct and return a cylindrical detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\n\nwarning: Warning\nboth CryRadius and CryLength should be positive, while CryLength can also be set to zero.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.BoreDetector",
    "page": "Physics_Module",
    "title": "GeoEfficiency.BoreDetector",
    "category": "type",
    "text": "BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)\n\nconstruct and return a bore-hole detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\nHoleRadius : the detector hole radius.\n\nwarning: Warning\nCryRadius and CryLength, HoleRadius should be positive numbers, also  CryRadius should be greater than HoleRadius.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.WellDetector",
    "page": "Physics_Module",
    "title": "GeoEfficiency.WellDetector",
    "category": "type",
    "text": "WellDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)\n\nconstruct and return a Well-Type detector of the given crystal dimensions:-\n\nCryRadius : the detector crystal radius.\nCryLength : the detector crystal length.\nHoleRadius : the detector hole radius.\nHoleDepth : the detector hole length.\n\nwarning: Warning\nall arguments should be positive numbers, also  CryRadius should be greater than HoleRadius and  CryLength should be greater than  HoleDepth. \n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.RadiationDetector",
    "page": "Physics_Module",
    "title": "GeoEfficiency.RadiationDetector",
    "category": "type",
    "text": "abstract super-supertype of all detectors types\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#GeoEfficiency.Detector",
    "page": "Physics_Module",
    "title": "GeoEfficiency.Detector",
    "category": "type",
    "text": "Detector\n\nabstract supertype of all detectors types of cylidericalish shapes. also can be used to construct any leaf type.\n\n\n\n\n\n"
},

{
    "location": "manual/Physics_Model.html#Physics_Module-1",
    "page": "Physics_Module",
    "title": "Physics_Module",
    "category": "section",
    "text": "GeoEfficiency.Point\r\nGeoEfficiency.source\r\nGeoEfficiency.CylDetector\r\nGeoEfficiency.BoreDetector\r\nGeoEfficiency.WellDetector\r\nGeoEfficiency.RadiationDetector\r\nGeoEfficiency.Detector"
},

{
    "location": "manual/Input_Batch.html#",
    "page": "Input_Batch",
    "title": "Input_Batch",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.typeofSrc",
    "page": "Input_Batch",
    "title": "GeoEfficiency.typeofSrc",
    "category": "function",
    "text": "typeofSrc()::SrcType\n\nreturn the current value of the global GeoEfficiency.srcType.\n\n\n\n\n\ntypeofSrc(x::Int)::SrcType\n\nset and return the value of the global GeoEfficiency.srcType corresponding to x.\n\nsrcUnknown = -1 also any negative integer treated as so, \nsrcPoint   = 0, \nsrcLine    = 1, \nsrcDisk    = 2, \nsrcVolume  = 3, \nsrcNotPoint = 4 also any greater than 4 integer treated as so.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.setSrcToPoint",
    "page": "Input_Batch",
    "title": "GeoEfficiency.setSrcToPoint",
    "category": "function",
    "text": "setSrcToPoint()::Bool\n\nreturn whether the source type is a point or not.\n\n\n\n\n\nsetSrcToPoint(yes::Bool)::Bool\n\nreturn whether the source type is a point or not after setting srcType to srcPoint if  yes = true else if yes = false setting it to srcNotPoint if it was not already  set to other non-point type (srcDisk, srcLine, srcVolume).\n\nnote: Note\nThe user can use this function to change the source type any time.\nThe source type is set the fist time asked for source.\n\nsee also: typeofSrc(::Int).\n\n\n\n\n\nsetSrcToPoint(prompt::AbstractString)::Bool\n\nreturn whether the source type is a point or not. only prompt the user to set the source  type if it were not already set before. \n\nsee also: typeofSrc(::Int), setSrcToPoint(::Bool).\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.detector_info_from_csvFile",
    "page": "Input_Batch",
    "title": "GeoEfficiency.detector_info_from_csvFile",
    "category": "function",
    "text": "UnExported\n\n detector_info_from_csvFile(detectors::AbstractString = Detectors, \n                                  datadir::AbstractString = dataDir)\n\nreturn a vector{Detector} based on information in the file of name detectors found in the  directory datadir.\n\nnote: Note\nif no path is given the second argument datadir is default to C:\\Users\\Mohamed\\GeoEfficiency as set by   the constant dataDir. \nif no file name is specified the name of the predefined file Detectors.csv as set by   the constant Detectors. \nthe no argument method is the most useful; other methods are mainly for test propose.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.read_from_csvFile",
    "page": "Input_Batch",
    "title": "GeoEfficiency.read_from_csvFile",
    "category": "function",
    "text": "UnExported\n\nread_from_csvFile(csv_data::AbstractString, \n                   datadir::AbstractString = dataDir)::Vector{Float64}\n\nreturn Vector{Float64} based on data in csv file named csv_data. directory datadir point to    where the file is located default to CUsersMohamedGeoEfficiency as set by the constant dataDir.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.read_batch_info",
    "page": "Input_Batch",
    "title": "GeoEfficiency.read_batch_info",
    "category": "function",
    "text": "UnExported\n\nread_batch_info()\n\nread detectors and sources parameters from the predefined csv files.\n\nReturn a tuple 	   (detectorsarray, 		srcHeightsarray, 		srcRhosarray, 		srcRadiiarray, 		srcLengthsarray, 		GeoEfficiencyisPoint)\n\n\n\n\n\nUnExported\n\nread_batch_info(datadir::AbstractString,\n              detectors::AbstractString, \n             srcHeights::AbstractString,\n                srcRhos::AbstractString,\n               srcRadii::AbstractString,\n             srcLengths::AbstractString)\n\nread detectors and sources parameters from the location given in the argument list.\n\nReturn a tuple\n\n   (detectors_array,\n	srcHeights_array,\n	srcRhos_array,\n	srcRadii_array,\n	srcLengths_array,\n	isPoint)\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#GeoEfficiency.getDetectors",
    "page": "Input_Batch",
    "title": "GeoEfficiency.getDetectors",
    "category": "function",
    "text": "getDetectors(detectors_array::Vector{<:Detector} = Detector[])::Vector{Detector}\n\nreturn the detectors_array as Vector{Detector} extended by the entered detectors and sorted according to the  detector volume.  prompt the user to input detector parameters from the console.\n\nnote: Note\nIf no array received in the input an empty array will be created to receive the converted detectors.\n\n\n\n\n\ngetDetectors(detector_info_array::Matrix{<:Real}, \n				 detectors_array::Vector{<:Detector} = Detector[]; \n				 						   console_FB=true)::Vector{Detector}\n\nreturn detectors_array as Vector{Detector}, after extending it with the successfully converted detectors. while,  attempt to convert detectors from the information in detector_info_array. \n\nnote: Note\nif console_FB argument is set to true , the function will call getDetectors() to take input from the console if the detector_info_array is empty or contain no numerical element.\n\n\n\n\n\n"
},

{
    "location": "manual/Input_Batch.html#Input_Batch-1",
    "page": "Input_Batch",
    "title": "Input_Batch",
    "category": "section",
    "text": "GeoEfficiency.typeofSrc\r\nGeoEfficiency.setSrcToPoint\r\nGeoEfficiency.detector_info_from_csvFile\r\nGeoEfficiency.read_from_csvFile\r\nGeoEfficiency.read_batch_info\r\nGeoEfficiency.getDetectors"
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
    "text": "geoEff(detector::Detector, aPnt::Point, SrcRadius::Real = 0.0, SrcLength::Real = 0.0)::Float64\n\nreturn the geometrical efficiency for a source (point, disk or cylinder) with  the detector detector.  detector can be any of the leaf detectors types (CylDetector, BoreDetector, WellDetector).\n\naPNT: a point represent the anchoring point of the source.\nSrcRadius: Radius of the source.\nsrcHeight:  the height of an upright cylinder source.\n\nThrow an Error if the source location is inappropriate.\n\nwarning: Warning\nthe point height of aPnt is measured differently for different detectors types. for the details, please refer to each detector entry.\n\nnote: Note\nif SrcLength equal to zero; the method return Geometrical Efficiency of a disc   source of Radius = SrcRadius and center at the point aPNT.\nif both SrcRadius and SrcLength equal to zero;   the method returns the Geometrical Efficiency of a point source at the anchoring point.\n\nExample\n\nto obtain the efficiency of a cylindrical detector of crystal radius 2.0 cm for axial    source cylinder of radius 1.0 cm and height 2.5 cm on the detector surface. \n\njulia> using GeoEfficiency\n\njulia> geoEff(CylDetector(2.0), Point(0.0), 1.0, 2.5)\n0.2923777934922748\n\nto obtain the efficiency for a bore-hole detector of crystal radius of 2.0 and height of 3.0 with    hole radius of 1.5 cm for axial source cylinder of radius 1.0 cm and height 2.5 cm starting from detector center.\n\njulia> using GeoEfficiency\n\njulia> newDet = BoreDetector(2.0, 3.0, 1.5);\n\njulia> geoEff(newDet, Point(0.0), 1.0, 2.5)\n0.5678174038944723\n\nto obtain the efficiency for a well-type detector of crystal radius of 2.0 cm and    height 3.0 cm with hole radius of 1.5 cm and depth of 1.0 cm for axial source cylinder of    radius 1.0 cm and height 2.5 cm at the hole surface.\n\njulia> using GeoEfficiency\n\njulia> newDet = WellDetector(2.0, 3.0, 1.5, 1.0);\n\njulia> geoEff(newDet, Point(0.0), 1.0, 2.5)\n0.4669614527701105\n\n\n\n\n\n"
},

{
    "location": "manual/Calculations.html#GeoEfficiency.GeoEff_Pnt",
    "page": "Calculations",
    "title": "GeoEfficiency.GeoEff_Pnt",
    "category": "function",
    "text": "unexported\n\nGeoEff_Pnt(detector::CylDetector, aPnt::Point)::Float64\n\nreturn the geometrical efficiency for the point source aPnt located on front of the cylindrical detector detector face.\n\nThrow an Error if the point is out of the cylindrical detector detector face.\n\nnote: Note\nthis is the base function that all other functions call directly or indirectly to calculate geometrical efficiency of the cylindrical-ish detector family.\n\n\n\n\n\n"
},

{
    "location": "manual/Calculations.html#GeoEfficiency.GeoEff_Disk",
    "page": "Calculations",
    "title": "GeoEfficiency.GeoEff_Disk",
    "category": "function",
    "text": "unexported\n\nGeoEff_Disk(detector::CylDetector, SurfacePnt::Point, SrcRadius::Real)::Float64\n\nreturn the geometrical efficiency for a disk source. The disk center is the SurfacePnt and  its radius is SrcRadius on front of the cylindrical detector detector face.\n\nproduce a warning if the disk is out of the cylindrical detector face.\n\n\n\n\n\n"
},

{
    "location": "manual/Calculations.html#Calculations-1",
    "page": "Calculations",
    "title": "Calculations",
    "category": "section",
    "text": "GeoEfficiency.geoEff\r\nGeoEfficiency.GeoEff_Pnt\r\nGeoEfficiency.GeoEff_Disk"
},

{
    "location": "manual/Output_Interface.html#",
    "page": "Output_Interface",
    "title": "Output_Interface",
    "category": "page",
    "text": ""
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.calc",
    "page": "Output_Interface",
    "title": "GeoEfficiency.calc",
    "category": "function",
    "text": "calc(detector::Detector = Detector(), aSource::Tuple{Point, Float64, Float64,} = source())\n\ncalculate and display on the console the geometrical efficiency of the  detector detector for the tuple aSource describing the source.\n\nThrow an Error if the source location is inappropriate.\n\nsee also: geoEff(::Detector, ::Tuple{Point, Float64, Float64})\n\nnote: Note\nif source description aSource alone or even both source description and detector detect   are missing, the method prompt the user to complete the missing data via the console.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.calcN",
    "page": "Output_Interface",
    "title": "GeoEfficiency.calcN",
    "category": "function",
    "text": "calcN()\n\ncalculate and display the geometrical efficiency repeatedly.  Prompt the user to input a detector and a source from the console. Prompt the user repeatedly until it exit (give a choice to use the same  detector or a new detector).\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.batch",
    "page": "Output_Interface",
    "title": "GeoEfficiency.batch",
    "category": "function",
    "text": "batch()\n\nprovide batch calculation of the geometrical efficiency based on the information provided  by the CSV files by default located in C:\\Users\\Mohamed\\GeoEfficiency.\n\nresults are saved on a CSV  file(s) named after the detector(s). the CSV  file(s)  by default found in C:\\Users\\Mohamed\\GeoEfficiency\\results, also a log of the results are displayed on the console.\n\nfor more information on batch refer to batchInfo.\n\n\n\n\n\nbatch(\n	detector::Detector,\n	srcHeights_array::Vector{S},\n	srcRhos_array::Vector{S}=[0.0],\n	srcRadii_array::Vector{S}=[0.0],\n	srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::String 	where S <: Real\n\nprovide batch calculation of the geometrical efficiency for the detector detector.  results are saved on a CSV  file named after the detector.  the CSV  file by default found in C:\\Users\\Mohamed\\GeoEfficiency\\results. this method return the actual  path to the CSV file.  also a log of the results are displayed on the console.\n\nsrcHeights_array: list of source heights to feed to batch.\nsrcRhos_array: list of source off-axis distances to feed to batch. \nsrcRadii_array: list of source radii to feed to batch.\nsrcLengths_array: list of source lengths to feed to batch.\n\nA set of sources is constructed of every valid combination of parameter in the srcRhos_array, srcRadii_array and srcLengths_array arrays with conjunction with ispoint.\n\nwarning: Warning\nIf ispoint is true the source type is a point source and the parameters   in srcRadii_array and srcLengths_array arrays is completely ignored.\nIf ispoint is false the parameters in srcRhos_array is completely ignored.\n\n\n\n\n\nbatch( \n	detectors_array::Vector{<: Detector},\n    srcHeights_array::Vector{S},\n    srcRhos_array::Vector{S}=[0.0],\n    srcRadii_array::Vector{S}=[0.0],\n    srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::Vector{String} where S <: Real\n\nsame as batch(::Detector, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool) but accept a list of detectors detectors_array. return a list of paths to the CSV of files (file for each detector) storing the results.\n\n\n\n\n\nbatch(\n	detector_info_array::Matrix{S},\n	srcHeights_array::Vector{S},\n	srcRhos_array::Vector{S}=[0.0],\n	srcRadii_array::Vector{S}=[0.0],\n	srcLengths_array::Vector{S}=[0.0],\n	ispoint::Bool=true\n	)::Vector{String} 	where S <: Real\n\nsame as batch(::Vector{Detector}, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool) but provide batch calculation of the  geometrical efficiency for the detector in the detector_info_array after applying getDetectors. return a list of paths to the CSV of files (file for each detector) storing the results.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.batchInfo",
    "page": "Output_Interface",
    "title": "GeoEfficiency.batchInfo",
    "category": "constant",
    "text": "The function batch() can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved   Values [CSV] files, that can be easily edit by Microsoft Excel,  by default located in the directory C:\\Users\\Mohamed\\GeoEfficiency .\n\nresults of batch calculation are saved on a CSV  file(s) named after the detector(s).  the CSV  file by default found in C:\\Users\\Mohamed\\GeoEfficiency\\results.\n\nCSV input files\n\nDetectors.csv contains the detectors description; The line format is: \n\n	 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |\n	 ---------------| ---------------|-------------|----------- |\n\nsrcHeights.csv contains the source heights; \n\n	 Source_Heights | \n	 ---------------|\n\nsrcRhos.csv contains the source off-axis distances; 	 				\n\n	 Source_Rhos | \n 	 ------------|\n\nsrcRadii.csv contains the source radii for disc and cylindrical sources; 			\n\n	 Source_Radii| \n	 ------------|\n\nsrcLengths.csv contains the source length for cylindrical sources; 	\n\n	 Source_Lengths| \n	 --------------|\n\nCSV results files\n\nCSV  file containing the results has columns of headers   AnchorHeight, AnchorRho, srcRadius, srcLength, GeoEfficiency for non-point sources   and columns of headers Height, Rho, GeoEfficiency for point sources.\n\nnote: Note\nfor Comma Saved Values [CSV] files each line represent an entry,   the first line is always treated as the header.\n\nwarning: Warning\nthe program expect each line to contain one number for all CSV files except  for Detectors.csv each line should contain at least one number or at   most four separated numbers.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.checkResultsDirs",
    "page": "Output_Interface",
    "title": "GeoEfficiency.checkResultsDirs",
    "category": "function",
    "text": "UnExported\n\ncheckResultsDirs()\n\nmake sure that directories for saving the results are already exist or create  them if necessary.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.writecsv_head",
    "page": "Output_Interface",
    "title": "GeoEfficiency.writecsv_head",
    "category": "function",
    "text": "unexported\n\nwritecsv_head(filename::AbstractString, content::VecOrMat{<:Union{Int,Float64}}, head=[])\n\nWrite content to the comma delimited values file filename.  optionally with header head.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency._max_batch",
    "page": "Output_Interface",
    "title": "GeoEfficiency._max_batch",
    "category": "constant",
    "text": "-ve value will display all batch results on\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency.max_batch",
    "page": "Output_Interface",
    "title": "GeoEfficiency.max_batch",
    "category": "function",
    "text": "max_batch(n<:Real)\n\nset the value of \'maxbatch\' which default to 20 which control the maxumam number of  entries per detector that permit the detector efficiency calculation to be displayed on console.  this function do not affect the saving of the batch calculation. \n\n-ve value of n result in displaying all batch calculation results on the console.\n\nsee also: max_batch()\n\n\n\n\n\nmax_batch()\n\nset the value of \'maxbatch\' to its default value.\n\nsee also: max_batch(::Integer)\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#GeoEfficiency._batch",
    "page": "Output_Interface",
    "title": "GeoEfficiency._batch",
    "category": "function",
    "text": "UnExported\n\n_batch(\n	::Val{true},\n	detector::Detector,\n	srcHeights_array::Vector{Float64},\n	srcRhos_array::Vector{Float64},\n	srcRadii_array::Vector{Float64},\n	srcLengths_array::Vector{Float64}\n	)\n\nbatch calculation for specialized for point sources.  return a tuple of three arrays the detector, the resultsand the path of the CSV  file containing results. \n\nThe results has columns of headers Height, Rho, GeoEfficiency.\n\nnote: Note\nfor all arrays srcHeights_array, srcRhos_array, srcRadii_array and srcLengths_array   element type should be Float64. if any of them have other numerical element type it   should converted to Float64 using float before passing it to this method.\n\nwarning: Warning\nboth srcRadii_array, srcLengths_array are completely ignored as this method is for point sources.\n\n\n\n\n\nUnExported\n\n_batch(\n	::Val{false},\n	detector::Detector,\n	srcHeights_array::Vector{Float64},\n	srcRhos_array::Vector{Float64},\n	srcRadii_array::Vector{Float64},\n	srcLengths_array::Vector{Float64},\n	)\n\nbatch calculation for specialized for non-point sources.  return a tuple of three arrays the detector, the resultsand the path of the CSV  file containing results. \n\nThe results has columns of headers  AnchorHeight, AnchorRho, srcRadius, srcLength, GeoEfficiency.\n\nnote: Note\nfor all arrays srcHeights_array, srcRhos_array, srcRadii_array and srcLengths_array  element type should be Float64. if any of them have other numerical element type it  should converted to Float64 using float before passing it to this method.\n\n\n\n\n\n"
},

{
    "location": "manual/Output_Interface.html#Output_Interface-1",
    "page": "Output_Interface",
    "title": "Output_Interface",
    "category": "section",
    "text": "GeoEfficiency.calc\r\nGeoEfficiency.calcN\r\nGeoEfficiency.batch\r\nGeoEfficiency.batchInfo\r\nGeoEfficiency.checkResultsDirs\r\nGeoEfficiency.writecsv_head\r\nGeoEfficiency._max_batch\r\nGeoEfficiency.max_batch\r\nGeoEfficiency._batch"
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

]}
