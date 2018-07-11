baremodule Helper

function exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs::Vector; Fn_ARGs::Vector=[])
	for input in  string.(consol_inputs)
		 write(stdin.buffer, input,"\n")
	end
	return Fn(Fn_ARGs...)
end
exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs...; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, consol_inputs; Fn_ARGs=Fn_ARGs)
exec_consol_unattended(Fn::Union{Function,Type}, consol_inputs::String; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, split(consol_inputs); Fn_ARGs=Fn_ARGs)

function poly(z::Float64, coff::Vector{Float64})
	res::Float64 = 0.0
	for i= 1:length(coff)
		res += coff[i]*z^(i-1)
	end #for
	return res
end #function_poly
poly0(z::Float64) = poly(z, [1.0])
poly1(z::Float64) = poly(z, [1.0, 2.0])
poly2(z::Float64) = poly(z, [1.0, 2.0, 3.0])

end # Module

const H = Helper