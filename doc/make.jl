using GeoEfficiency
using Documenter


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
    authors   = "Mohamed Krar",
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