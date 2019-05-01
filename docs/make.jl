#**************************************************************************************
# make.jl
# =============== part of the GeoEfficiency.jl package.
#
# script for building documentation of the GeoEfficiency.jl package.
#
#  _args = ["clean", "doctest"]
#  include(raw"C:\Users\Mohamed\.julia\dev\GeoEfficiency\docs\make.jl")
#**************************************************************************************

using Documenter
using GeoEfficiency

_args = @isdefined(_args) ? _args : ARGS
const PAGES = Any[
    "Home" => "Guid.md",
    "Manual" => [
		"manual/GeoEfficiency.md",
        #"manual/Error.md",
        #"manual/Input_Console.md",
        "manual/Physics_Model.md",
        "manual/Calculations.md",
        "manual/Output_Interface.md",
        "manual/Input_Batch.md",
     ],
    
    "Development" => "manual/Development.md",
    "Index" => "list.md",
    "LICENSE" => "../LICENSE.md",
]

const formats = Any[
    Documenter.HTML(
        prettyurls = false,  #get(ENV, "CI", nothing) == "true",
        canonical = "https://github.com/DrKrar/GeoEfficiency.jl/v0.9.4-dev/",
        
    ), 
    
]


makedocs(
    format  = formats,
    modules = [GeoEfficiency],
    clean   = "clean" in _args,
    doctest = "doctest" in _args,
    sitename= "GeoEfficiency.jl",
    authors = "Mohamed E. Krar",
    pages   = PAGES,
    assets  = ["assets/custom.css"],
)


const REPO = "github.com/DrKrar/GeoEfficiency.jl.git" # "github.com/GeoEfficiency/GeoEfficiency.github.io.git" 
const VERSIONS =["stable" => "v^", "v#.#", "dev" => "dev"]  # order of versions in drop down menu.
const BRANCH = "gh-pages" # "master"

# Deploy HTML pages
@info "Deploying HTML pages"
deploydocs(
    repo = REPO,
    branch = BRANCH, #"gh-pages"
    versions = VERSIONS,
)
