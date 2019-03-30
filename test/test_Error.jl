@debug("test Error system")

let x="1"
    @test nothing == Base.showerror(stderr, G.GeoException)
    @test nothing == Base.showerror(stderr, G.InValidDetectorDim)
    @test nothing == Base.showerror(stderr, G.NotImplementedError)
    

    @test nothing == G.@validateDetector true
    @test nothing == G.@validateDetector true "massage"
    @test nothing == G.@validateDetector true "massage $x"
    @test nothing == G.@validateDetector true "massage1" * "massage2"
    @test nothing == G.@validateDetector true "massage1" "massage2"
    @test nothing == G.@validateDetector true 1
    @test nothing == G.@validateDetector true :x
    @test nothing == G.@validateDetector true :(a+b)

    @test_throws    G.InValidDetectorDim    G.@validateDetector false
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage $x"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage1" * "massage2"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false "massage1" "massage2"
    @test_throws    G.InValidDetectorDim    G.@validateDetector false 1
    @test_throws    G.InValidDetectorDim    G.@validateDetector false :x
    @test_throws    G.InValidDetectorDim    G.@validateDetector false :(a+b)


    @test_throws    G.NotImplementedError   G.@notImplementedError
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage $x"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage1" "massage2"
    @test_throws    G.NotImplementedError   G.@notImplementedError "massage1" * "massage2"
    #@test_throws    G.NotImplementedError   G.@notImplementedError  1
    #@test_throws    G.NotImplementedError   G.@notImplementedError  :x
    @test_throws    G.NotImplementedError   G.@notImplementedError  :(a+b)
end