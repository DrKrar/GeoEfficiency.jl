#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************



@testset "Output Interface" begin
  
	@testset "function `calc` on CylDetector" begin 
	cryLength = 10
		@test calc(Detector(5,cryLength),(Point(1),1, 1))    == nothing
		@test calc(Detector(5,cryLength),(Point(1),1, 1//2)) == nothing
		@test calc(Detector(5,cryLength),(Point(1),1, pi))   == nothing
		@test calc(Detector(5,cryLength),(Point(1),1, 1.0))  == nothing

		@test calc(Detector(5,cryLength),(Point(1),1//2, 1))    == nothing
		@test calc(Detector(5,cryLength),(Point(1),1//2, 1//2)) == nothing
		@test calc(Detector(5,cryLength),(Point(1),1//2, pi))   == nothing
		@test calc(Detector(5,cryLength),(Point(1),1//2, 1.0))  == nothing

		@test calc(Detector(5,cryLength),(Point(1),e, 1))    == nothing
		@test calc(Detector(5,cryLength),(Point(1),e, 1//2)) == nothing
		@test calc(Detector(5,cryLength),(Point(1),e, pi))   == nothing #
		@test calc(Detector(5,cryLength),(Point(1),e, 1.0))  == nothing

		@test calc(Detector(5,cryLength),(Point(1),1.0, 1))    == nothing
		@test calc(Detector(5,cryLength),(Point(1),1.0, 1//2)) == nothing
		@test calc(Detector(5,cryLength),(Point(1),1.0, pi))   == nothing
		@test calc(Detector(5,cryLength),(Point(1),1.0, 1.0))  == nothing
     end #testset
	 
	@testset "function `calc` on WellDetector" begin 
	holeRadius = 3 
	holeDepth  = 2
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1))    == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1//2)) == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, pi))   == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1, 1.0))  == nothing

		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1))    == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1//2)) == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, pi))   == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1//2, 1.0))  == nothing

		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1))    == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1//2)) == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, pi))   == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),e, 1.0))  == nothing

		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1))    == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1//2)) == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, pi))   == nothing
		@test calc(Detector(5, 4, holeRadius, holeDepth),(Point(1),1.0, 1.0))  == nothing
		end #testset_for

info("test `_batch` & `batch`...")    
	@testset "function `batch`" begin
		@test G._batch(Val{true},  CylDetector(eps(0.1)), [0.0], [0.0], [0.0], [0.0])[2][end] ≈ 0.5
		@test G._batch(Val{false}, CylDetector(eps(0.2)), [0.0], [0.0], [0.0], [0.0])[2][end] ≈ 0.5
		@test isnan(G._batch(Val{true}, CylDetector(eps(0.3)), [0.0], [1.0], [0.0],[0.0])[2][end])
		@test isnan(G._batch(Val{false}, CylDetector(eps(0.4)), [0.0], [1.0], [0.0],[0.0])[2][end])
		
		acylDetector = CylDetector(eps(0.5)); path = batch(acylDetector, [0.0])
		@test contains(path, G.id(acylDetector))
		@test readcsv(path)[2,end] ≈ 0.5	

		path = batch(acylDetector, [0.0], [0.0], [0.0],[0.0],false)
		@test contains(path, G.id(acylDetector))
		@test readcsv(path)[2,end] ≈ 0.5	

		path = batch([acylDetector], [0.0])
		@test contains(contains ,path, G.id(acylDetector))
		every_path::Vector{String} = path

		path = batch([acylDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(acylDetector))
		append!(every_path, path)

		aBDetector = BoreDetector(eps(0.5), eps(0.4), eps(0.2)); path = batch([aBDetector], [0.0])
		@test contains(contains ,path, G.id(aBDetector))
		append!(every_path, path)

		aWDetector = WellDetector(eps(0.5), eps(0.4), eps(0.2), eps(0.1)); path = batch([aWDetector], [0.0])
		@test contains(contains, path, G.id(aWDetector))
		append!(every_path, path)

		path = batch([aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(aWDetector))
		append!(every_path, path)

		path = batch([acylDetector, aWDetector], [0.0])
		@test contains(contains ,path, G.id(aWDetector))
		append!(every_path, path)

		path = batch([acylDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(acylDetector))
		@test contains(contains ,path, G.id(aWDetector))
		append!(every_path, path)

		path = batch([acylDetector, aBDetector], [0.0])
		@test contains(contains ,path, G.id(acylDetector))
		append!(every_path, path)

		path = batch([acylDetector, aBDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(acylDetector))
		@test contains(contains ,path, G.id(aBDetector))
		append!(every_path, path)
		
		path = batch([aBDetector, aWDetector], [0.0])
		@test contains(contains ,path, G.id(aBDetector))
		@test contains(contains ,path, G.id(aWDetector))
		append!(every_path, path)

		path = batch([aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(aBDetector))
		@test contains(contains ,path, G.id(aWDetector))
		append!(every_path, path)

		acylDetector = CylDetector(eps(0.6)); path = batch([acylDetector, aBDetector, aWDetector], [0.0]) 
		@test contains(contains ,path, G.id(acylDetector))
		@test contains(contains ,path, G.id(aBDetector))
		@test contains(contains ,path, G.id(aWDetector))
	chmod(path[1], 0o100444); chmod(path[2], 0o100444); chmod(path[3], 0o100444);
	append!(every_path, path)
		path = batch([acylDetector, aBDetector, aWDetector], [0.0])
		@test contains(contains ,path, "_" * G.id(acylDetector))
		@test contains(contains ,path, "_" * G.id(aBDetector))
		@test contains(contains ,path, "_" * G.id(aWDetector))
	append!(every_path, path)
	chmod(path[1],0o777); chmod(path[2], 0o777); chmod(path[3], 0o777); # 0o100666
		
		acylDetector = CylDetector(eps(0.7)); path = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, G.id(acylDetector))
		@test contains(contains ,path, G.id(aBDetector))
		@test contains(contains ,path, G.id(aWDetector))
	append!(every_path, path)
	chmod(path[1], 0o100444); chmod(path[2], 0o100444); chmod(path[3], 0o100444);
		path = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test contains(contains ,path, "_" * G.id(acylDetector))
		@test contains(contains ,path, "_" * G.id(aBDetector))
		@test contains(contains ,path, "_" * G.id(aWDetector))
	append!(every_path, path)
	chmod(path[1],0o777); chmod(path[2], 0o777); chmod(path[3], 0o777);
	
				
		@test append!(every_path, batch([eps() 0], [0.0]))|> eltype === String
		@test append!(every_path, batch([eps() 0], [0.0], [0.0], [0.0], [0.0],false))|> eltype === String
		@test append!(every_path, batch([1.0 0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1.0 0], [0.0], [0.0], [0.0], [0.0],false))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false))|> eltype === String
		@test append!(every_path, batch([e pi], [0.0]))|> eltype === String
		@test append!(every_path, batch([e pi], [0.0], [0.0], [0.0], [0.0],false))|> eltype === String

		@test append!(every_path, batch([5.0 4 3], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 3], [0.0], [0.0],[0.0],[0.0],false))|> eltype === String
		@test append!(every_path, batch([5.0 4 3//1], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 3//1], [0.0], [0.0],[0.0],[0.0],false))|> eltype === String
		@test append!(every_path, batch([5.0 4 pi], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 pi], [0.0], [0.0],[0.0], [0.0], false))		=== String

		@test append!(every_path, batch([5.0 4 3 2], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 3 2], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

		@test append!(every_path, batch([acylDetector, aWDetector], [0.0]))|> eltype === String
		@test append!(every_path, batch([acylDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

		@test append!(every_path, batch([acylDetector, aBDetector], [0.0]))|> eltype === String
		@test append!(every_path, batch([acylDetector, aBDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

		@test append!(every_path, batch([aBDetector, aWDetector], [0.0]))|> eltype === String
		@test append!(every_path, batch([aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

		@test append!(every_path, batch([acylDetector, aBDetector, aWDetector], [0.0]))|> eltype === String
		@test append!(every_path, batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String
		
		try 
		G.detector_info_from_csvFile()
		if  [0.0] != G.read_from_csvFile(G.srcHeights, G.datadir)
			setSrcToPoint(true);  
			@test append!(every_path, batch())|> eltype === String
			
			if [0.0] != G.read_from_csvFile(G.srcRadii, G.datadir) 
				setSrcToPoint(false); 
				@test append!(every_path, batch())|> eltype === String
			end
		end	
	end

	rm.(every_path,  force=true)
	#rm.(batch([aWDetector], [0.0]))
	#rm.(batch([aWDetector], [0.0], [0.0], [0.0],[0.0],false))
	for cr = 0.0:0.1:0.7	
		rm.(batch([Detector(eps(cr))], [0.0], [0.0], [0.0],[0.0],false) ; force=true)
		rm.(batch([Detector(eps(cr))], [0.0]) ; force=true)
	end
	end  #begin_testset
println()
end  #begin_testset
