const results = "results";  			isdir(datafolder*"\\"*results) || mkdir(datafolder*"\\"*results)
countDetectors = 1;


"""
	calc(Detector::GammaDetector = DetectorFactory())

return the geometrical efficiency of the "Detector",
if no detector is supplied it ask for a detector from console first.
then ask for a source from the console.
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
	#println("\n - The ", typeof(Detector), " Detector Geometrical Efficiency = ", geo)
end #function

"""
	calcN()
	
ask for a detector from console, then do so repeatedly until the user choose to quit.
for each detector return the geometrical efficiency after asking about the source specification.
"""
function calcN()
	Detector = DetectorFactory()
	while (true)
		#=try	
			geo = GeoEff(Detector,source()...)
			println("\n\tGeoEff = ", geo, " of the ", typeof(Detector))
			#println("\n - The ", typeof(Detector), " Detector Geometrical Efficiency = " geo)
		
		catch err
			println(err)
			input("\n\t To Procced Press any Button")
		
		end #try =#
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

do a batch calculation of the Geometricel efficiecny based on the 
"""
function batch()
	batch(read_batch_info()...)
end #function

"""
	batch(	Detectors_array::Union{Array{GammaDetector,1}, Array{Float64,2}}, 
				srcHeights_array::Array{Float64,1}, 
				srcRhos_array::Array{Float64,1}=[0.0], 
				srcRadii_array::Array{Float64,1}=[0.0],
				srcLengths_array::Array{Float64,1}=[0.0],
				ispoint::Bool=true)


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
	
	input("\n\t the program termiate, To Procced Press any Button")

end #function