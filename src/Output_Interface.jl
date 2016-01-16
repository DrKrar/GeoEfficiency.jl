#**************************************************************************************
# Output_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# all the output either to the console or to the csv files is handled here. 
# 
#**************************************************************************************

const resultsfolder = "results";
const resultdir 	= joinpath(datadir, resultsfolder);		isdir(resultdir) 		|| mkdir(resultdir)
const resultdir_pnt = joinpath(resultdir, "Point");			isdir(resultdir_pnt) 	|| mkdir(resultdir_pnt)
const resultdir_nonPnt = joinpath(resultdir, "non-Point");	isdir(resultdir_nonPnt) || mkdir(resultdir_nonPnt)
countDetectors = 1;


"""
	calc(Detector::RadiationDetector = detectorFactory())

calculate the Geometrical Efficiency of the detector `Detector` and display it on the `console`.
If no detector is supplied it ask for a detector from the `console`.
Also prompt the user to input a source via the `console`.
"""
function calc(Detector::RadiationDetector = detectorFactory())
	global countDetectors
	aPnt, srcRadius, srcLength = source()
	print_with_color(:yellow,"\n\<$(countDetectors)\> $(id(Detector))")
	println("\n - Source(", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, ")")
	try
		println("\n - The Detector Geometrical Efficiency = ", geoEff(Detector, aPnt, srcRadius, srcLength))

	catch err
		println(err)
		input("\n\t To Procced Press any Button")
		return nothing

	end #try
	countDetectors += 1
	print_with_color(:red, repeat(" =",36),"\n\n")
	return nothing
	
end #function


"""

	calcN()

calculate and display the Geometrical Efficiency. 
Prompt the user to input a `detector` and a `source` from the `console`.
Prompt the user `repeatedly` until it exit (give a choice to use the same detector or a new detector).	
"""
function calcN()
	Detector = detectorFactory()
	while (true)

		calc(Detector)		
		res = input("""\n
    	I- To continue make a choice:
			> using the same detector Press 'd'|'D'
			> using a new detector Press 'n'|'N'\n
    	II- To quit just press return\n
			\n\tyour Choice: """, :blue)|> lowercase; 
		if res == "n" 
            Detector = detectorFactory()
        
		elseif res == "d"
            continue
        
		else
			break
        
		end #if    
	
	end #while
	return nothing
end #function

function writecsv_head(fname::AbstractString, a, head=[])
	open(fname, "w") do io
		writedlm(io, head, ',')
		writedlm(io, a, ',')
	end
end

"""

	batch()

provide batch calculation of the Geometrical Efficiency based on the data provided from the csv files located in `$(datafolder)`.

Results are saved on a `csv file` named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.

Throw an error if the source location is inappropriate.
\n*****
"""
function batch()
	batch(read_batch_info()...)
end #function

"""

	batch( Detector_info_array::Array{Float64,2}, 
		srcHeights_array::Array{Float64,1}, 
			srcRhos_array::Array{Float64,1}=[0.0], 
			srcRadii_array::Array{Float64,1}=[0.0],
			srcLengths_array::Array{Float64,1}=[0.0],
			ispoint::Bool=true)

provide batch calculation of the Geometricel efficiecny for each detector in the `Detector_info_array` after applying detectorFactory() to each raw.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.
If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.
\n*****
"""
function batch(	Detector_info_array::Array{Float64,2}, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0],
				ispoint::Bool=true)
	
	return  batch(	getDetectors(Detector_info_array), 
					srcHeights_array, 
					srcRhos_array, 
					srcRadii_array,
					srcLengths_array,
					ispoint)
end #function

"""

	 batch( Detector::RadiationDetector, 
			srcHeights_array::Array{Float64,1}, 
			srcRhos_array::Array{Float64,1}=[0.0], 
			srcRadii_array::Array{Float64,1}=[0.0],
			srcLengths_array::Array{Float64,1}=[0.0],
			ispoint::Bool=true)

provide batch calculation of the Geometricel efficiecny for the detector `Detector` .

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.

Return a tuple of the `detector array` and the `results array`. the `results array` has coloulmns `Height`, `Rho`, `GeoEfficiency` in the  case of a point while coloulmns `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency` for non-point sources.
\n*****
"""
function batch(	Detector::RadiationDetector, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0],
				ispoint::Bool=true)
				
	return _batch(Val{ispoint},
				Detector::RadiationDetector, 
				srcHeights_array, 
				srcRhos_array, 
				srcRadii_array,
				srcLengths_array
				)
end #function
				
