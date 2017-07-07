#**************************************************************************************
# Output_Interface.jl
# =============== part of the GeoEfficiency.jl package.
#
# all the output either to the console or to the csv files is handled here.
#
#**************************************************************************************

@compat isconst(@__MODULE__, :resultsfolder) || const resultsfolder = "results";
const resultdir 	   = joinpath(datadir, resultsfolder);	isdir(resultdir) 		|| mkdir(resultdir)
const resultdir_pnt    = joinpath(resultdir, "Point");		isdir(resultdir_pnt) 	|| mkdir(resultdir_pnt)
const resultdir_nonPnt = joinpath(resultdir, "non-Point");	isdir(resultdir_nonPnt) || mkdir(resultdir_nonPnt)
countDetectors = 1;

#------------------calc-----------------------------------------------
"""

	calc(detector::RadiationDetector = RadiationDetector(), aSource::Tuple{Point, Float64, Float64,} = source())

calculate the Geometrical Efficiency of the detector `detector` for the tuple `aSource` decribing the source and display it on the `console`.

Throw` an Error if the source location is inappropriate.

*similar:* `geoEff(detector::RadiationDetector = RadiationDetector(), aSource::Tuple{Point, Float64, Float64,} = source())`

!!! note
    * If no detector is supplied, it ask for a detector from the `console`.
    * if no souce describtion is provided, it prompt the user to input a source via the `console`.

"""
function calc(detector::RadiationDetector = RadiationDetector(), aSource::Tuple{Point, Real, Real} = source())
			   
	aPnt, srcRadius, srcLength = aSource
	print_with_color(:yellow,"\n\<$(countDetectors)\> $(id(detector))")
	println("\n - Source(", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, ")")
    
	calculatedEff::Float64 = geoEff(detector, aPnt, srcRadius, srcLength)
	println("\n - The detector Geometrical Efficiency = ", calculatedEff)

	global countDetectors += 1
	print_with_color(:red, repeat(" =",36),"\n\n")
	return nothing

end #function

#------------------calcN-----------------------------------------------
"""

    calcN()

calculate and display the Geometrical Efficiency.
Prompt the user to input a `detector` and a `source` from the `console`.
Prompt the user `repeatedly` until it exit (give a choice to use the same detector or a new detector).

"""
function calcN(	detector:: RadiationDetector = RadiationDetector())

	while (true)

		try	calc(detector) end
		
		res = input("""\n
    	I- To continue make a choice:
			> using the same detector Press 'd'|'D'
			> using a new detector Press 'n'|'N'\n
    	II- To quit just press return\n
			\n\tyour Choice: """, :red) |> lowercase;
		if res == "n"
            detector = RadiationDetector()

		elseif res == "d"
            continue

		else
			break

		end #if

	end #while
	print("\n\t"); info("The `calcN` had termiate, Thank you\n")
end #function

#----------------writecsv_head------------------------------------------

"Write comma delimated values to file `fname`"
function writecsv_head(fname::AbstractString, a, head=[])
	open(fname, "w") do io
	  writedlm(io, head, ',')
	  writedlm(io, a, ',')
	end #do
end #function


#----------------batch()-------------------------------------------------

"""

	batch()

provide batch calculation of the Geometrical Efficiency based on the data provided from the csv files located in `$(datafolder)`.

Results are saved on a `csv file` named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.

Throw an error if the source location is inappropriate.
\n*****

"""
batch() = batch(read_batch_info()...)

"""

    batch(	detector_info_array::Matrix{S},
				srcHeights_array::Vector{S},
				srcRhos_array::Vector{S}=[0.0],
				srcRadii_array::Vector{S}=[0.0],
				srcLengths_array::Vector{S}=[0.0],
				ispoint::Bool=true) where S <: Real

provide batch calculation of the Geometricel efficiecny for each detector in the `detector_info_array` after applying detectorFactory() to each raw.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.
If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.
\n*****

"""
function batch(	detector_info_array::Matrix{S},
				srcHeights_array::Vector{S},
				srcRhos_array::Vector{S}=[0.0],
				srcRadii_array::Vector{S}=[0.0],
				srcLengths_array::Vector{S}=[0.0],
				ispoint::Bool=true) where S <: Real

				
	return  batch(	getDetectors(detector_info_array),
					srcHeights_array,
					srcRhos_array,
					srcRadii_array,
					srcLengths_array,
					ispoint)
end #function

"""

    batch(	detector::RadiationDetector,
				srcHeights_array::Vector{S},
				srcRhos_array::Vector{S}=[0.0],
				srcRadii_array::Vector{S}=[0.0],
				srcLengths_array::Vector{S}=[0.0],
				ispoint::Bool=true) where S <: Real

return the path of the `CSV` files containing the results of the batch calculation of the Geometricel efficiecny for the detector `detector`.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.


\n*****

"""
function batch(	detector::RadiationDetector,
				srcHeights_array::Vector{S},
				srcRhos_array::Vector{S}=[0.0],
				srcRadii_array::Vector{S}=[0.0],
				srcLengths_array::Vector{S}=[0.0],
				ispoint::Bool=true) where S <: Real
				
	return _batch(Val{ispoint},
				detector::RadiationDetector,
				srcHeights_array,
				srcRhos_array,
				srcRadii_array,
				srcLengths_array
				)[3]
end #function

