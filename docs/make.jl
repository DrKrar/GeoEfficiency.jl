#include("E:\\Users\\DrKra\\.julia\\dev\\GeoEfficiency\\docs\\make.jl")
#=
cdir= pwd()
@info("Working Directory: ", @__DIR__)
cd(@__DIR__) 
=#

#**************************************************************************************
# make.jl
# =============== part of the GeoEfficiency.jl package.
#
# script for building documentaion of the GeoEfficiency.jl package.
#
#**************************************************************************************

using Documenter, DocumenterLaTeX
using GeoEfficiency

const PAGES = Any[
    "Home" => "index.md",
    "Manual" => [
		"manual/GeoEfficiency.md",
        "manual/Error.md",
        "manual/Input_Console.md",
        "manual/Physics_Model.md",
        "manual/Input_Batch.md",
        "manual/Calculations.md",
        "manual/Output_Interface.md",
     ],
]

const formats = Any[
    Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        canonical = "https://DrKrar.github.io/GeoEfficiency.jl/v0.9/"
    ),
]
if "pdf" in ARGS
    push!(formats, LaTeX(platform = "docker"))
end

makedocs(
    format  = formats,
    modules = [GeoEfficiency],
    clean   = "clean" in ARGS,
    doctest = "doctest" in ARGS,
    sitename= "GeoEfficiency.jl",
    authors = "Mohamed E. Krar",
    pages   = PAGES,
    assets  = ["assets/custom.css"],
)

mktempdir() do tmp
    # Hide the PDF from html-deploydocs
    build = joinpath(@__DIR__, "build")
    files = readdir(build)
    idx = findfirst(f -> startswith(f, "GeoEfficiency.jl") && endswith(f, ".pdf"), files)
    pdf = idx === nothing ? nothing : joinpath(build, files[idx])
    if pdf !== nothing
        pdf = mv(pdf, joinpath(tmp, basename(pdf)))
    end
    # Deploy HTML pages
    @info "Deploying HTML pages"
    deploydocs(
        repo = "github.com/DrKrar/GeoEfficiency.jl",
        versions = ["v#.#", "dev" => "dev"],
    )
    # Put back PDF into docs/build/pdf
    mkpath(joinpath(build, "pdf"))
    if pdf !== nothing
        pdf = mv(pdf, joinpath(build, "pdf", basename(pdf)))
    end
    # Deploy PDF
    @info "Deploying PDF"
    deploydocs(
        repo = "github.com/DrKrar/GeoEfficiency.jl",
        target = "build/pdf",
        branch = "gh-pages-pdf",
        forcepush = true,
    )
end
# cd(cdir)


#=using Documenter, GeoEfficiency

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
)=#


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
