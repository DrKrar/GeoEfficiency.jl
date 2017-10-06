#**************************************************************************************
# Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
#
# all the input either from the console or from the csv files to the package is handled by some function here.
#
#**************************************************************************************

#------------------consts&globals--------------------------------------
using Compat
using Compat.MathConstants
if !isdefined(Base, :readdlm)
	import DelimitedFiles: readdlm, writedlm
end

@compat isconst(@__MODULE__, :datafolder ) || const datafolder = string(@__MODULE__)
const datadir    = joinpath(homedir(), datafolder); 	isdir(datadir) || mkdir(datadir)

const detectors  = "Detectors.csv";
const srcHeights = "srcHeights.csv";
const srcRhos    = "srcRhos.csv";
const srcRadii   = "srcRadii.csv";
const srcLengths = "srcLengths.csv";

@enum SrcType srcUnknown=-1 srcPoint=0 srcLine=1 srcDisk=2 srcVolume=3 srcNotPoint =4
global srcType = srcUnknown

#------------------typeofSrc--------------------------------------
"""
    typeofSrc()

Return the current value of `srcType`.

"""
typeofSrc() = srcType  # srcType !== SrcType, but

"""
    typeofSrc(x::Int)

set and return the value of `srcType` crosponding to `x`.

  * srcUnknown = -1 and any negative integer treateted as so, 
  *  srcPoint = 0, 
  *  srcLine = 1, 
  *  srcDisk = 2, 
  *  srcVolume = 3, 
  *  srcNotPoint = 4 and any greater than 4 integer treateted as so.

"""
function typeofSrc(x::Int)
	global srcType = if x < 0
					SrcType(-1)
				elseif x  > 4
					SrcType(4)
				else
					SrcType(x)
				end
end #fnuction

#------------------setSrcToPoint--------------------------------------

"""
    setSrcToPoint() 

Return whether the source type is point or not.
"""
setSrcToPoint() = srcType === srcPoint

"""

    setSrcToPoint(yes::Bool)

set the source type to Point if `yes = true` else if  `yes = false` set the source type to non-point. However,if it was not already set to other non point type before.

!!! note

    * The user can use this function to change the type latter or set it before calculation.
	
	* The source type is set when the fist time asked for source.

"""
function setSrcToPoint(yes::Bool) ::Bool
	global srcType = if yes 
						srcPoint
					elseif srcType in [srcUnknown, srcPoint] 
						srcNotPoint
					else
						srcType 
					end
	return srcType === srcPoint
end

"""
    setSrcToPoint(prompt::AbstractString)	
prompt the user to set the sources type if it were not already set before. 
"""
setSrcToPoint(prompt::AbstractString) = srcType != srcUnknown ?	setSrcToPoint() :
											setSrcToPoint(input(prompt) |> lowercase != "n" )


#------------------input-----------------------------------------------

""" # UnExported

    input(prompt::AbstractString = "? ", incolor::Symbol = :green)

Prompt the user with the massage `prompt` defaults to `? `. `incolor` specify the prompt text color, default to green.
Return a string delimited by new line excluding the new line.
# Examples
```jldoctest
julia> input("input a number:")
input a number:
```

"""
function input(prompt::AbstractString = "? ", incolor::Symbol = :green)
    print_with_color(incolor, prompt); chomp(readline())
end # function


#-------------------_getfloat & getfloat----------------------------------------------

"""

	getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf; value::AbstractString="nothing")

Prompts the user with the massage `prompt` defaults to `? ` to input a numserical expression evaluate to a numerical value and asserts that the value is in the semi open interval [`from`, `to`[.

 > input from the `console` can be numerical expression not just a number.
 > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
 > All are valid expressions.

!!! note
    *  a blank (just a return) input is considered as being `0.0`.
    *  the key wordd  argument `value` , if provided the function willnot ask for input from the `console`and take it ass the input from the  `console`.

# Examples
```jldoctest
julia> getfloat("input a number:",value="3")
3.0
julia> getfloat("input a number:",value="")
0.0
julia> getfloat("input a number:",value="5/2")
2.5
julia> getfloat("input a number:",value="5//2")
2.5
julia> getfloat("input a number:",value="e")
2.718281828459045

```

"""
function getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf; value::AbstractString="nothing") ::Float64
	try
		"nothing" == value ? value = input(prompt) : nothing
		"" == value && return 0.0		# just pressing return is interapted as <0.0>
		val::Float64 =  parse(value) |> eval |> float
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
end	


#--------------------detector_info_from_csvFile--------------------------------------

"""# UnExported

	 detector_info_from_csvFile(detectors::AbstractString=detectors, 
                                      datadir::AbstractString=datadir)

read detectors data from predefined file and return its content as an array of detectors, or one can specifif a file.

`datadir` : directory where file is located default to $(datadir) if no argument is provided.

"""
function detector_info_from_csvFile(detectors::AbstractString=detectors, 
                                      datadir::AbstractString=datadir)
    detector_info_array::Matrix{Float64} = Matrix{Float64}(0,0)
    info("opening '$(detectors)'......")
    try
        detector_info_array = readdlm(joinpath(datadir, detectors), ',', header=true)[1];
        return getDetectors(detector_info_array)
		
    catch err
        if isa(err, SystemError) 
		    warn("detector_info_from_csvFile: Some thing went wrong, may be the file '$(joinpath( datadir, detectors))' can't be found")
		end
        rethrow()

    end #try

end #function


#--------------------read_from_csvFile--------------------------------------