"""

    batch( detectors_array::Vector{T},
	       srcHeights_array::Vector{S},
	       srcRhos_array::Vector{S}=[0.0],
	       srcRadii_array::Vector{S}=[0.0],
	       srcLengths_array::Vector{S}=[0.0],
	       ispoint::Bool=true) where T <: RadiationDetector where S <: Real

return an array of the paths of the `CSV` files containing the results of the batch calculation of the Geometricel efficiecny for each detector in the `detectors_array`.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

!!! note
    Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.
\n*****

"""
function batch( detectors_array::Vector{T},
	       srcHeights_array::Vector{S},
	       srcRhos_array::Vector{S}=[0.0],
	       srcRadii_array::Vector{S}=[0.0],
	       srcLengths_array::Vector{S}=[0.0],
	       ispoint::Bool=true) where T <: RadiationDetector where S <: Real
	
	outpaths::Vector{String} = String[]
	for detector = detectors_array
		push!(outpaths ,  
			batch(detector,
					srcHeights_array,
					srcRhos_array,
					srcRadii_array,
					srcLengths_array,
					ispoint))

	end # detectors_array

	print("\n\t"); info("The program had termiate, Thank you >>>>\n")
	return outpaths

end #function


"""# UnExported

    _batch(::Type{Val{true}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64}
				)

Batch calclulation for point sources. Return a tuple of the `detector` and the `results` and the path of the `CSV` file containg results. 
The `results` has coloulmns `Height`, `Rho`, `GeoEfficiency`. 

!!! note
    All of the arrays `srcHeights_array`, `srcRhos_array` element type should be float64. If any of them have Real element type it should converted float64 to using `float` befor passing to the `batch` function.

"""
function _batch(::Type{Val{true}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64},
				)

	aPnt::Point = Point(0.0, 0.0)
	calculatedEff::Float64 = 0.0
	out_results::Vector{Float64} = Float64[];
	cellLabel = "\n\n\<$(countDetectors)\>$(id(detector))\n"
	for srcHeight = srcHeights_array
		for srcRho = srcRhos_array
		aPnt = Point(srcHeight, srcRho)
			
			calculatedEff = try	geoEff(detector, aPnt); catch err;	NaN64 end
			push!(out_results, aPnt.Height, aPnt.Rho, calculatedEff)

			print_with_color(:yellow, cellLabel)
			println(" - Source: ", id(aPnt))
			println()
			println(" - The detector Geometrical Efficiency = ", calculatedEff)
			print_with_color(:red, repeat(" =",36),"\n")

		end #for_Rho

	end #for_Height
	results::Matrix{Float64} = reshape(out_results, 3, :) |> transpose
	info("Saving <$countDetectors> to '$(id(detector)).csv'......\n")
	path = joinpath(resultdir_pnt,  "$(id(detector)).csv")
	try
		writecsv_head(path, results, ["Height" "Rho" "GeoEfficiency"])

	catch err
		warn("'.$(id(detector)).csv': can't be created, trying to save results in an alternative file")
		path = joinpath(resultdir_pnt,  "_$(id(detector)).csv")
		writecsv_head(path, results, ["Height" "Rho" "GeoEfficiency"])

	end #try
	global countDetectors += 1;
	return (detector, results, path) # detector, results are for test porpose

end #function

"""# UnExported

    _batch(::Type{Val{false}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64},
				)

Batch calclulation for non-point sources. Return a tuple of the `detector` and the `results` and the path of the `CSV` file containg results. 
The `results` has coloulmns `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency`.

!!! note
    All of the arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array`, `srcLengths_array` element type should be float64. If any of them have Real element type it should converted float64 to using `float` befor passing to the `batch` function.

"""
function _batch(::Type{Val{false}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64},
				)

	aPnt::Point = Point(0.0, 0.0)
	out_results::Vector{Float64} = Float64[];
	calculatedEff::Float64 = 0.0
	cellLabel = "\n\n\<$(countDetectors)\>$(id(detector))\n"
	for srcHeight = srcHeights_array
		for srcRho = srcRhos_array
		aPnt = Point(srcHeight, srcRho)
			for  srcLength = srcLengths_array;
				for srcRadius = srcRadii_array
					try
						calculatedEff = geoEff(detector, aPnt, srcRadius , srcLength)

					catch err
						#isa(err, AssertionError) && @goto(Next_srcLength)
						calculatedEff = NaN

					end #try
					
					push!(out_results, aPnt.Height, aPnt.Rho, srcRadius, srcLength, calculatedEff)
					
					print_with_color(:yellow,cellLabel)
					println(" - Source[Anchor_", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, "]")
					println()
					println(" - The detector Geometrical Efficiency = ", calculatedEff)
					print_with_color(:red, repeat(" =",36),"\n")

				end #for_srcRadius

			@label(Next_srcLength)
			end #for_srcLength

		end #for_Rho

	@label(Next_Height)
	end #for_Height

	results::Matrix{Float64} = reshape(out_results, 5, :) |> transpose
	info("Saving <$countDetectors> to '$(id(detector)).csv'......\n")
	path = joinpath(resultdir_nonPnt, "$(id(detector)).csv")
	try 
		writecsv_head(path, results, ["AnchorHeight" "AnchorRho" "srcRadius" "srcLength" "GeoEfficiency"])

	catch err
		warn("'$(id(detector)).csv': can't be created, trying to save results in an alternative file")
		path = joinpath(resultdir_nonPnt, "_$(id(detector)).csv")
		writecsv_head(path, results, ["AnchorHeight" "AnchorRho" "srcRadius" "srcLength" "GeoEfficiency"])

	end #try
	global countDetectors += 1;
	return (detector, results, path) # detector, results are for test porpose

end #function
