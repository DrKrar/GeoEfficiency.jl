#**************************************************************************************
# Output_Interface.jl
# =============== part of the GeoEfficiency.jl package.
# 
# all the output either to the console or to the csv files is handled here. 
# 
#**************************************************************************************

const results = "results";  			isdir(datafolder*"\\"*results) || mkdir(datafolder*"\\"*results)
countDetectors = 1;


"""
	calc(Detector::GammaDetector = DetectorFactory())

display the geometrical efficiency of the "Detector" on the console.
if no detector is supplied it ask for a detector from the console.
also prompt the user to input a source via the console.
"""
function calc(Detector::GammaDetector = DetectorFactory())
	global countDetectors
	aPnt, srcRadius, srcLength = source()
	print_with_color(:yellow,"\n\<$(countDetectors)\> $(id(Detector))")
	println("\n - Source(", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, ")")
	try
		println("\n - The Detector Geometrical Efficiency = ", GeoEff(Detector, aPnt, srcRadius, srcLength))

	catch err
		println(err)
		input("\n\t To Procced Press any Button")
		return 0

	end #try
	countDetectors += 1
	print_with_color(:red, repeat(" =",36),"\n\n")

end #function


"""

	calcN()

display the geometrical efficiency. 
prompt the user to input a detector and a source from the console.
prompt the user repeatedly until it exit (give a choice to use the same detector or a new detector).	
"""
function calcN()
	Detector = DetectorFactory()
	while (true)

		calc(Detector)		
		print_with_color(:white,"""\n
    	I- To continue make a choice:
			> using the same detector Press 'D'
			> using a new detector Press 'N'\n
    	II- To quit just press return\n
			\n\tyour Choice: """);
		res = input("")|> lowercase; 
		if res == "n" 
            Detector = DetectorFactory()
        
		elseif res == "d"
            continue
        
		else
			break
        
		end #if    
	
	end #while
	return 0
end #function


"""

	batch()

batch calculation of the geometrical efficiency based on the data provided from the csv files.
results are saved on a csv file named after the detector, also results are displayed on the console.
"""
function batch()
	batch(read_batch_info()...)
end #function
"""

	 batch( Detectors_array::Union{Array{GammaDetector,1}, Array{Float64,2}}, 
			srcHeights_array::Array{Float64,1}, 
			srcRhos_array::Array{Float64,1}=[0.0], 
			srcRadii_array::Array{Float64,1}=[0.0],
			srcLengths_array::Array{Float64,1}=[0.0],
			ispoint::Bool=true)

batch calculation of the Geometricel efficiecny for each detector in the Detectors_array (directly or after applying DetectorFactory() to each raw).
a set of sources is constructed of every valid combination of parameter in the srcRhos_array, srcRadii_array, srcLengths_array with conjunction with ispoint.
if ispoint is true the source type is a point source and the parameters in srcRadii_array , srcLengths_array is completely ignored.
if ispoint is false the parameters in srcRhos_array is completely ignored.

results are saved on a csv file named after the detector, also results are displayed on the console.
"""
function batch(	Detectors_array::Union{Array{GammaDetector,1}, Array{Float64,2}}, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0],
				ispoint::Bool=true)
	global countDetectors
	Detector::GammaDetector = CylDetector(0.0001); aPnt::Point = Point(0.0, 0.0)
	for i_th_line = 1:size(Detectors_array)[1]

		try
			Detector = DetectorFactory((Detectors_array[i_th_line,:])...)
			
		catch err
			#println("incatchDet"); println(err); println(" P2 ", Detector)
			continue
		
		end #try
		res =Float64[]; src = Float64[];
		cellLabel = "\n\<$(countDetectors)\>$(id(Detector))"
		for srcHeight = srcHeights_array
			
			aPnt.Height = srcHeight		#setHeight!(aPnt, srcHeight)
			for srcRho = srcRhos_array
				
				aPnt.Rho = srcRho		#setRho!(aPnt, srcRho)
				for  srcLength = srcLengths_array; 
					
					for srcRadius = srcRadii_array
						
						#println(" P2 multiple for")
						try
							#println(" P3 ", Detector)
							x = GeoEff(Detector, aPnt, srcRadius , srcLength)
							push!(res,x);
							push!(src, aPnt.Height, aPnt.Rho, srcRadius , srcLength, x)
						
						catch err
							#println("in catch Geo", err)
							#rethrow()
							#break
							if isa(err, AssertionError)
								println("in catch Geo", err)
								ispoint && @goto(Next_Height)
								break								
								
							end #if
						end #try
						
						print_with_color(:yellow,cellLabel)
						println("\n - Source(", id(aPnt), ", srcRadius=",srcRadius, ", srcLength=", srcLength, ")")
						println("\n - The Detector Geometrical Efficiency = ", res[end])
						print_with_color(:red, repeat(" =",36),"\n\n")
					
					end #for_srcRadius
				
				@label(Next_srcLength)	
				end #for_srcLength
			
			end #for_Rho
		
		@label(Next_Height)	
		end #for_Height
		
		SRC::Array{Float64,2} = reshape(src, 5, length(res))
		try 
			writecsv(".\\$(datafolder)\\$(results)\\$(ispoint?"PointSRC_":"")$(id(Detector)).csv",SRC')
		
		catch
			writecsv(".\\$(datafolder)\\$(results)\\=$(ispoint?"PointSRC_":"")$(id(Detector)).csv",SRC')
		
		end #try
		countDetectors += 1
	end # for_i_th_line
	
	readline("\n\t the program termiate, To Procced Press any Button")
	return 

end #function