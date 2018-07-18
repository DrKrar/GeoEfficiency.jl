@testset "exec_consol_unattended" begin
    @test H.exec_consol_unattended(+, [], Fn_ARGs=[1, 2, 3]) == 6

    @test H.exec_consol_unattended(readline, [1]) == "1"
    @test H.exec_consol_unattended(readline, "1") == "1"
    #@test H.exec_consol_unattended(readline, 1) == "1"

    @test H.exec_consol_unattended(readavailable, [1, 2, 3];    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1\n2\n3";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1\n2\n3\n";  Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3";      Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3\n";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
    @test H.exec_consol_unattended(readavailable, "1 2 3 Q";    Fn_ARGs=[stdin])|> String   == "1\n2\n3\nQ\n"
    #@test H.exec_consol_unattended(readavailable, 1, 2, 3;     Fn_ARGs=[stdin])|> String   == "1\n2\n3\n"
end #testset_exec_consol_unattended


@testset "polynomial" begin
    @test H.poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)
end #testset_polynomial
