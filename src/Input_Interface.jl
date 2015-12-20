#**************************************************************************************
# Input_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# all the input either from the console or from the csv files to the package is handled by some function here. 
# 
#**************************************************************************************

const datafolder = ".batch"; 			isdir(datafolder) || mkdir(datafolder)

const Detectors = "Detectors.csv";		
const srcHeights = "srcHeights.csv";	
const srcRhos = "srcRhos.csv";			
const srcRadii = "srcRadii.csv";		
const srcLengths = "srcLengths.csv";	


"""

	input(prompt::AbstractString = "? ")

Prompt the user with the massage 'prompt' defaults to '? '
return a string delimited by new line exclusive.
"""
function input(prompt::AbstractString = "? ")
    print_with_color(:green, prompt)
    chomp(readline())
end


"""

	getfloat(prompt::AbstractString = "? ", from::Real = 0.0, to::Real = Inf)

Prompts the user with the massage "prompt" defaults to "? "
to input a value and asserts that the value is numeric value in the semi open interval [from, to[
\nNote
\n*****
\n\t- a blank input is interpreted as being 0.0.
"""
function getfloat(prompt::AbstractString = "? ",
					from::Real = 0.0,
                    to::Real = Inf)
    value = input(prompt)
    try
        val = float(value)
        @assert from <= val < to 
        return val
    
	catch err
        if isa(err, ArgumentError)
			if   "" == value
				return 0.0			# just pressing return is interapted as <0.0>
			
			end #if
            print_with_color(:white, "Please, Input a valid Numerical Value!")
        
		elseif isa(err, AssertionError)
		    print_with_color(:white,"Please, Input a number in the semi open interval [$from, $to[ !")
		
		else 
			rethrow()
		
		end #if
        return getfloat(prompt,from, to)
    end #try
end	#function


"""

	read_from_csvFile(csv_data::AbstractString)
	
read data from a file and return it as an array. 
csv_data: filename of csv file containing data.
"""
function read_from_csvFile(csv_data::AbstractString)
	try
		return readcsv(".\\$(datafolder)\\$(csv_data)",  header=true)[1];
	
	catch err
		input("file '$(csv_data)' is not exist or empty, press return to Exit batch mode\n")
		return []
	
	end #try
end #function


"""

	read_batch_info()
	
read detectors and sources parameters from predefined csv files.
"""
function read_batch_info()
	print_with_color(:white, "\n****** The batch mode of the program is starting ******\n")
	print_with_color(:white, "******************************************************\n")
	ispoint = input("\n Is it a point source {Y:N} ? ") |> lowercase != "n" ? true : false

	Detectors_array::Union{Array{GammaDetector,1}, Array{Float64,2}}
	srcHeights_array::Array{Float64,1}
	srcRhos_array::Array{Float64,1}
	srcRadii_array::Array{Float64,1}
	srcLengths_array ::Array{Float64,1}
	 
	Detectors_array  = 	isfile(datafolder*"\\"*Detectors)	? read_from_csvFile(Detectors) : (warn("$Detectors: can not be found\n\n"); GammaDetector[] )
	if Detectors_array == []  #[] 		# if  'Detectors.csv' has no detector or not fund ask the user to provid a detector.
		Detectors_array = getDetectors() #[DetectorFactory()]
	end #if
	
	srcHeights_array = 	isfile(datafolder*"\\"*srcHeights)  ? read_from_csvFile(srcHeights)[:,1]: (warn("$srcHeights: can not be found\n\n"); Float64[])
	if srcHeights_array == []
		print_with_color(:white,"\t----<( Press return: to treminated batch mode )>----\n"); readline()
		src = source(isPoint=ispoint)
		srcHeights_array, srcRhos_array = [src[1].Height], [src[1].Rho] 
		srcRadii_array, srcLengths_array = [src[2]],[src[3]]	
	
	elseif ispoint #srcRhos_array != []	
		srcRadii_array  = [0.0]
		srcLengths_array  = [0.0]
		srcRhos_array =	isfile(datafolder*"\\"*srcRhos)	? read_from_csvFile(srcRhos)[:,1] :	(warn("$srcRhos: can not be found\n\n"); Float64[])
		if srcRhos_array == []	
			srcRhos_array = [0.0]
		end #if
		
	elseif srcRadii_array == [] || srcLengths_array == []
		print_with_color(:white,"\t----<( Press return: to treminated batch mode )>----\n"); readline()
		src = source()
		srcHeights_array, srcRhos_array = [src[1].Height], [src[1].Rho] 
		srcRadii_array, srcLengths_array = [src[2]],[src[3]]

	else	
		srcRhos_array = [0.0]
		srcRadii_array	 = 	isfile(datafolder*"\\"*srcRadii) 	? read_from_csvFile(srcRadii)[:,1] : (warn("$srcRadii: can not be found\n\n"); Float64[])	
		srcLengths_array = 	isfile(datafolder*"\\"*srcLengths)	? read_from_csvFile(srcLengths)[:,1] : (warn("$srcLengths: can not be found\n\n"); Float64[])

	end #if
	println("\n Result Log\n*************\n=============")
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

prompt the user to input detector parameters from the console.
return a tuple of the inputted detectors.  
"""
function getDetectors()
	Detectors_array = GammaDetector[]
	print_with_color(:white,"\t----<( Press return: to provid detector from console )>----\n"); readline()
	while(true)
		try
			push!(Detectors_array, DetectorFactory())
			
		catch
			break
			
		end #try
		
		print_with_color(:white,
		"""\n
    	- To add a new detector just press return\n
    	- To quit press 'Q' then return\n
			\n\tyour Choice: """);
		res = input("")|> lowercase; 
		res == "q" && break 
	
	end #while
	return Detectors_array
end #function
