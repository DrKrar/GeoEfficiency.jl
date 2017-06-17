#**************************************************************************************
# Output_Interface.jl
# =============== part of the GeoEfficiency.jl package.
#
# all the output either to the console or to the csv files is handled here.
#
#**************************************************************************************

isconst(:resultsfolder) || const resultsfolder = "results";
const resultdir 	= joinpath(datadir, resultsfolder);		     isdir(resultdir) 		   || mkdir(resultdir)
const resultdir_pnt = joinpath(resultdir, "Point");			     isdir(resultdir_pnt) 	 || mkdir(resultdir_pnt)
const resultdir_nonPnt = joinpath(resultdir, "non-Point");	 isdir(resultdir_nonPnt) || mkdir(resultdir_nonPnt)
countDetectors = 1;

#------------------calc-----------------------------------------------
"""
	calc(detector::RadiationDetector = RadiationDetector(), aSource::Tuple{Point, Float64, Float64,} = source())

calculate the Geometrical Efficiency of the detector `detector` and display it on the `console`.
If no detector is supplied, it ask for a detector from the `console`.
Any way it prompt the user to input a source via the `console`.

"""
function calc(detector::RadiationDetector = RadiationDetector(), aSource::Tuple{Point, Real, Real} = source())
			   
	aPnt, srcRadius, srcLength = aSource
	print_with_color(:yellow,"\n\<$(countDetectors)\> $(id(detector))")
	println("\n - Source(", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, ")")
	try
		println("\n - The detector Geometrical Efficiency = ", geoEff(detector, aPnt, srcRadius, srcLength))

	catch err
		println(err)
		info("\n\tThe function `calc` had termiate, Thank you >>>>>\n")
		return nothing

	end #try
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

		calc(detector)
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
	info("\n\tThe `calcN` had termiate, Thank you\n")
	return nothing
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

provide batch calculation of the Geometricel efficiecny for the detector `detector` .

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.

Return a tuple of the `detector array` and the `results array`. the `results array` has coloulmns `Height`, `Rho`, `GeoEfficiency` in the  case of a point while coloulmns `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency` for non-point sources.
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
				)
end #function

"""
    batch( detectors_array::Vector{T},
	       srcHeights_array::Vector{S},
	       srcRhos_array::Vector{S}=[0.0],
	       srcRadii_array::Vector{S}=[0.0],
	       srcLengths_array::Vector{S}=[0.0],
	       ispoint::Bool=true) where T <: RadiationDetector where S <: Real

provide batch calculation of the Geometricel efficiecny for each detector in the `detectors_array`.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.
\n*****

"""
function batch( detectors_array::Vector{T},
	       srcHeights_array::Vector{S},
	       srcRhos_array::Vector{S}=[0.0],
	       srcRadii_array::Vector{S}=[0.0],
	       srcLengths_array::Vector{S}=[0.0],
	       ispoint::Bool=true) where T <: RadiationDetector where S <: Real

	for detector = detectors_array
		batch(detector,
			srcHeights_array,
			srcRhos_array,
			srcRadii_array,
			srcLengths_array,
			ispoint)

	end # detectors_array

	info("\n\tThe program had termiate, Thank you >>>>\n")
	return nothing

end #function


"""# UnExported

    _batch(::Type{Val{true}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64}
				)

batch calclulation for point sources.

# Note

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
	out_results::Array{Float64,1} = Float64[];
	cellLabel = "\n\<$(countDetectors)\>$(id(detector))"
	for srcHeight = srcHeights_array

		aPnt.Height = srcHeight		#setHeight!(aPnt, srcHeight)
		for srcRho = srcRhos_array
			aPnt.Rho = srcRho		    #setRho!(aPnt, srcRho)

			try
				calculatedEff= geoEff(detector, aPnt)
				push!(out_results, aPnt.Height, aPnt.Rho, calculatedEff)

			catch err
				isa(err, AssertionError) && break
				rethrow()      #rethrow any error in Calculations

			end #try

			print_with_color(:yellow,cellLabel)
			println("\n - Source: ", id(aPnt))
			println("\n - The detector Geometrical Efficiency = ", calculatedEff)
			print_with_color(:red, repeat(" =",36),"\n\n")

		end #for_Rho

	end #for_Height

	results::Matrix{Float64} = reshape(out_results, 3, Int(length(out_results)/3)) |> transpose
	info("Saving <$countDetectors> to '$(id(detector)).csv'......\n")
	try
		writecsv_head(joinpath(resultdir_pnt,  "$(id(detector)).csv"), results, ["Height" "Rho" "GeoEfficiency"])

	catch err
		warn("'.$(id(detector)).csv': can't be created, results saved in an alternative file")
		writecsv_head(joinpath(resultdir_pnt, "_$(id(detector)).csv"), results, ["Height" "Rho" "GeoEfficiency"])

	end #try
	global countDetectors += 1;
	return (detector, results)

end #function

"""# UnExported

    _batch(::Type{Val{false}},
				detector::RadiationDetector,
				srcHeights_array::Vector{Float64},
				srcRhos_array::Vector{Float64},
				srcRadii_array::Vector{Float64},
				srcLengths_array::Vector{Float64},
				)

batch calclulation for non-point sources.

# Note

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
	cellLabel = "\n\<$(countDetectors)\>$(id(detector))"
	for srcHeight = srcHeights_array

		aPnt.Height = srcHeight		#setHeight!(aPnt, srcHeight)
		for srcRho = srcRhos_array

			aPnt.Rho = srcRho		#setRho!(aPnt, srcRho)
			for  srcLength = srcLengths_array;

				for srcRadius = srcRadii_array

					try
						calculatedEff = geoEff(detector, aPnt, srcRadius , srcLength)
						push!(out_results, aPnt.Height, aPnt.Rho, srcRadius, srcLength, calculatedEff)

					catch err
						isa(err, AssertionError) && @goto(Next_Height)
						rethrow()      #rethrow any error in Calculations

					end #try

					print_with_color(:yellow,cellLabel)
					println("\n - Source[Anchor_", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, "]")
					println("\n - The detector Geometrical Efficiency = ", calculatedEff)
					print_with_color(:red, repeat(" =",36),"\n\n")

				end #for_srcRadius

			@label(Next_srcLength)
			end #for_srcLength

		end #for_Rho

	@label(Next_Height)
	end #for_Height

	results::Matrix{Float64} = reshape(out_results, 5, Int(length(out_results)/5)) |> transpose
	info("Saving <$countDetectors> to '$(id(detector)).csv'......\n")
	try 
		writecsv_head(joinpath(resultdir_nonPnt, "$(id(detector)).csv"), results, ["AnchorHeight" "AnchorRho" "srcRadius" "srcLength" "GeoEfficiency"])

	catch err
		warn("'$(id(detector)).csv': can't be created, results saved in an alternative file")
		writecsv_head(joinpath(resultdir_nonPnt, "_$(id(detector)).csv"), results, ["AnchorHeight" "AnchorRho" "srcRadius" "srcLength" "GeoEfficiency"])

	end #try
	global countDetectors += 1;
	return (detector, results)

end #function
