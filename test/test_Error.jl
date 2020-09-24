@debug("test Error system")

let x="1", y=2, apnt=Point(1,2)
    @test nothing == showerror(stderr, G.GeoException)
    @test nothing == showerror(stderr, G.InValidDetectorDim)
    @test nothing == showerror(stderr, G.NotImplementedError)
    @test nothing == showerror(stderr, G.InValidGeometry)
    @test occursin("GeoException", sprint(showerror, G.GeoException))
    @test occursin("InValidDetectorDim", sprint(showerror, G.InValidDetectorDim))
    @test occursin("NotImplementedError", sprint(showerror, G.NotImplementedError))
    @test occursin("InValidGeometry", sprint(showerror, G.InValidGeometry))

    @test nothing == G.@validateDetector true
    @test nothing == G.@validateDetector true "massage"
    @test nothing == G.@validateDetector true "massage $y $x $apnt"
    @test nothing == G.@validateDetector true "massage1" * "massage2"
    @test nothing == G.@validateDetector true "massage1" "massage2"
    @test nothing == G.@validateDetector true 1
    @test nothing == G.@validateDetector true x
    @test nothing == G.@validateDetector true y
    @test nothing == G.@validateDetector true apnt
    @test nothing == G.@validateDetector true :x
    @test nothing == G.@validateDetector true :(a+b)

    @test_throws    G.InValidDetectorDim    G.@validateDetector false
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage $y $x $apnt"
    @test_throws    G.InValidDetectorDim    G.@validateDetector x==y  "massage $y $x $apnt"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage1" * "massage2"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage1" "massage2"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false 1
    @test_throws    G.InValidDetectorDim    G.@validateDetector false x
    @test_throws    G.InValidDetectorDim    G.@validateDetector false y
    @test_throws    G.InValidDetectorDim    G.@validateDetector false apnt
    @test_throws    G.InValidDetectorDim    G.@validateDetector false :x
    @test_throws    G.InValidDetectorDim    G.@validateDetector false :(a+b)


    @test_throws    G.NotImplementedError   G.@notImplementedError
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage $y $x $apnt"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage1" "massage2"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage1" * "massage2"
    @test_throws    G.NotImplementedError   G.@notImplementedError  1
    @test_throws    G.NotImplementedError   G.@notImplementedError  x
    @test_throws    G.NotImplementedError   G.@notImplementedError  y
    @test_throws    G.NotImplementedError   G.@notImplementedError  apnt
    @test_throws    G.NotImplementedError   G.@notImplementedError  :x
    @test_throws    G.NotImplementedError   G.@notImplementedError  :(a+b)


    @test_throws    G.InValidGeometry   G.@inValidGeometry
    @test_throws    G.InValidGeometry   G.@inValidGeometry "massage"
    @test_throws    G.InValidGeometry   G.@inValidGeometry "massage $y $x $apnt"
    @test_throws    G.InValidGeometry   G.@inValidGeometry "massage1" "massage2"
    @test_throws    G.InValidGeometry   G.@inValidGeometry "massage1" * "massage2"
    @test_throws    G.InValidGeometry   G.@inValidGeometry  1
    @test_throws    G.InValidGeometry   G.@inValidGeometry  x
    @test_throws    G.InValidGeometry   G.@inValidGeometry  y
    @test_throws    G.InValidGeometry   G.@inValidGeometry  apnt
    @test_throws    G.InValidGeometry   G.@inValidGeometry  :x
    @test_throws    G.InValidGeometry   G.@inValidGeometry  :(a+b)


    @test G.to_string("massage")    == "massage"
    @test G.to_string("")           ==  ""
    @test G.to_string("5" * "l")    == "5l"
    @test G.to_string(raw"\5")       == "\\5"
    @test G.to_string("5 $y $x $apnt") == "5 2 1 Point(1.0, 2.0)"

    @test G.to_string(true)         == "true"
    @test G.to_string(1)            == "1"
    @test G.to_string(1 + 2)        == "3"

    @test G.to_string(+)            == "+"
    @test G.to_string(x)            == "1"
    @test G.to_string(y)            == "1"
    @test G.to_string(apnt)         == "Point(1.0, 2.0)"

    # to be able to test for Expr, Symbol as `esc()` is not allowed outside macro
    @test @to_string(:(1+x))       ==  "1 + x"
    @test @to_string(:(1+$y))      ==  "1 + 2"
    @test @to_string(:(1+$x))      ==  "1 + \"1\""
    
    @test @to_string(:x)           ==  ":x"             # ||  G.@to_string(:x)  ==  "x"   # for Compt with Julia 0.6
end