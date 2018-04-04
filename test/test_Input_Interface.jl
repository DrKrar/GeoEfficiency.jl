#**************************************************************************************
# test_Input_Interface.jl
# ======================= part of the GeoEfficiency.jl package.
# 
# test all the input to the package from either the console or the csv files.
# 
#**************************************************************************************

using Compat
import Compat.Sys: isapple
#using Compat.MathConstants

@testset "Input_Interface" begin

print("\n\t"); Compat.@info("test `setSrcToPoint` & `typeofSrc`...")
	@testset "setSrcToPoint" begin
		@test G.srcType === G.srcUnknown  	# the initial value
		@test typeofSrc() === G.srcUnknown  	# the initial value
		@test setSrcToPoint() === false      # not defined, set to not point

		@test setSrcToPoint(false) === false
		@test G.srcType == G.srcNotPoint
		@test typeofSrc() === G.srcNotPoint
		@test setSrcToPoint() === false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false	

		@test setSrcToPoint(true) === true
		@test G.srcType === G.srcPoint
		@test typeofSrc() === G.srcPoint
		@test setSrcToPoint() === true
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === true	

		@test typeofSrc(-5) === G.srcUnknown
		@test typeofSrc(-1) === G.srcUnknown
		@test setSrcToPoint() === false
		#@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false # require input
		
		@test typeofSrc(0) === G.srcPoint
		@test setSrcToPoint() === true
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === true
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
		
		@test typeofSrc(1) === G.srcLine
		@test setSrcToPoint() === false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
		
		@test typeofSrc(2) === G.srcDisk
		@test setSrcToPoint() === false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
		
		@test typeofSrc(3) === G.srcVolume
		@test setSrcToPoint() === false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
		
		@test typeofSrc(4) === G.srcNotPoint
		@test setSrcToPoint() === false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ") === false
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
		
		@test typeofSrc(5) === G.srcNotPoint
		@test setSrcToPoint() === false
		@test setSrcToPoint(false) === false
		@test setSrcToPoint(true)  === true
	end #testset

print("\n\t"); Compat.@info("test `input`...")
	@testset "input" begin
		if !isapple()
			write( Compat.stdin.buffer," anbfyiQERFC \n")
			@test G.input() == " anbfyiQERFC "
		else
			@test_throws 	ErrorException	write(Compat.stdin.buffer.buffer," anbfyiQERFC \n")
		end #if
	end #testset_input

print("\n\t"); Compat.@info("test `getfloat`...")
	@testset "getfloat" begin  
print("\n\t"); Compat.@info("test `getfloat` with different ways to input numbers...")
		@test   0.0     ==  getfloat("\njust press return: ",value="0.0")
		@test   1.0     ==  getfloat("\ninput 1, then press return: ",value="1.0")
		@test   1.0     ==  getfloat("\ninput 1.0, then press return: ",value="1.0")
		@test   2000.0  ==  getfloat("\ninput '2e3', then press return: ",value="2e3")
		@test   0.034   ==  getfloat("\ninput '3.4e-2', then press return: ",value="3.4e-2")
		@test   isa( getfloat("\ntry to input any string, only valid number should accepted: ",value="1*0im"), Float64)
	

print("\n\t"); Compat.@info("test `getfloat` with mathematical expressions...")
		@test   0.5           		==  getfloat("\ninput 1/2, then press return: ",value="1/2")
		@test   0.75          		==  getfloat("\ninput 3//4, then press return: ",value="3//4")
		@test   MathConstants.pi/2 	≈   getfloat("\ninput 'pi/2', then press return: ",value="pi/2")
		@test   MathConstants.e     ≈   getfloat("\ninput 'e', then press return: ",value="e")
		@test   MathConstants.e^3   ≈   getfloat("\ninput 'e^3', then press return: ",value="e^3")
		@test   Base.sin(0.1) 		≈   getfloat("\ninput 'sin(0.1)', then press return: ",value="sin(0.1)")
		if !isapple()
			for i = 0:5
				write(STDIN.buffer,"1.2+2im\n"^i * "3\n")
				@test   3.0 == getfloat("\nthe first time input '1.2+2im': ")
			end # for
			write(STDIN.buffer,"5\n" * "3\n")
			@test   3.0 == getfloat("\ninput 1/2, then press return: ", 0.0, 4.0)
			write(STDIN.buffer,"-1\n" * "3\n")
			@test   3.0 == getfloat("\ninput 1/2, then press return: ", 0.0, 4.0)
			write(STDIN.buffer,"1.2f\n" * "3\n")
			@test   3.0 == getfloat("\nthe first time input '1.2f': ", 0.0, 4.0)
		else
			@test_throws 	ErrorException	write(STDIN.buffer,"5\n" * "3\n")
		end #if
  end # testset
	
