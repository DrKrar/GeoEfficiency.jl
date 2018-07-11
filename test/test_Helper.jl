@test H.exec_consol_unattended(+, [], Fn_ARGs=[1, 2, 3]) == 6

@test H.exec_consol_unattended(readline, [1]) == "1"
@test H.exec_consol_unattended(readline, "1") == "1"
#@test H.exec_consol_unattended(readline, 1) == "1"

@test H.exec_consol_unattended(readavailable, [1, 2, 3]; Fn_ARGs=[stdin])|> String == "1\n2\n3\n"
@test H.exec_consol_unattended(readavailable, "1\n2\n3\n"; Fn_ARGs=[stdin])|> String == "1\n2\n3\n"
#@test H.exec_consol_unattended(readavailable, 1, 2, 3; Fn_ARGs=[stdin])|> String == "1\n2\n3\n"

print("\n\t"); @info("polynomial test for the function `integrate`")
@test H.poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)