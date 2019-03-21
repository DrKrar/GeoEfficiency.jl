@debug("test Error system")

@test nothing == G.@validateDetector true
@test nothing == G.@validateDetector true "massage"
@test nothing == G.@validateDetector true "massage1" "massage2"

@test_throws  G.InValidDetectorDim  G.@validateDetector false
@test_throws  G.InValidDetectorDim  G.@validateDetector false "massage"
@test_throws  G.InValidDetectorDim  G.@validateDetector false "massage1" "massage2"


@test_throws  G.NotImplementedError  G.@notImplementedError
@test_throws  G.NotImplementedError  G.@notImplementedError "massage"
@test_throws  G.NotImplementedError  G.@notImplementedError "massage1" "massage2"
