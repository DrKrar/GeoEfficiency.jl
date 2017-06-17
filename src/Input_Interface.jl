#**************************************************************************************
# Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
#
# all the input either from the console or from the csv files to the package is handled by some function here.
#
#**************************************************************************************

isconst(:datafolder ) || const datafolder = "GeoEfficiency"
const datadir    = joinpath(homedir(), datafolder); 	isdir(datadir) || mkdir(datadir)

const detectors  = "Detectors.csv";
const srcHeights = "srcHeights.csv";
const srcRhos    = "srcRhos.csv";
const srcRadii   = "srcRadii.csv";
const srcLengths = "srcLengths.csv";
global srcType = -1 # -1 for undefined, 0 for point source, 1 for non-point source


#------------------SetSrcToPoint--------------------------------------

"""
    setSrcToPoint(yes::Bool)

globally set the sources to be considered as point(s) or not. 

 ! Note
 
the source type is set automatically the fist time asked for source. this funtion can be used to change the type latter or set it from the begining.

"""
function setSrcToPoint(yes::Bool) ::Bool
    global srcType = ifelse(yes, 0, 1)
	return yes
end

"""
    SetSrcToPoint(prompt::AbstractString)	

see if the source type is not set it set it to point else it leave it intact. 

 !Note
 The source type is set automatically the fist time asked for source.

"""
function SetSrcToPoint(prompt::AbstractString)	
	global srcType 
	if srcType == -1
	    setSrcToPoint(input(prompt) |> lowercase != "n")
	end				  
	return srcType == 0				  
end

"""
    setSrcToPoint()

see if the source type is not set it set it to point else it leave it intact. 

 ! Note
 The source type is set automatically the fist time asked for source.

"""
function setSrcToPoint()
	global  srcType 
	if srcType == -1
	    setSrcToPoint(false)
	end				  
	return srcType == 0		
end


#------------------input-----------------------------------------------

""""# UnExported

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


#-------------------getfloat----------------------------------------------

"""

	getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf; value::AbstractString="nothing")

Prompts the user with the massage `prompt` defaults to `? ` to input a numserical expression evaluate to a numerical value and asserts that the value is in the semi open interval [`from`, `to`[.

 > input from the `console` can be numerical expression not just a number.
 > 5/2, 5//2, pi, e, 1E-2, 5.2/3, sin(1), pi/2/3
 > All are valid expressions.

# Note Please
 *  a blank (just a return) input is considered as being `0.0`.
 *  the key wordd  argument `value` , if provided the function willnot ask for input from the `console`and take it ass the input from the  `console`.

# Example
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

    "nothing" == value ? value = input(prompt) : nothing
    "" == value && return 0.0		# just pressing return is interapted as <0.0>
    val::Float64 = 0.0
	try
        val =  parse(value) |> eval |> float
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
        detector_info_array = readcsv(joinpath(datadir, detectors),  header=true)[1];
        return getDetectors(detector_info_array)
		
    catch err
        if isa(err, SystemError) 
		    warn("detector_info_from_csvFile: Some thing went wrong, may be the file '$(joinpath( datadir, detectors))' can't be found")
		else
		    println(err)
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
		return readcsv(joinpath(datadir, csv_data),  header=true)[1][:,1] |>float |> sort;

	catch err
	    if isa(err, SystemError) 
		    warn("Some thing went wrong, may be `$(csv_data)` can't be found in `$(datadir)`")
		else
		    println(err)
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
	isPoint = SetSrcToPoint("\n Is it a point source {Y|n} ? ")				  

	info("Read data from CSV files at $datadir .....")
	detectors_array ::Vector{RadiationDetector} = try  detector_info_from_csvFile(detectors, datadir) 
		catch 
			getDetectors() 
		end
	
	srcHeights_array::Vector{Float64}           = read_from_csvFile(srcHeights, datadir)
	srcRhos_array   ::Vector{Float64} = [0.0]
	srcRadii_array  ::Vector{Float64} = [0.0]
	srcLengths_array::Vector{Float64} = [0.0]

	function batchfailure(err::AbstractString)
		warn("\n\t", err, ", the batch mode is treminating.......\n"); 
		info("transfer to direct data input via the `console`......")
		src = source()
		srcHeights_array, srcRhos_array    = [src[1].Height], [src[1].Rho]
		srcRadii_array  , srcLengths_array = [src[2]]       , [src[3]]
		nothing
	end #fumction

  if srcHeights_array == [0.0]
			batchfailure("`$(srcHeights)` is not found in `$(datadir)`)")

	elseif isPoint
		#srcRadii_array  = [0.0]
		#srcLengths_array  = [0.0]
		srcRhos_array =	read_from_csvFile(srcRhos, datadir)

	else
		#srcRhos_array = [0.0]
		srcRadii_array = read_from_csvFile(srcRadii, datadir)
		if srcRadii_array == [0.0]
			batchfailure("`$(srcRadii)` is not found in `$(datadir)`)")

		else
			srcLengths_array = read_from_csvFile(srcLengths, datadir)

		end #if
	end #if
	println("\n Results log\n=============")
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

    getDetectors()

prompt the user to input detector parameters from the `console`.
Return `detectors_array` an Array of the entered detectors.

"""
function getDetectors()
	detectors_array::Vector{RadiationDetector} = RadiationDetector[]
	info("Please, input the detector information via the console")
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
	return detectors_array |> sort
end #function


"""

	getDetectors(detector_info_array::Matrix{S}, console_FB=true) where S <: Real

Convert detectors from the information in `detector_info_array` and return `detectors_array`, an Array of successfully 
converted detectors.

`console_FB`: if true , the function will will call `getDetectors()` to take input from the `console` if the `detector_info_array` 
is empty or contain no numerical element.

"""
function getDetectors(detector_info_array::Matrix{S}, console_FB=true) where S <: Real
	
	if isempty(detector_info_array) 
		if console_FB 
			info("The detector information may entred via the console")
			return getDetectors()
		else	
		 	error("getDetectors: Empty `detector_info_array`")
		end
		
	else	
		detectors_array::Vector{RadiationDetector} = RadiationDetector[]
		for i_th_line = 1:size(detector_info_array)[1]
			try push!(detectors_array, RadiationDetector((detector_info_array[i_th_line,:])...)) end #try
		end #for

		return detectors_array |> sort
	end   #if
end #function
