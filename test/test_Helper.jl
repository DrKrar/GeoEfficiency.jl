@testset "@consol" begin
    @test 6 == H.@consol +(1, 2, 3)
        @test readavailable(stdin.buffer) |> String == "\n"


    @test ""    == H.@consol readline()
    @test "1"   == H.@consol readline() 1
    @test "1"   == H.@consol readline() 1 2 3
        @test [readline(), readline()] == ["2", "3"]
        @test readavailable(stdin.buffer) |> String == ""   # test that no thing is left in the stdin
    @test ""    == H.@consol readline() ""
    @test "1"   == H.@consol readline() "1"
    @test "1"   == H.@consol readline() "1" "2" "3"
        @test [readline(), readline()] == ["2", "3"]
        @test readavailable(stdin.buffer) |> String == ""   # test that no thing is left in the stdin


    @test "\n"    == H.@consol readavailable(stdin)
    @test "\n"    == H.@consol readavailable(stdin) ""
    @test "1\n2\n3\n"    == H.@consol readavailable(stdin) 1 2 3
    @test "1\n2\n3\n"    == H.@consol readavailable(stdin) "1\n2\n3"
    @test "1\n2\n3\n"    == H.@consol readavailable(stdin) "1\n2\n3\n"
    
    @test "1\n2\n3\n"    == H.@consol readavailable(stdin) "1 2 3"
    @test "1\n2\n3\n"    == H.@consol readavailable(stdin) "1 2 3\n"
    @test "1\n2\n3\nQ\n" == H.@consol readavailable(stdin) "1 2 3 Q"
        @test readavailable(stdin.buffer) |> String == ""   # test that no thing is left in the stdin
end #testset_@consol

@testset "exec_consol_unattended" begin
    @test H.exec_consol_unattended(+, [] ;Fn_ARGs=[1, 2, 3]) == 6
        @test readavailable(stdin.buffer) |> String == "\n"
    @test H.exec_consol_unattended(+ ;Fn_ARGs=[1, 2, 3]) == 6
        @test readavailable(stdin.buffer) |> String == "\n"
    @test H.exec_consol_unattended(+, "";Fn_ARGs=[1, 2, 3]) == 6
        @test readavailable(stdin.buffer) |> String == "\n"

    @test H.exec_consol_unattended(readline, []) == ""
    @test H.exec_consol_unattended(readline, "") == ""
    @test H.exec_consol_unattended(readline, [1]) == "1"
    @test H.exec_consol_unattended(readline, [1, 2, 3]) == "1"
        @test [readline(), readline()] == ["2", "3"]
    @test H.exec_consol_unattended(readline, "1") == "1"
    @test H.exec_consol_unattended(readline, "1 2 3") == "1"
        @test [readline(), readline()] == ["2", "3"]
    @test H.exec_consol_unattended(readline, 1) == "1"
    @test H.exec_consol_unattended(readline, 1, 2, 3) == "1"
        @test [readline(), readline()] == ["2", "3"]

    @test H.exec_consol_unattended(sin, "1 2 3 4" ;Fn_ARGs=[pi]) == sin(pi)
        @test [readline(), readline(), readline(), readline()] == ["1", "2", "3", "4"]
    @test H.exec_consol_unattended(sin, ["1", "2", "3", "4"] ;Fn_ARGs=[pi]) == sin(pi)
        @test [readline(), readline(), readline(), readline()] == ["1", "2", "3", "4"]
    @test H.exec_consol_unattended(sin, [1, 2, 3, 4] ;Fn_ARGs=[pi]) == sin(pi)
        @test [readline(), readline(), readline(), readline()] == ["1", "2", "3", "4"]
    @test H.exec_consol_unattended(sin, 1, 2, 3, 4 ;Fn_ARGs=[pi]) == sin(pi)
        @test [readline(), readline(), readline(), readline()] == ["1", "2", "3", "4"]
    @test readavailable(stdin.buffer) |> String == ""   # test that no thing is left in the stdin

    @test H.exec_consol_unattended(readavailable, []    ;Fn_ARGs=[stdin])|> String   == "\n"
    @test H.exec_consol_unattended(readavailable, ""    ;Fn_ARGs=[stdin])|> String   == "\n"
    @test H.exec_consol_unattended(readavailable        ;Fn_ARGs=[stdin])|> String   == "\n"
    @test H.exec_consol_unattended(readavailable, [1, 2, 3];    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1\n2\n3";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1\n2\n3\n";  Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3";      Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3\n";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3 Q";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\nQ\n"
    @test H.exec_consol_unattended(readavailable, 1, 2, 3;     Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"

    @test readavailable(stdin.buffer) |> String == ""   # test that no thing is left in the stdin
end #testset_exec_consol_unattended


@testset "polynomial" begin
    @test H.poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)
end #testset_polynomial
