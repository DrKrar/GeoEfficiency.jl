#**************************************************************************************
# Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# all the input either from the console or from the csv files to the package is handled by some function here. 
# 
#**************************************************************************************

const datafolder = "GeoEfficiency"
const datadir = joinpath(homedir(), datafolder); 			isdir(datadir) || mkdir(datadir)

const Detectors = "Detectors.csv";
const srcHeights = "srcHeights.csv";	
const srcRhos = "srcRhos.csv";			
const srcRadii = "srcRadii.csv";		
const srcLengths = "srcLengths.csv";	



"""
	input(prompt::AbstractString = "? ")
Prompt the user with the massage `prompt` defaults to `? `.
Return a string delimited by new line excluding the new line.
# Example
```jldoctest
julia> input
```
"""
function input(prompt::AbstractString = "? ", incolor::Symbol = :green)
    print_with_color(incolor, prompt)
    chomp(readline())
end # function


"""
	getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf)
	
Prompts the user with the massage `prompt` defaults to `? ` to input a numserical expression evaluate to a numerical value and asserts that the value is in the semi open interval [`from`, `to`[.

 > input from the `console` can be numerical expression not just a number.
 >Example:-
 > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
 > All are valid expressions.
 
`Note Please`
\n- a blank (just a return) input is interpreted as being `0.0`.
"""
function getfloat(prompt::AbstractString = "? ",
					from::Real = 0.0,
                    to::Real = Inf)
    value = input(prompt)
	"" == value	&&	return 0.0		# just pressing return is interapted as <0.0>
    try
        val = include_string(value)
		val = float(val)
        @assert from <= val < to 
        return val
    
	catch err
		isa(err, AssertionError) ? 	
			info("provid a number in the semi open interval [$from, $to[.")	: begin
			info("provid a valid numerical value!")
		end #begin
        return getfloat(prompt, from, to)
		
    end #try
end	#function


"""

	read_from_csvFile()
	
read detectors data from predefined file and return its content as an array of detectors. 
"""
function read_from_csvFile()
	Detector_info_array::Array{Float64,2} = Array(Float64,(0,0))
	println("INFO: opening '$(Detectors)'......")
	try
		Detector_info_array = readcsv(joinpath(datadir, Detectors),  header=true)[1];
	
	catch err
		warn("'$(Detectors)' can't be found in '$(datadir)'")
		return getDetectors()
	
	
	end #try
	return getDetectors(Detector_info_array)
	
end #function

"""

	read_from_csvFile(csv_data::AbstractString)
	
read data from a file and return its content as an array. 
`csv_data`: filename of csv file containing data.
"""
function read_from_csvFile(csv_data::AbstractString)
	info("Opening `$(csv_data)`......")
	try
		return readcsv(joinpath(datadir, csv_data),  header=true)[1][:,1];
	
	catch err
		warn("`$(csv_data)` can't be found in `$(datadir)`")
		return Float64[0.0]
	
	end #try
end #function


"""

	read_batch_info()
	
read `detectors` and `sources` parameters from the predefined csv files.
Return a tuple

	(	Detectors_array, 
		srcHeights_array, 
		srcRhos_array, 
		srcRadii_array,
		srcLengths_array,
		ispoint
		)
"""
function read_batch_info()
	
	info("Starting the batch mode .....")
	ispoint = input("\n Is it a point source {Y|n} ? ") |> lowercase != "n"

	function batchfailure()
		input("\t----<( Press return: to treminated batch mode )>----", :blue)
		src = source(isPoint=ispoint)
		srcHeights_array, srcRhos_array = [src[1].Height], [src[1].Rho] 
		srcRadii_array, srcLengths_array = [src[2]],[src[3]]
		nothing
	end
	
	Detectors_array::Array{RadiationDetector,1} = read_from_csvFile()
	srcHeights_array::Array{Float64,1} =  read_from_csvFile(srcHeights) |> sort
	srcRhos_array::Array{Float64,1}
	srcRadii_array::Array{Float64,1}
	srcLengths_array ::Array{Float64,1}

	
	if srcHeights_array == [0.0]
			batchfailure()
	
	elseif ispoint 
		srcRadii_array  = [0.0]
		srcLengths_array  = [0.0]
		srcRhos_array =	read_from_csvFile(srcRhos) |> sort

	else	
		srcRhos_array = [0.0]
		srcRadii_array	 = 	read_from_csvFile(srcRadii) |> sort
		if srcRadii_array == [0.0] 
			batchfailure()
		
		else
			srcLengths_array = 	read_from_csvFile(srcLengths) |> sort
		
		end #if
	end #if
	println("\n Results log\n=============")
	return (
		Detectors_array, 
		srcHeights_array, 
		srcRhos_array, 
		srcRadii_array,
		srcLengths_array,
		ispoint
		)
end #fumction


"""

	getDetectors()

prompt the user to input detector parameters from the `console`.
Return `Detectors_array` an Array of the entered detectors.  
"""
function getDetectors()
	Detectors_array = RadiationDetector[]
	input("----<( Press return: to provid detector specifiction from the console )>----", :blue);
	while(true)
		try
			push!(Detectors_array, detectorFactory())
			
		catch
			break
			
		end #try
		
		res = input("""\n
    	- To add a new detector press return\n
    	- To quit press 'q'|'Q' then return\n
			\n\tyour Choice: """, :blue) |> lowercase; 
		res == "q" && break 
	
	end #while
	return Detectors_array
end #function


"""

	getDetectors(Detector_info_array::Array{Float64,2})

convert detectors from the information in `Detector_info_array` and return `Detectors_array` an Array of successfully converted detectors. If the `Detector_info_array` is empty it will call `getDetectors()`.
"""
function getDetectors(Detector_info_array::Array{Float64,2})
	isempty(Detector_info_array) && return getDetectors()
	Detectors_array::Array{RadiationDetector,1} = RadiationDetector[]	
	for i_th_line = 1:size(Detector_info_array)[1]
		try
			push!(Detectors_array, 
					detectorFactory((Detector_info_array[i_th_line,:])...))
			
		catch err
			continue
		
		end #try		
	end #for

	return Detectors_array
end #function
