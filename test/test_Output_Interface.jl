#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************

using Compat
using Compat: occursin


@testset "GeoEfficiecny.checkResultsDirs" begin 
	@test G.checkResultsDirs() == nothing
end #testset_checkResultsDirs


@debug("calc - CylDetector, WellDetecto")
let pnt::Point = Point(1),
	cylDet::CylDetector = Detector(5, 10),
	wellDet::WellDetector = Detector(5, 4, 3.2, 2)
	
	@testset "calc - CylDetector, WellDetecto" for 
	SrcRadius = Real[1, 1//2, e, pi, 1.0], 
	SrcLength = Real[1, 1//2, e, pi, 1.0]

		@test calc(cylDet,  (pnt, SrcRadius , SrcLength))    == nothing
		@test calc(wellDet, (pnt, SrcRadius , SrcLength))    == nothing
	end #testset_calc
end #let


@debug("calcN")
@testset "calcN - $consol_input" for 
consol_input = ["4 0 1 2 Q", 
				"4 0 1 3 " * "d " * "4 0 1 4 Q", 
				"4 0 1 5 " * "n " * "11 6 0 " * "4 0 1 6 Q"]

	@test H.exec_consol_unattended(calcN, consol_input, Fn_ARGs =[Detector(5, 10)])  == nothing
	@test H.exec_consol_unattended(calcN,  consol_input, Fn_ARGs =[Detector(eps())])  == nothing
	@test H.exec_consol_unattended(calcN, "13 7 0 " * consol_input)      == nothing
	@test H.exec_consol_unattended(calcN, "13 7 0 Q " * consol_input)      == nothing	
end #testset_calcN



@debug("writecsv_head")    
@testset "writecsv_head" begin
	# `writecsv_head` tests in the `reading_from _CSV` testset in test_Output_Interface.
end #testset_writecsv_head


@debug("GeoEfficiecny._batch")
@testset "GeoEfficiecny._batch" for	isSrcPoint = [true, false]

	rtrn = G._batch(Val(isSrcPoint),  CylDetector(eps(0.1)), [0.0], [0.0], [0.0], [0.0])
	@test typeof(rtrn) <: Tuple{Detector, Matrix{Float64}, String}
	@test rtrn[2][end] ≈ 0.5
	rm(rtrn[end]; force=true)

	rtrn = G._batch(Val(isSrcPoint), CylDetector(eps(0.1)), [0.0], [1.0], [0.0],[0.0])
	@test typeof(rtrn) <: Tuple{Detector, Matrix{Float64}, String}
	@test rtrn[2][end] |> isnan
	rm(rtrn[end]; force=true)

end #testset_GeoEfficiecny._batch


@debug("batch")    
@testset "batch" begin
	local acylDetector::CylDetector = CylDetector(eps(0.5))
	local path::String = batch(acylDetector, [0.0])
	@test occursin( G.id(acylDetector), path)
	@test readdlm(path,',')[2,end] ≈ 0.5

	path = batch(acylDetector, [0.0], [0.0], [0.0],[0.0],false)
	@test occursin(G.id(acylDetector), path)
	@test readdlm(path,',')[2,end] ≈ 0.5	

	local paths::Vector{String} = batch([acylDetector], [0.0]) # in fact `paths` is a one element vector
	@test occursin.(G.id(acylDetector), paths) |> any
	local every_path::Vector{String} = paths

	paths = batch([acylDetector], [0.0], [0.0], [0.0],[0.0],false)
	@test occursin.(G.id(acylDetector), paths) |> any
	append!(every_path, paths)

	local aBDetector = BoreDetector(eps(0.5), eps(0.4), eps(0.2)); 
	paths = batch([aBDetector], [0.0])
	@test occursin.(G.id(aBDetector), paths) |> any
	append!(every_path, paths)

	local aWDetector = WellDetector(eps(0.5), eps(0.4), eps(0.2), eps(0.1))
	paths = batch([aWDetector], [0.0])
	@test occursin.(G.id(aWDetector), paths) |> any
	append!(every_path, paths)

	paths = batch([aWDetector], [0.0], [0.0], [0.0],[0.0],false)
	@test occursin.(G.id(aWDetector), paths) |> any
	append!(every_path, paths)

	paths = batch([acylDetector, aWDetector], [0.0])
	@test occursin.(G.id(aWDetector), paths) |> any
	append!(every_path, paths)

	paths = batch([acylDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
	@test occursin.(G.id(acylDetector), paths) |> any
	@test occursin.(G.id(aWDetector)  , paths) |> any
	append!(every_path, paths)

	paths = batch([acylDetector, aBDetector], [0.0])
	@test occursin.(G.id(acylDetector), paths) |> any
	append!(every_path, paths)

	paths = batch([acylDetector, aBDetector], [0.0], [0.0], [0.0],[0.0],false)
	@test occursin.(G.id(acylDetector), paths) |> any
	@test occursin.(G.id(aBDetector)  , paths) |> any
	append!(every_path, paths)
	
	paths = batch([aBDetector, aWDetector], [0.0])
	@test occursin.(G.id(aBDetector), paths) |> any
	@test occursin.(G.id(aWDetector), paths) |> any
	append!(every_path, paths)

	paths = batch([aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false)
	@test occursin.(G.id(aBDetector), paths) |> any
	@test occursin.(G.id(aWDetector), paths) |> any
	append!(every_path, paths)

	acylDetector = CylDetector(eps(0.6), 5)
	paths = batch([acylDetector, aBDetector, aWDetector], [0.0]) 
	@test occursin.(G.id(acylDetector), paths) |> any
	@test occursin.(G.id(aBDetector), paths) |> any
	@test occursin.(G.id(aWDetector), paths) |> any
chmod.(paths, 0o100444)	#chmod(paths[1], 0o100444); chmod(paths[2], 0o100444); chmod(paths[3], 0o100444); chmod.(paths, 0o100444)
append!(every_path, paths)
	paths = batch([acylDetector, aBDetector, aWDetector], [0.0])
	@test occursin.("_" * G.id(acylDetector), paths) |> any
	@test occursin.("_" * G.id(aBDetector)  , paths) |> any
	@test occursin.("_" * G.id(aWDetector)  , paths) |> any
append!(every_path, paths)
chmod.(paths, 0o777)	#chmod(paths[1],0o777); chmod(paths[2], 0o777); chmod(paths[3], 0o777); # 0o100666

	acylDetector = CylDetector(eps(0.7), 5)
	paths = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0], false)
	@test occursin.(G.id(acylDetector), paths) |> any
	@test occursin.(G.id(aBDetector)  , paths) |> any
	@test occursin.(G.id(aWDetector)  , paths) |> any
append!(every_path, paths)
chmod.(paths, 0o100444)	#chmod(paths[1], 0o100444); chmod(paths[2], 0o100444); chmod(paths[3], 0o100444);
	paths = batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0], false)
	@test occursin.("_" * G.id(acylDetector), paths) |> any
	@test occursin.("_" * G.id(aBDetector)  , paths) |> any
	@test occursin.("_" * G.id(aWDetector)  , paths) |> any
append!(every_path, paths)
chmod.(paths, 0o777)	#chmod(paths[1],0o777); chmod(paths[2], 0o777); chmod(paths[3], 0o777);

		
	@test append!(every_path, batch([eps() 0], [0.0]))|> eltype === String
	@test append!(every_path, batch([eps() 0], [0.0], [0.0], [0.0], [0.0], false)) |> eltype === String
	@test append!(every_path, batch([1.0 0], [0.0]))|> eltype === String
	@test append!(every_path, batch([1.0 0], [0.0], [0.0], [0.0], [0.0], false)) |> eltype === String
	@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
	@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0], false)) |> eltype === String
	@test append!(every_path, batch([1//2 0.0], [0.0]))|> eltype === String
	@test append!(every_path, batch([1//2 0.0], [0.0], [0.0], [0.0], [0.0], false)) |> eltype === String
	@test append!(every_path, batch([e pi], [0.0]))|> eltype === String
	@test append!(every_path, batch([e pi], [0.0], [0.0], [0.0], [0.0], false)) |> eltype === String

	@test append!(every_path, batch([5.0 4 3], [0.0]))|> eltype === String
	@test append!(every_path, batch([5.0 4 3], [0.0], [0.0],[0.0],[0.0],false)) |> eltype === String
	@test append!(every_path, batch([5.0 4 3//1], [0.0]))|> eltype === String
	@test append!(every_path, batch([5.0 4 3//1], [0.0], [0.0],[0.0],[0.0],false)) |> eltype === String
	@test append!(every_path, batch([5.0 4 pi], [0.0]))|> eltype === String
	@test append!(every_path, batch([5.0 4 pi], [0.0], [0.0],[0.0], [0.0], false)) |> eltype === String

	@test append!(every_path, batch([5.0 4 3 2], [0.0]))|> eltype === String
	@test append!(every_path, batch([5.0 4 3 2], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

		#=@test append!(every_path, batch([acylDetector, aWDetector], [0.0]))|> eltype === String
	@test append!(every_path, batch([acylDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

	@test append!(every_path, batch([acylDetector, aBDetector], [0.0]))|> eltype === String
	@test append!(every_path, batch([acylDetector, aBDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String

	@test append!(every_path, batch([aBDetector, aWDetector], [0.0]))|> eltype === String
	@test append!(every_path, batch([aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String
		=#
	@test append!(every_path, batch([acylDetector, aBDetector, aWDetector], [0.0]))|> eltype === String
	@test append!(every_path, batch([acylDetector, aBDetector, aWDetector], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String
		

	G.detector_info_from_csvFile()
	if  [0.0] != G.read_from_csvFile(G.srcHeights, G.dataDir)
		setSrcToPoint(true);  
		@test_skip append!(every_path, batch())|> eltype === String
			
		if [0.0] != G.read_from_csvFile(G.srcRadii, G.dataDir) 
			setSrcToPoint(false); 
			@test_skip append!(every_path, batch())|> eltype === String
		end #if
	end	#if


	#rm.(batch([aWDetector], [0.0]))
	#rm.(batch([aWDetector], [0.0], [0.0], [0.0],[0.0],false))
	#=for cr = 0.2:0.1:0.7	
		@test append!(every_path, batch([Detector(11, eps(cr))], [0.0], [0.0], [0.0],[0.0],false))|> eltype === String
		@test append!(every_path, batch([Detector(22, eps(cr))], collect(0.0:0.1:10), [0.0], [0.0],[0.0],false))|> eltype === String
		@test append!(every_path, batch([Detector(33, eps(cr))], [0.0]))|> eltype === String
	end #for
	=#

try 
	rm.(every_path)
catch err
	@error "show(err)"
rm.(every_path; force=true)
end #try
end #testset_batch
