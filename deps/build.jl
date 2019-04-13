#**************************************************************************************
# build.jl
# =============== part of the GeoEfficiency.jl package.
#
# this file excuted at instlation time.
#
#**************************************************************************************


# creating `GeoEfficiency` folder at the home directory.

@info("Creating 'GeoEfficiency' folder at '$(homedir())'.....")
try
	cp(joinpath(dirname(@__FILE__),".batch"), joinpath(homedir(),"GeoEfficiency"))
catch err
	if isdir(joinpath(homedir(),"GeoEfficiency"))
		@warn("`GeoEfficiency` folder already exist.")
	else	
		@error("""'GeoEfficiency' folder: could not be created,
		\n  the package may be unable to work in patch mode. Try 'import Pkg; Pkg.build("GeoEfficiency")' to rebuild.""")
	end #if
end #try
