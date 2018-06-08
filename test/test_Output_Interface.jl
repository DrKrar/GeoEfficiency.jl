#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************
using Compat
using Compat: occursin

print("\n\t"); @info("Testing `Output Interface`...")
@testset "Output Interface" begin
	@test G.checkResultsDirs() == nothing

print("\n\t"); @info("Testing `calc` on CylDetector, WellDetector`...")
	pnt = Point(1)
	cylDet = Detector(5, 10); wellDet = Detector(5, 4, 3.2, 2)
	@testset "function `calc` on CylDetector, WellDetector" for 
	SrcRadius = Real[1, 1//2, e, pi, 1.0], 
	SrcLength = Real[1, 1//2, e, pi, 1.0]

		@test calc(cylDet,  (pnt, SrcRadius , SrcLength))    == nothing
		@test calc(wellDet, (pnt, SrcRadius , SrcLength))    == nothing
     end #testset


print("\n\t"); @info("Testing `calcN`...")
	@testset "function `calcN`" for 	
	cylDet = [Detector(5,10), Detector(eps(),0)], #, wellDet= Detector(5, 4, 3, 2)
	consol_input = ["4 0 1 2 ", "4 0 1 2 " * "d " * "4 0 1 2 ", "4 0 1 2 " * "n " * "10 5 0 " * "4 0 1 2 "]
		@test exec_consol_unattended(calcN, consol_input, Fn_ARGs =[cylDet])  == nothing	 
		@test exec_consol_unattended(calcN, "10 5 0 " * consol_input)      == nothing	
 	end #testset

print("\n\t"); @info("Testing `batch` & `_batch`...")    
	@testset "function `batch`" begin
		@test G._batch(Val{true},  CylDetector(eps(0.1)), [0.0], [0.0], [0.0], [0.0])[2][end] ≈ 0.5
		@test G._batch(Val{false}, CylDetector(eps(0.2)), [0.0], [0.0], [0.0], [0.0])[2][end] ≈ 0.5
		@test isnan(G._batch(Val{true}, CylDetector(eps(0.3)), [0.0], [1.0], [0.0],[0.0])[2][end])
		@test isnan(G._batch(Val{false}, CylDetector(eps(0.4)), [0.0], [1.0], [0.0],[0.0])[2][end])
		
		acylDetector = CylDetector(eps(0.5)); path = batch(acylDetector, [0.0])
		@test occursin( G.id(acylDetector), path)
		@test readdlm(path,',')[2,end] ≈ 0.5	

		path = batch(acylDetector, [0.0], [0.0], [0.0],[0.0],false)
		@test occursin(G.id(acylDetector), path)
		@test readdlm(path,',')[2,end] ≈ 0.5	

		path = batch([acylDetector], [0.0])
		@test occursin.(G.id(acylDetector), path) |> any
		every_path::Vector{String} = path

		path = batch([acylDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(acylDetector), path) |> any
		append!(every_path, path)

		aBDetector = BoreDetector(eps(0.5), eps(0.4), eps(0.2)); path = batch([aBDetector], [0.0])
		@test occursin.(G.id(aBDetector), path) |> any
		append!(every_path, path)

		aWDetector = WellDetector(eps(0.5), eps(0.4), eps(0.2), eps(0.1)); path = batch([aWDetector], [0.0])
		@test occursin.(G.id(aWDetector), path) |> any
		append!(every_path, path)

		path = batch([aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(aWDetector), path) |> any
		append!(every_path, path)

		path = batch([acylDetector, aWDetector], [0.0])
		@test occursin.(G.id(aWDetector), path) |> any
		append!(every_path, path)

		path = batch([acylDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(acylDetector), path) |> any
		@test occursin.(G.id(aWDetector)  , path) |> any
		append!(every_path, path)

		path = batch([acylDetector, aBDetector], [0.0])
		@test occursin.(G.id(acylDetector), path) |> any
		append!(every_path, path)

		path = batch([acylDetector, aBDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(acylDetector), path) |> any
		@test occursin.(G.id(aBDetector)  , path) |> any
		append!(every_path, path)
		
		path = batch([aBDetector, aWDetector], [0.0])
		@test occursin.(G.id(aBDetector), path) |> any
		@test occursin.(G.id(aWDetector), path) |> any
		append!(every_path, path)

		path = batch([aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(aBDetector), path) |> any
		@test occursin.(G.id(aWDetector), path) |> any
		append!(every_path, path)

		acylDetector = CylDetector(eps(0.6)); path = batch([acylDetector, aBDetector, aWDetector], [0.0]) 
		@test occursin.(G.id(acylDetector), path) |> any
		@test occursin.(G.id(aBDetector), path) |> any
		@test occursin.(G.id(aWDetector), path) |> any
	chmod(path[1], 0o100444); chmod(path[2], 0o100444); chmod(path[3], 0o100444);
	append!(every_path, path)
		path = batch([acylDetector, aBDetector, aWDetector], [0.0])
		@test occursin.("_" * G.id(acylDetector), path) |> any
		@test occursin.("_" * G.id(aBDetector)  , path) |> any
		@test occursin.("_" * G.id(aWDetector)  , path) |> any
	append!(every_path, path)
	chmod(path[1],0o777); chmod(path[2], 0o777); chmod(path[3], 0o777); # 0o100666
		
		acylDetector = CylDetector(eps(0.7)); path = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.(G.id(acylDetector), path) |> any
		@test occursin.(G.id(aBDetector)  , path) |> any
		@test occursin.(G.id(aWDetector)  , path) |> any
	append!(every_path, path)
	chmod(path[1], 0o100444); chmod(path[2], 0o100444); chmod(path[3], 0o100444);
		path = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
		@test occursin.("_" * G.id(acylDetector), path) |> any
		@test occursin.("_" * G.id(aBDetector)  , path) |> any
		@test occursin.("_" * G.id(aWDetector)  , path) |> any
	append!(every_path, path)
	chmod(path[1],0o777); chmod(path[2], 0o777); chmod(path[3], 0o777);
	
				
		@test append!(every_path, batch([eps() 0], [0.0]))|> eltype === String
		@test append!(every_path, batch([eps() 0], [0.0], [0.0], [0.0], [0.0],false)) |> eltype === String
		@test append!(every_path, batch([1.0 0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1.0 0], [0.0], [0.0], [0.0], [0.0],false)) |> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false)) |> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
		@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0],false)) |> eltype === String
		@test append!(every_path, batch([e pi], [0.0]))|> eltype === String
		@test append!(every_path, batch([e pi], [0.0], [0.0], [0.0], [0.0],false)) |> eltype === String

		@test append!(every_path, batch([5.0 4 3], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 3], [0.0], [0.0],[0.0],[0.0],false)) |> eltype === String
		@test append!(every_path, batch([5.0 4 3//1], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 3//1], [0.0], [0.0],[0.0],[0.0],false)) |> eltype === String
		@test append!(every_path, batch([5.0 4 pi], [0.0]))|> eltype === String
		@test append!(every_path, batch([5.0 4 pi], [0.0], [0.0],[0.0], [0.0], false)) |> eltype === String

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
