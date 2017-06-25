#**************************************************************************************
# test_Input_Interface.jl
# ======================= part of the GeoEfficiency.jl package.
# 
# test all the input from eithther the console or the csv files.
# 
#**************************************************************************************


@testset "Input_Interface" begin

print("\t"); info("test `setSrcToPoint`...")    
	@testset "setSrcToPoint" begin
		@test G.srcType == -1  				# the intial value == source type not defined
		@test setSrcToPoint() == false      # not defined, set to not point

		@test setSrcToPoint(true) == true
		@test G.srcType == 0
		@test setSrcToPoint() == true
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ")	== true	

		@test setSrcToPoint(false) == false
		@test G.srcType == 1
		@test setSrcToPoint() == false
		@test setSrcToPoint("\n Is it a point source {Y|n} ? ")	== false	
	end #testset
  
print("\t"); info("test `getfloat`...")
  @testset "getfloat" begin  
print("\t"); info("test `getfloat` with different ways to input numbers...")    
	@test   0.0     ==  getfloat("\njust press return: ",value="0.0")
	@test   1.0     ==  getfloat("\ninput 1, then press return: ",value="1.0")
	@test   1.0     ==  getfloat("\ninput 1.0, then press return: ",value="1.0")
	@test   2000.0  ==  getfloat("\ninput '2e3', then press return: ",value="2e3")
	@test   0.034   ==  getfloat("\ninput '3.4e-2', then press return: ",value="3.4e-2")
	@test   isa( getfloat("\ntry to input any string, only valid number should accepted: ",value="1*0im"), Float64)
	#@test   isa( getfloat("\nthe first time input '1.2f': "), Float64)

print("\t"); info("test `getfloat` with mathematical expressions...")
	@test   0.5           ==  getfloat("\ninput 1/2, then press return: ",value="1/2")
	@test   0.75          ==  getfloat("\ninput 3//4, then press return: ",value="3//4")
	@test   Base.pi/2     ≈  getfloat("\ninput 'pi/2', then press return: ",value="pi/2")
	@test   Base.e        ≈  getfloat("\ninput 'e', then press return: ",value="e")
	@test   Base.e^3      ≈  getfloat("\ninput 'e^3', then press return: ",value="e^3")
	@test   Base.sin(0.1) ≈  getfloat("\ninput 'sin(0.1)', then press return: ",value="sin(0.1)")
	#@test   isa( getfloat("\nthe first time input '1.2+2im': "), Float64)
    end # testset
	
print("\t"); info("test `reading from CSV`...")	
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

	print("\t"); info("Detectors write and read  - input type{Int}")	
		@test  G.writecsv_head(detectorfile, detector_info_array, ["CryRaduis"	 "CryLength" "HoleRadius" "HoleDepth"])  ==  nothing
		@test  Set(G.detector_info_from_csvFile("_Detector_test.csv", datadirectory)) == Set(detectors)

	print("\t"); info("write and read  - input type{Int}")
		@test  G.writecsv_head(hightfile, [0, 1, 2, 3, 4, 5, 10, 15, 20,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]

	print("\t"); info("READ_BATCH_INFO")	
		batch_info = G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile)
		@test  Set(batch_info[1]) == Set(detectors)
		@test  batch_info[2] == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		@test  batch_info[3] == [0.0]
		@test  batch_info[4] == [0.0]
		@test  batch_info[5] == [0.0]
		@test  batch_info[6] == ( G.srcType === 0)
		@test  G.read_batch_info(datadirectory, detectorfile, hightfile, Rhosfile, Radiifile, Lengthsfile) == (detectors |> sort, [0.0, 1, 2, 3, 4, 5, 10, 15, 20,], [0.0], [0.0], [0.0], G.srcType === 0)

	print("\t\t"); info("rewrite, read and sort  - input type{Int}")
		@test  G.writecsv_head(hightfile, [3, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		
	print("\t\t"); info("rewrite, read and sort - input type{Rational-treated as any}")
		@test  G.writecsv_head(hightfile, [3//2, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
		
	print("\t\t"); info("rewrite, read and sort - input type{Float64}")
		@test  G.writecsv_head(hightfile, [3.0, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
		
	#info("\t\trewrite, read and sort - input type{Irrational....}")
	#	@test  G.writecsv_head(hightfile, [pi, e, pi + e, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
	#	@test G.read_from_csvFile("_hight_test.csv", datadirectory) == [0]
		
	print("\t\t"); info("invalid data type {Unionall}")
		@test  G.writecsv_head(hightfile, ["3.0", 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) ==  [0, 1, 2, 3, 4, 5, 10, 15, 20,]

	print("\t\t"); info("invalid data type {String}")
		@test  G.writecsv_head(hightfile, ["pi", "20", "4", "0", "1", "2", "5", "10", "15",], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
	
	print("\t\t"); info("invalid data type {Complex}")
		@test  G.writecsv_head(hightfile, [3.0+0.0im, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]			
	
	print("\t\t"); info("missing file")
		rm(hightfile, recursive=true)
		@test  G.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]			

	print("\t\t"); info("Detectors - missing file\n")	
		rm(datadirectory, recursive=true)
		@test_throws SystemError G.detector_info_from_csvFile("_Detector_test.csv", datadirectory) 

	try	rm(datadirectory, recursive=true)	end
	end # testset
	
print("\n\t"); info("test `getDetectors`...")		
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
		@test_throws  MethodError getDetectors(detector_info_array,false)
		detector_info_array = [5+1im 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
		@test_throws MethodError getDetectors(detector_info_array,false)
		detector_info_array = detector_info_array = Matrix{Int}(0,0)
		@test_throws ErrorException getDetectors(detector_info_array,false)
    end # testset
prinln()
end # testset
