#**************************************************************************************
# Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
#
# all the input either from the console or from the csv files to the package is handled by some function here.
#
#**************************************************************************************

const datafolder = "GeoEfficiency"
const datadir    = joinpath(homedir(), datafolder); 	isdir(datadir) || mkdir(datadir)

const detectors  = "Detectors.csv";
const srcHeights = "srcHeights.csv";
const srcRhos    = "srcRhos.csv";
const srcRadii   = "srcRadii.csv";
const srcLengths = "srcLengths.csv";

#-----------------------------------------------------------------

"""
    input(prompt::AbstractString = "? ", incolor::Symbol = :green)

Prompt the user with the massage `prompt` defaults to `? `. `incolor` specify the prompt text color, default to green.
Return a string delimited by new line excluding the new line.
# Example
```jldoctest
julia> input("input a number:")
input a number:
```
"""
function input(prompt::AbstractString = "? ", incolor::Symbol = :green)
    print_with_color(incolor, prompt)
    chomp(readline())
end # function

#-----------------------------------------------------------------

"""
	getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf)

Prompts the user with the massage `prompt` defaults to `? ` to input a numserical expression evaluate to a numerical value and asserts that the value is in the semi open interval [`from`, `to`[.

 > input from the `console` can be numerical expression not just a number.
 > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
 > All are valid expressions.

# Note Please
\n- a blank (just a return) input is interpreted as being `0.0`.

# Example
```jldoctest
julia> getfloat("input a number:")
input a number:
```
"""
function getfloat(prompt::AbstractString = "? ",
		    from::Real = 0.0,
            to::Real = Inf)

    value = input(prompt)
    "" == value && return 0.0		# just pressing return is interapted as <0.0>
    val::Float64 = 0.0
	
	try
        val = include_string(value) |> float
        @assert from <= val < to
        return val
    
	catch err
        if isa(err, AssertionError) 
            warn("provid a number in the semi open interval [$from, $to[.")
        else   
	        warn("provid a valid numerical value!")
        end #if 
        return getfloat(prompt, from, to)

    end #try

end	#function

#-----------------------------------------------------------------

"""
	 read_from_csvFile()

read detectors data from predefined file and return its content as an array of detectors.
"""
function read_from_csvFile()
    detector_info_array::Matrix{Float64} = Matrix{Float64}(0,0)
    info("opening '$(detectors)'......")
    try
        detector_info_array = readcsv(joinpath(datadir, detectors),  header=true)[1];
        return getDetectors(detector_info_array)
		
    catch err
        warn("some thing went wrong, may be '$(detectors)' can't be found in '$(datadir)'")
        return getDetectors()

    end #try

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
        warn("some thing went wrong, may be `$(csv_data)` can't be found in `$(datadir)`")
		return Float64[0.0]

	end #try
end #function


"""
	read_batch_info()

read `detectors` and `sources` parameters from the predefined csv files.
Return a tuple

	   (detectors_array,
		srcHeights_array,
		srcRhos_array,
		srcRadii_array,
		srcLengths_array,
		ispoint	)
"""
function read_batch_info()

	info("Starting the batch mode.....")
	ispoint::Bool = input("\n Is it a point source {Y|n} ? ") |> lowercase != "n"

	info("Read data from CSV files at $datadir .....")
	detectors_array ::Vector{RadiationDetector} = read_from_csvFile() |> sort
	srcHeights_array::Vector{Float64}           = read_from_csvFile(srcHeights) |> sort
	srcRhos_array   ::Vector{Float64} = [0.0]
	srcRadii_array  ::Vector{Float64} = [0.0]
	srcLengths_array::Vector{Float64} = [0.0]

	function batchfailure()
		info("\t----<( Press return: to treminated batch mode )>----"); 
		input("is that ok")
		src = source(isPoint=ispoint)
		srcHeights_array, srcRhos_array    = [src[1].Height], [src[1].Rho]
		srcRadii_array  , srcLengths_array = [src[2]]       , [src[3]]
		nothing
	end #fumction

  if srcHeights_array == [0.0]
			batchfailure()

	elseif ispoint
		#srcRadii_array  = [0.0]
		#srcLengths_array  = [0.0]
		srcRhos_array =	read_from_csvFile(srcRhos) |> sort

	else
		#srcRhos_array = [0.0]
		srcRadii_array = read_from_csvFile(srcRadii) |> sort
		if srcRadii_array == [0.0]
			batchfailure()

		else
			srcLengths_array = read_from_csvFile(srcLengths) |> sort

		end #if
	end #if
	println("\n Results log\n=============")
	return (
		detectors_array,
		srcHeights_array,
		srcRhos_array,
		srcRadii_array,
		srcLengths_array,
		ispoint
		)
end #fumction

#-----------------------------------------------------------------

"""
    getDetectors()

prompt the user to input detector parameters from the `console`.
Return `detectors_array` an Array of the entered detectors.
"""
function getDetectors()
	detectors_array::Vector{RadiationDetector} = RadiationDetector[]
	info("----<( Press return: to provid detector specifiction from the console )>----");
	input("is that ok")
	while(true)
		try
			push!(detectors_array, RadiationDetector())

		catch
			break

		end #try

		res = input(
			"""\n
    	                - To add a new detector press return\n
    	                - To quit press 'q'|'Q' then return\n
			\n\t your Choice: """, :blue) |> lowercase;
		res == "q" && break

	end #while
	return detectors_array
end #function


"""
	getDetectors(detector_info_array::Array{Float64,2})

Convert detectors from the information in `detector_info_array` and return `detectors_array` an Array of successfully 
converted detectors. If the `detector_info_array` is empty it will call `getDetectors()`.
"""
function getDetectors(detector_info_array::Matrix{Float64})
	isempty(detector_info_array) && return getDetectors()
	detectors_array::Vector{RadiationDetector} = RadiationDetector[]
	for i_th_line = 1:size(detector_info_array)[1]
		try
			push!(detectors_array, RadiationDetector((detector_info_array[i_th_line,:])...))

		catch err
			continue

		end #try
	end #for

	return detectors_array
end #function