"""# UnExported

	read_from_csvFile(csv_data::AbstractString, 
                       datadir::AbstractString=datadir)

read data from a file and return its content as an array.
`csv_data`: filename of csv file containing data.
`datadir` : directory where file is located default to $(datadir) if no argument is provided.

"""
function read_from_csvFile(csv_data::AbstractString, datadir::AbstractString=datadir)
	info("Opening `$(csv_data)`......")
	try
		indata = readdlm(joinpath(datadir, csv_data), ',',  header=true)[1][:,1]
		return float(indata ) |> sort;

	catch err
	    if isa(err, SystemError) 
		    warn("Some thing went wrong, may be `$(csv_data)` can't be found in `$(datadir)`")
		
		else
		    #println(err)
		
		end		
		return Float64[0.0]

	end #try
end #function


#--------------------read_batch_info---------------------------------------------

"""# UnExported

	read_batch_info()

read `detectors` and `sources` parameters from the predefined csv files.

Return a tuple

	   (detectors_array,
		srcHeights_array,
		srcRhos_array,
		srcRadii_array,
		srcLengths_array,
		GeoEfficiency_isPoint)

"""
read_batch_info() = read_batch_info(datadir,
                                  detectors, 
								 srcHeights,
								    srcRhos,
								   srcRadii,
								 srcLengths)


"""# UnExported

	read_batch_info(datadir::AbstractString,
                  detectors::AbstractString, 
			     srcHeights::AbstractString,
			        srcRhos::AbstractString,
				   srcRadii::AbstractString,
			     srcLengths::AbstractString)

read `detectors` and `sources` parameters from the location given in the argument list.

Return a tuple

	   (detectors_array,
		srcHeights_array,
		srcRhos_array,
		srcRadii_array,
		srcLengths_array,
		isPoint)

"""								 
function read_batch_info(datadir::AbstractString,
                       detectors::AbstractString, 
					  srcHeights::AbstractString,
					     srcRhos::AbstractString,
					    srcRadii::AbstractString,
					  srcLengths::AbstractString)

	info("The Batch Mode is Starting....")
	isPoint = setSrcToPoint("\n Is it a point source {Y|n} ?")

	info("Read data from `CSV files` at $datadir .....")
	detectors_array ::Vector{RadiationDetector} = try  detector_info_from_csvFile(detectors, datadir); catch err; getDetectors(); end
	srcHeights_array::Vector{Float64} = read_from_csvFile(srcHeights, datadir)
	srcRhos_array   ::Vector{Float64} = [0.0]
	srcRadii_array  ::Vector{Float64} = [0.0]
	srcLengths_array::Vector{Float64} = [0.0]

	function batchfailure(err::AbstractString)
		warn(err, ", transfer to direct data input via the `console`......")
		sleep(3); src = source()
		srcHeights_array, srcRhos_array, srcRadii_array  , srcLengths_array   = 
		[src[1].Height] , [src[1].Rho] , [src[2]]        , [src[3]]
		nothing
	end #fumction

	if srcHeights_array == [0.0]
		batchfailure("`$(srcHeights)` is not found in `$(datadir)`)")

	elseif isPoint
		srcRhos_array =	read_from_csvFile(srcRhos, datadir)

	else
		srcRadii_array = read_from_csvFile(srcRadii, datadir)
		if srcRadii_array == [0.0]
			batchfailure("`$(srcRadii)` is not found in `$(datadir)`)")

		else
			srcLengths_array = read_from_csvFile(srcLengths, datadir)

		end #if
	end #if
	#println("\n Results log\n=============")
	return (
		detectors_array,
		srcHeights_array,
		srcRhos_array,
		srcRadii_array,
		srcLengths_array,
		isPoint,
		)
end #fumction


#---------------- getDetectors-------------------------------------------------

"""

    getDetectors(detectors_array::Vector{<:Detector} = Detector[])

prompt the user to input detector parameters from the `console`.
Return a `Vector{Detector}` contains the detectors in `detectors_array` extended by the entered detectors and sorted according to the detector volume. 
If no array received in the input an empty array will be created to receive the entered detectors.

"""
function getDetectors(detectors_array::Vector{<:RadiationDetector} = RadiationDetector[])
	Vector{RadiationDetector}(detectors_array); info("Please, input the detector information via the console")
	while(true)
		try push!(detectors_array, RadiationDetector()); catch err	println(err); warn("Please: Enter a New Detector"); continue; end
		lowercase(input(
			"""\n
    	                - To add a new detector press return\n
    	                - To quit press 'q'|'Q' then return\n
			\n\t your Choice: """, :blue))  == "q" && break
	end #while
	return detectors_array |> sort
end #function


"""

	getDetectors(detector_info_array::Matrix{<:Real}, detectors_array::Vector{<:Detector} = Detector[] ;console_FB=true) 

Convert detectors from the information in `detector_info_array` and return `detectors_array`, an Array of successfully converted detectors.

`console_FB`: if true , the function will will call `getDetectors()` to take input from the `console` if the `detector_info_array` 
is empty or contain no numerical element.

"""
function getDetectors(detector_info_array::Matrix{<:Real}, detectors_array::Vector{<:Detector} = Detector[] ; console_FB=true) 
	
	if isempty(detector_info_array) 
		if console_FB 
			info("The new detectors information may entred via the console")
			return getDetectors(detectors_array)
		else	
		 	error("getDetectors: Empty `detector_info_array`")
		end
		
	else
		Vector{RadiationDetector}(detectors_array)
		for i_th_line = 1:size(detector_info_array)[1]
			try push!(detectors_array, RadiationDetector((detector_info_array[i_th_line,:])...)) end #try
		end #for

		return detectors_array |> sort
	end   #if
end #function
