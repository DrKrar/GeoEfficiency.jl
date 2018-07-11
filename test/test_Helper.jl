

print("\n\t"); @info("polynomial test for the function `integrate`")
@test  poly(4., [10., 20., 30.]) ≈ @evalpoly(4.0 , 10., 20., 30.)