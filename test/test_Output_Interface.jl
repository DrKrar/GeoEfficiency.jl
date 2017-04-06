#**************************************************************************************
# test_Output_Interface.jl
# ======================== part of the GeoEfficiency.jl package.
# 
# 
# 
#**************************************************************************************


info("Statrting `batch` test...")
@testset begin
	println()
	info("special cases for cylinderical detector; very restrict test")
  @test_throws MethodError batch()
  end  #begin_testset
