#######################################################################

# print to stderr, since that is where Pkg prints its messages
eprintln(x...) = println(STDERR, x...)


# creating `GeoEfficiency` folder at the home directory.
info("Creating `GeoEfficiency` folder at '$(homedir())'.....")

try
	cp(joinpath(dirname(@__FILE__),".batch"), joinpath(homedir(),"GeoEfficiency"))

catch err
	if isdir(joinpath(homedir(),"GeoEfficiency"))
		warn("`GeoEfficiency` folder allready exist.")
	else
		warn("""GeoEfficiency` folder: could not be created, rebuild the package `Pkg.build("GeoEfficiency")`to be able to use patch mode.""")
	end #if
end #if
