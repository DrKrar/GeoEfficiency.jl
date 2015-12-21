#######################################################################

# print to stderr, since that is where Pkg prints its messages
eprintln(x...) = println(STDERR, x...)


# try to copy the `.batch` folder and its contents to the home directory.
try
   cp(joinpath(Pkg.dir("GeoEfficiency"),".batch"), joinpath(homedir(),".batch"))
catch
   isdir(joinpath(homedir(),".batch")) || warn(".batch folder: could not be created.")
   eprintln("copy .batch folder from:-\n\t", Pkg.dir("GeoEfficiency"), "\n\nto the home dirctory at:-\n\t", homedir())
end