#include("E:\\Users\\DrKra\\.julia\\dev\\GeoEfficiency\\docs\\make.jl")
#=
cdir= pwd()
@info("Working Directory: ", @__DIR__)
cd(@__DIR__) 
=#

using Documenter, GeoEfficiency

# Documenter Setup.

const PAGES = [
    "Home" => "index.md",
    "Manual" => [
		"manual/GeoEfficiency.md",
        "manual/Physics_Model.md",
        "manual/Input_Interface.md",
        "manual/Calculations.md",
        "manual/Output_Interface.md",
     ],
]

makedocs(
    modules = [GeoEfficiency],
    clean = false,
    format = :html,
    sitename = "GeoEfficiency.jl",
    authors = "Mohamed E. Krar",
    pages = PAGES,
)

deploydocs(
    julia = "nightly",
    repo = "github.com/DrKrar/GeoEfficiency.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
# cd(cdir)




#=
# makedocs()
makedocs(
    build     = joinpath(pwd(), "build/html/en"),
    modules   = [GeoEfficiency],
    clean     = false,
    doctest   = "doctest" in ARGS,
    linkcheck = "linkcheck" in ARGS,
    linkcheck_ignore = ["https://bugs.kde.org/show_bug.cgi?id=136779"], # fails to load from nanosoldier?
    strict    = true,
    checkdocs = :none,
    format    = "pdf" in ARGS ? :latex : :html,
    sitename  = "The GeoEfficiency Software Pakage",
    authors   = "Mohamed E. Krar",
    analytics = "UA-28835595-6",
    pages     = PAGES,
)

deploydocs(
	repo = "github.com/DrKrar/GeoEfficiency.git",
	target = "build/html/en",
	dirname = "en",
	deps = nothing,
	make = nothing,
)
=#