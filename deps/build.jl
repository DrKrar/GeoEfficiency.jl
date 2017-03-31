#######################################################################

# print to stderr, since that is where Pkg prints its messages
eprintln(x...) = println(STDERR, x...)


# creating `GeoEfficiency` folder at the home directory.
info("Creating `GeoEfficiency` folder at '$(homedir())'.....")
try
	cp(joinpath(Pkg.dir("GeoEfficiency"),".batch"), joinpath(homedir(),"GeoEfficiency"))

catch
	if isdir(joinpath(homedir(),"GeoEfficiency"))
		warn("`GeoEfficiency` folder allready exist.")
	else
		warn("`GeoEfficiency` folder: could not be created.")
	end #if
end #if

# install Package `QuadGK` for julia 0.6- or hiegher.
if VERSION < v"0.6.0-dev"
else
	try
		info("Installing Package `QuadGK` for julia 0.6- or hiegher .....")
		Pkg.add("QuadGK");
		using QuadGK;  
	catch
		warn("`QuadGK` package instllation did not complete")
	end #itryend
end #if