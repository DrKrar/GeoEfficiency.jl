@debug("test Error system")

@test G.@validateDetector true
@test G.@validateDetector true "massage"
@test G.@validateDetector true "massage1" "massage2"

@test_throws  G.InValidDetectorDim  G.@validateDetector false
@test_throws  G.InValidDetectorDim  G.@validateDetector false "massage"
@test_throws  G.InValidDetectorDim  G.@validateDetector false "massage1" "massage2"


@test_throws  G.notImplementedError  G.@notImplementedError
@test_throws  G.notImplementedError  G.@notImplementedError "massage"
@test_throws  G.notImplementedError  G.@notImplementedError "massage1" "massage2"
