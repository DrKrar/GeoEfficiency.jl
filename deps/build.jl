#**************************************************************************************
# build.jl
# =============== part of the GeoEfficiency.jl package.
#
# this file excuted at instlation time.
#
#**************************************************************************************


# creating `.GeoEfficiency` folder at the home directory.

@info("Creating '.GeoEfficiency' data folder at '$(homedir())'.....")

@info("Creating '.GeoEfficiency' folder at '$(homedir())'.....")
try
	cp(joinpath(dirname(@__FILE__),".batch"), joinpath(homedir(),".GeoEfficiency"))
catch err
	if isdir(joinpath(homedir(),".GeoEfficiency"))
		@warn("`.GeoEfficiency` data folder already exist in your home directory.")
	else	
		@error("""'.GeoEfficiency' data folder: could not be created,
		\n  the package may be unable to work in patch mode. 
		\n  Try 'import Pkg; Pkg.build("GeoEfficiency")' to rebuild.""")
	end #if
end #try
