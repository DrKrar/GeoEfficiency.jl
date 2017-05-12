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
		warn("`GeoEfficiency` folder: could not be created, rebuild the package `Pkg.build("GeoEfficiency")`to be able to use patch mode.)
	end #if
end #if

# install Package `QuadGK` for julia 0.6- or hiegher.
#if VERSION < v"0.6.0-dev"
#else
#	try
#		info("Installing Package `QuadGK` for julia 0.6- or higher .....")
#		Pkg.add("QuadGK");
#	catch
#		warn("`QuadGK` package instllation did not complete")
#	end #itryend
#end #if