print("\n\t"); Compat.@info("test `reading from CSV`...")	
    @testset "reading from CSV" begin
		detector_info_array = [5 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
        detectors = [Detector(5, 0, 0, 0), Detector(5, 10, 0, 0), Detector(5, 10, 2, 0), Detector(5, 10, 2, 5)]

		datadirectory = joinpath(homedir(), "GeoEfficiency", "temptemp"); isdir(datadirectory) || mkdir(datadirectory)

		detectorfile = joinpath(datadirectory, "_Detector_test.csv")
		hightfile    = joinpath(datadirectory, "_hight_test.csv")
		Rhosfile     = "Rhosfile "
		Radiifile    = "Radiifile"
		Lengthsfile  = "Lengthsfile"
		setSrcToPoint(true) == true

	print("\n\t\t"); Compat.@info("Detectors write and read  - input type{Int}")	
		@test  G.writecsv_head(detectorfile, detector_info_array, ["CryRadius"	 "CryLength" "HoleRadius" "HoleDepth"])  ==  nothing
		@test  G.detector_info_from_csvFile("_Detector_test.csv", datadirectory) == sort(detectors)

	print("\n\t\t"); Compat.@info("write and read  - input type{Int}")
		@test  G.writecsv_head(hightfile, [0, 1, 2, 3, 4, 5, 10, 15, 20,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]

	print("\n\t\t"); Compat.@info("READ_BATCH_INFO")	
		batch_info = G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile)
		@test  batch_info[1] == sort(detectors)
		@test  batch_info[2] == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		@test  batch_info[3] == [0.0]
		@test  batch_info[4] == [0.0]
		@test  batch_info[5] == [0.0]
		@test  batch_info[6] == ( G.srcType === G.srcPoint)
		@test  G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile) == (detectors |> sort, [0.0, 1, 2, 3, 4, 5, 10, 15, 20,], [0.0], [0.0], [0.0], G.srcType === G.srcPoint)

	print("\n\t\t"); Compat.@info("rewrite, read and sort  - input type{Int}")
		@test  G.writecsv_head(hightfile, [3, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		
	print("\n\t\t"); Compat.@info("rewrite, read and sort - input type{Rational-treated as any}")
		@test  G.writecsv_head(hightfile, [3//2, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
		
	print("\n\t\t"); Compat.@info("rewrite, read and sort - input type{Float64}")
		@test  G.writecsv_head(hightfile, [3.0, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		
	#print("\n\t\t"); Compat.@info("rewrite, read and sort - input type{Irrational....}")
	#	@test  G.writecsv_head(hightfile, [pi, e, pi + e, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
	#	@test G.read_from_csvFile("_hight_test.csv", datadirectory) == [0]
		
	print("\n\t\t"); Compat.@info("invalid data type {Unionall}")
		@test  G.writecsv_head(hightfile, ["3.0", 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) ==  [0, 1, 2, 3, 4, 5, 10, 15, 20,]

	print("\n\t\t"); Compat.@info("invalid data type {String}")
		@test  G.writecsv_head(hightfile, ["pi", "20", "4", "0", "1", "2", "5", "10", "15",], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
	
	print("\n\t\t"); Compat.@info("invalid data type {Complex}")
		@test  G.writecsv_head(hightfile, [3.0+0.0im, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]			
	
	print("\n\t\t"); Compat.@info("missing file - `Hights.csv`")
		rm(hightfile, recursive=true)
		
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
		if !isapple()		# 
			setSrcToPoint(false)
			write(Compat.stdin.buffer, 
			"1\n" * "0\n" * #=axial point=#
			"2\n" * "3\n" #=SrcRadius SrcHeight=#)
			@test  G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile) == (detectors |> sort, [1.0],	[0.0], [2.0], [3.0], false)
		end #if
		
	print("\n\t\t"); Compat.@info("missing file - `Rhos.csv`")
		@test  G.writecsv_head(hightfile, [4.0,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [4.0]
		if !isapple() 		#
			setSrcToPoint(false)
			write(Compat.stdin.buffer, 
			"1\n" * "0\n" * #=axial point=#
			"2\n" * "3\n" #=SrcRadius SrcHeight=#)
			@test  G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile) == (detectors |> sort, [1.0],	[0.0], [2.0], [3.0], false)
		end #if

	print("\n\t\t"); Compat.@info("Detectors - missing file\n")	
		rm(datadirectory, recursive=true)
		@test_throws Union{ArgumentError, SystemError}  G.detector_info_from_csvFile("_Detector_test.csv", datadirectory)   # the Union{ArgumentError, SystemError} is used for compatibility in both 0.6 and 0.7-dev

	rm(datadirectory, force=true, recursive=true)
	
	@test_throws Union{ArgumentError, SystemError}  G.detector_info_from_csvFile("jskfdsiu.uty","fghpweuh.uty")
	
	try 
		@test eltype(G.detector_info_from_csvFile()) == G.Detector

		if  [0.0] != G.read_from_csvFile(G.srcHeights, G.datadir)
			setSrcToPoint(true);  
			@test G.read_batch_info()[end]=== true
			
			if [0.0] != G.read_from_csvFile(G.srcRadii, G.datadir) 
				setSrcToPoint(false); 
				@test G.read_batch_info()[end]=== false
			end
		end	
	end
	
	end # testset
	
print("\n\t"); Compat.@info("test `getDetectors`...")		
    @testset "getDetectors" begin
		detector_info_array = [5 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
        detectors = [Detector(5, 0, 0, 0), Detector(5, 10, 0, 0), Detector(5, 10, 2, 0), Detector(5, 10, 2, 5)]
	    detectors = detectors |> sort
        
		@test getDetectors(detector_info_array) == detectors 
		for det = detectors
			@test typeof(det) != Detector
		end
		@test eltype(detectors) != CylDetector
		@test eltype(detectors) == Detector
		det1, det2, det3, det4 = detectors
		@test det1 <= det2 <= det3 <= det4
		
		detector_info_array = [5 0; 10 0; 15 0; 20 0]
		detectors = getDetectors(detector_info_array)
		for det = detectors
			@test typeof(det) == CylDetector
			@test typeof(det) != Detector
		end
		@test eltype(detectors) != CylDetector
		@test eltype(detectors) == Detector
		det1, det2, det3, det4 = detectors
		
		detector_info_array = [5 1; 10 1; 15 1; 20 1]
		detectors = getDetectors(detector_info_array)
		for det = detectors
			@test typeof(det) == CylDetector
			@test typeof(det) != Detector
		end
		@test eltype(detectors) != CylDetector
		@test eltype(detectors) == Detector
		det1, det2, det3, det4 = detectors
		@test det1 <= det2 <= det3 <= det4
		
		detector_info_array = [5 1; 10 1; 15 1; 20 1//1]
		detectors = getDetectors(detector_info_array)
		for det = detectors
			@test typeof(det) == CylDetector
			@test typeof(det) != Detector
		end
		@test eltype(detectors) != CylDetector
		@test eltype(detectors) == Detector
		det1, det2, det3, det4 = detectors
		@test det1 <= det2 <= det3 <= det4
		
		detector_info_array = [5 1; 10 1; 15 1; 20 1.0]
		detectors = getDetectors(detector_info_array)
		for det = detectors
			@test typeof(det) == CylDetector
			@test typeof(det) != Detector
		end
		@test eltype(detectors) != CylDetector
		@test eltype(detectors) == Detector
		det1, det2, det3, det4 = detectors
		@test det1 <= det2 <= det3 <= det4

		detector_info_array = ["5" "0" "0" "0"; "10" "0" "0" "0"]
		@test_throws  MethodError getDetectors(detector_info_array; console_FB=false)
		detector_info_array = [5+1im 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
		@test_throws MethodError getDetectors(detector_info_array; console_FB=false)
		detector_info_array = detector_info_array = Matrix{Int}(0,0)
		@test_throws ErrorException getDetectors(detector_info_array; console_FB=false)
		
		if true #!isapple()
			for q=["q", "Q"] , n=["", "n", "N", "fgdfgf", "qQ", "Qq"]
				write(Compat.stdin.buffer,"5\n" * "1\n" * "0\n" * "$q\n")
				@test getDetectors() == [Detector(5,1)]
				write(Compat.stdin.buffer,"5\n" * "1\n" * "0\n" * "$q\n")
				@test getDetectors(Matrix{Float64}(0,0)) == [Detector(5,1)]
		
		 		write(Compat.stdin.buffer,"5\n" * "1\n" * "0\n" * "$n\n" *"55\n" * "11\n" * "0\n" * "$q\n")
				@test getDetectors(Matrix{Float64}(0,0)) == [Detector(5, 1), Detector(55, 11)]
			end # for
		else
			@test_throws	ErrorException	write(Compat.stdin.buffer,"5\n" * "1\n" * "0\n" * "$q\n")
		end #if
    end # testset
println()
end # testset