"""

	 batch( Detectors_array::Array{RadiationDetector,1}, 
			srcHeights_array::Array{Float64,1}, 
			srcRhos_array::Array{Float64,1}=[0.0], 
			srcRadii_array::Array{Float64,1}=[0.0],
			srcLengths_array::Array{Float64,1}=[0.0],
			ispoint::Bool=true)

provide batch calculation of the Geometricel efficiecny for each detector in the `Detectors_array`.

A set of sources is constructed of every valid combination of parameter in the `srcRhos_array`, `srcRadii_array`, `srcLengths_array` with conjunction with `ispoint`.

If `ispoint` is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.

If `ispoint` is false the parameters in srcRhos_array is completely ignored.

Results are saved to a csv file named after the detector located in `$(resultdir)`, also a log of the results are displayed on the `console`.
\n*****
"""
function batch(	Detectors_array::Array{RadiationDetector,1}, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0],
				ispoint::Bool=true)
				
	for Detector = Detectors_array
		batch(Detector, 
			srcHeights_array, 
			srcRhos_array, 
			srcRadii_array,
			srcLengths_array,
			ispoint)

	end # Detectors_array

	input("\n\t the program had termiate, To Exit Press any Button")
	nothing

end #function

"""
batch calclulation for point sources.
"""
function _batch(::Type{Val{true}},
				Detector::RadiationDetector, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0]
				)
	
	global countDetectors
	aPnt::Point = Point(0.0, 0.0)
	results::Array{Float64,2} = Array(Float64,(0,0)); out_results::Array{Float64,1} = Float64[];
	cellLabel = "\n\<$(countDetectors)\>$(id(Detector))"
	for srcHeight = srcHeights_array
		
		aPnt.Height = srcHeight		#setHeight!(aPnt, srcHeight)
		for srcRho = srcRhos_array
			aPnt.Rho = srcRho		#setRho!(aPnt, srcRho)
				
			try
				x = geoEff(Detector, aPnt)
				push!(out_results, aPnt.Height, aPnt.Rho, x)
			
			catch err
				isa(err, AssertionError) && break
				rethrow()
				
			end #try
			
			print_with_color(:yellow,cellLabel)
			println("\n - Source: ", id(aPnt))
			println("\n - The Detector Geometrical Efficiency = ", out_results[end])
			print_with_color(:red, repeat(" =",36),"\n\n")
	
		end #for_Rho
		
	end #for_Height

	results = reshape(out_results, 3, Int(length(out_results)/3)) |> transpose
	println("INFO: Saving <$countDetectors> to '$(id(Detector)).csv'......")
	try 
		writecsv_head(joinpath(resultdir_pnt,  "$(id(Detector)).csv"), results, ["Height", "Rho", "GeoEfficiency"]')
	
	catch err
		warn("'.$(id(Detector)).csv': can't be created, results saved in an alternative file")
		writecsv_head(joinpath(resultdir_pnt, "_$(id(Detector)).csv"), results, ["Height", "Rho", "GeoEfficiency"]')
	
	end #try
	countDetectors += 1
	return (Detector, results)
	
end #function

"""
batch calclulation for non-point sources.
"""
function _batch(::Type{Val{false}},
				Detector::RadiationDetector, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0];
				)
	
	global countDetectors
	aPnt::Point = Point(0.0, 0.0)
	results::Array{Float64,2} = Array(Float64,(0,0)); out_results::Array{Float64,1} = Float64[];
	cellLabel = "\n\<$(countDetectors)\>$(id(Detector))"
	for srcHeight = srcHeights_array
		
		aPnt.Height = srcHeight		#setHeight!(aPnt, srcHeight)
		for srcRho = srcRhos_array
			
			aPnt.Rho = srcRho		#setRho!(aPnt, srcRho)
			for  srcLength = srcLengths_array; 
				
				for srcRadius = srcRadii_array
					
					try
						x = geoEff(Detector, aPnt, srcRadius , srcLength)
						push!(out_results, aPnt.Height, aPnt.Rho, srcRadius , srcLength, x)
					
					catch err
						isa(err, AssertionError) && @goto(Next_Height)	
						rethrow()
						
					end #try
					
					print_with_color(:yellow,cellLabel)
					println("\n - Source[Anchor_", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, "]")
					println("\n - The Detector Geometrical Efficiency = ", out_results[end])
					print_with_color(:red, repeat(" =",36),"\n\n")
				
				end #for_srcRadius
			
			@label(Next_srcLength)	
			end #for_srcLength
		
		end #for_Rho
	
	@label(Next_Height)	
	end #for_Height
	
	results = reshape(out_results, 5, Int(length(out_results)/5)) |> transpose
	println("INFO: Saving <$countDetectors> to '$(id(Detector)).csv'......")
	try err
		writecsv_head(joinpath(resultdir_nonPnt, "$(id(Detector)).csv"), results, ["AnchorHeight", "AnchorRho", "srcRadius", "srcLength", "GeoEfficiency"]')
	
	catch
		warn("'$(id(Detector)).csv': can't be created, results saved in an alternative file")
		writecsv_head(joinpath(resultdir_nonPnt, "_$(id(Detector)).csv"), results, ["AnchorHeight", "AnchorRho", "srcRadius", "srcLength", "GeoEfficiency"]')
	
	end #try
	countDetectors += 1;
	return (Detector, results)

end #function
	   