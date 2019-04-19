using Documenter, DocumenterLaTeX
using GeoEfficiency

const ROOT = joinpath(@__DIR__, "..")
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
]

# GeoEfficiency package docs
doc = makedocs(
    debug 	= true,
    root 	= ROOT,
    build 	= "pdf/build",
    modules = [GeoEfficiency],
    clean 	= "clean" in ARGS,
    format 	= LaTeX(platform = "docker"),
    sitename= "GeoEfficiency.jl",
    authors = "Mohamed E. Krar",
    pages 	= PAGES,
	doctest = "doctest" in ARGS,
    #assets  = ["assets/custom.css"],
);

# hack to only deploy the actual pdf-file
mkpath(joinpath(ROOT, "pdf", "build", "pdfdir"))
let files = readdir(joinpath(ROOT, "pdf", "build"))
    for f in files
        if startswith(f, "GeoEfficiency.jl") && endswith(f, ".pdf")
            mv(joinpath(ROOT, "pdf", "build", f),
               joinpath(ROOT, "pdf", "build", "pdfdir", f))
        end
    end
end


@info "Deploying PDF"
deploydocs(
    repo = "github.com/DrKrar/GeoEfficiency.jl.git",
    root = ROOT,
    target = "pdf/build/pdfdir",
    branch = "gh-pages-pdf",
    forcepush = true,
)
