#**************************************************************************************
# make.jl
# =============== part of the GeoEfficiency.jl package.
#
# script for building documentation of the GeoEfficiency.jl package.
#
#  _args = ["clean", "doctest"]
#  include(raw"C:\Users\Mohamed\.julia\dev\GeoEfficiency\docs\mkdocs.jl")
#**************************************************************************************

using Documenter, DocumenterMarkdown
using GeoEfficiency

_args = @isdefined(_args) ? _args : ARGS
const PAGES = Any[
    "Home" => "index.md",
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
    "LICENSE" => "LICENSE.md",
]


makedocs(
    format  = Markdown(),
    modules = [GeoEfficiency],
    clean   = "clean" in _args,
    doctest = "doctest" in _args,
    sitename= "GeoEfficiency.jl",
    authors = "Mohamed E. Krar",
    pages   = PAGES,
    #assets  = ["assets/custom.css"],
)


const REPO = "github.com/DrKrar/GeoEfficiency.jl.git" # "github.com/GeoEfficiency/GeoEfficiency.github.io.git" 
const VERSIONS =["stable" => "v^", "v#.#", "dev" => "dev"]  # order of versions in drop down menu.
const BRANCH = "gh-pages" # "master"

# Deploy Markup pages
@info "Deploying MarkUp pages"
deploydocs(
    repo = REPO,
    branch = "gh-pages-Mark", #BRANCH, "gh-pages",
    target = "build",
	versions = VERSIONS,
)

@info "Deploying MkDocs pages"
deploydocs(
    repo = REPO,
    deps   = Deps.pip("mkdocs", "pygments", "python-markdown-math"),
    make   = () -> run(`mkdocs build`),
    branch = "gh-pages-MkDocs", #BRANCH, "gh-pages",
    target = "site"
)
