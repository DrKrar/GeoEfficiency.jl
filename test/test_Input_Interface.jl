#**************************************************************************************
# test_Input_Interface.jl
# ======================= part of the GeoEfficiency.jl package.
# 
# test all the input from eithther the console or the csv files.
# 
#**************************************************************************************


# this set of tests need interactive input from the console, uncomment the line after `while` to do tests.
info("Statrting `getfloat` test...")

warn("Those tests are suppressed because it need interactive input")
const dotest = false

@testset "Input_Interface" begin
  detector_info_array = [5 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
  detectors = [Detector(5, 0, 0, 0), Detector(5, 10, 0, 0), Detector(5, 10, 2, 0), Detector(5, 10, 2, 5)]
  
  @testset "SetSrcToPoint" begin
    @test SetSrcToPoint(true) == true
    @test GeoEfficiency.isPoint == true
    @test SetSrcToPoint(false) == false
    @test GeoEfficiency.isPoint == false
	end
  
  
  @testset "getfloat" begin  
	if dotest
	    info("test `getfloat` with different ways to input numbers...")
	    @test   0.0     ==  getfloat("\njust press return: ")
	    @test   1.0     ==  getfloat("\ninput 1, then press return: ")
	    @test   1.0     ==  getfloat("\ninput 1.0, then press return: ")
	    @test   2000.0  ==  getfloat("\ninput '2e3', then press return: ")
	    @test   0.034   ==  getfloat("\ninput '3.4e-2', then press return: ")
	    @test   isa( getfloat("\ntry to input any string, only valid number should accepted: "), Float64)
	    @test   isa( getfloat("\nthe first time input '1.2f': "), Float64)
	
	    info("test `getfloat` with mathematical expressions...")
	    @test   0.5           ==  getfloat("\ninput 1/2, then press return: ")
	    @test   0.75          ==  getfloat("\ninput 3//4, then press return: ")
	    @test   Base.pi/2     ==  getfloat("\ninput 'pi/2', then press return: ")
	    @test   Base.e        ==  getfloat("\ninput 'e', then press return: ")
	    @test   Base.e^3      ==  getfloat("\ninput 'e^3', then press return: ")
	    @test   Base.sin(0.1) ==  getfloat("\ninput 'sin(0.1)', then press return: ")
	    @test   isa( getfloat("\nthe first time input '1.2+2im': "), Float64)

	end #if 
    end # testset
	
	
    @testset "reading from CSV" begin
		
		datadirectory = joinpath(homedir(), "GeoEfficiency", "temptemp"); isdir(datadirectory) || mkdir(datadirectory)
		detectorfile = joinpath(datadirectory, "_Detector_test.csv")
		
		hightfile = joinpath(datadirectory, "_hight_test.csv")
		
		try

		
		info("write and read  - input type{Int}")

			@test  GeoEfficiency.writecsv_head(hightfile, [0, 1, 2, 3, 4, 5, 10, 15, 20,], ["SrcHight"])  ==  nothing
		    @test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
			
		info("rewrite, read and sort  - input type{Int}")
			@test  GeoEfficiency.writecsv_head(hightfile, [3, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
			
		info("rewrite, read and sort - input type{Rational-treated as any}")
			@test  GeoEfficiency.writecsv_head(hightfile, [3//2, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
			
		info("rewrite, read and sort - input type{Float64}")
			@test  GeoEfficiency.writecsv_head(hightfile, [3.0, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, 3, 4, 5, 10, 15, 20,]
			
		info("rewrite, read and sort - input type{Irrational....}")
			@test  GeoEfficiency.writecsv_head(hightfile, [pi, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0, 1, 2, pi, 4, 5, 10, 15, 20,]
			
		info("invalid data type {Unionall}")
			@test  GeoEfficiency.writecsv_head(hightfile, ["3.0", 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) ==  [0, 1, 2, 3, 4, 5, 10, 15, 20,]

		info("invalid data type {String}")
			@test  GeoEfficiency.writecsv_head(hightfile, ["pi", "20", "4", "0", "1", "2", "5", "10", "15",], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]
		
		info("invalid data type {Complex}")
			@test  GeoEfficiency.writecsv_head(hightfile, [3.0+0.0im, 20, 4, 0, 1, 2, 5, 10, 15,], ["SrcHight"])  ==  nothing
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]			
		
		info("missing file")
			rm(hightfile, force=true, recursive=true)
			@test  GeoEfficiency.read_from_csvFile("_hight_test.csv", datadirectory) == [0.0]			

		
		info(" Detectors write and read  - input type{Int}")	
			@test  GeoEfficiency.writecsv_head(detectorfile, detector_info_array, ["CryRaduis"	 "CryLength" "HoleRadius" "HoleDepth"])  ==  nothing
			@test  Set(GeoEfficiency.detector_info_from_csvFile("_Detector_test.csv", datadirectory)) == Set(detectors)

		info(" Detectors - missing file\n")	
			rm(datadirectory, force=true, recursive=true)
			@test_throws GeoEfficiency.detector_info_from_csvFile("_Detector_test.csv", datadirectory) SystemError
			
		catch	
			rm(datadirectory, force=true, recursive=true)	
		
		end #try
		
	end # testset
	
	
    @testset "getDetectors" begin
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

		detector_info_array= ["5" "0" "0" "0"; "10" "0" "0" "0"]
		isempty(detector_info_array) && @test_throws getDetectors(detector_info_arrayy,false)  Exception	
		detector_info_array= [5+1im 0 0 0; 5 10 0 0; 5 10 2 0; 5 10 2 5]
		isempty(detector_info_array) && @test_throws getDetectors(detector_info_array,false)  Exception

    end # testset
	
end # testset
