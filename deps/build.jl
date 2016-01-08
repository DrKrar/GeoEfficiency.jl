#######################################################################

# print to stderr, since that is where Pkg prints its messages
eprintln(x...) = println(STDERR, x...)


# creating `GeoEfficiency` folder at the home directory.
println("INFO: Creating 'GeoEfficiency' folder at '$(homedir())'.....")
try
	cp(joinpath(Pkg.dir("GeoEfficiency"),".batch"), joinpath(homedir(),"GeoEfficiency"))

catch
	if isdir(joinpath(homedir(),"GeoEfficiency"))
		warn("'GeoEfficiency' folder allready exist.")
	else
		warn("'GeoEfficiency' folder: could not be created.")
	end
end