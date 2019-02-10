module Helper
using Compat
using Compat: stdin, @warn #, split

function exec_consol_unattended(Fn::Union{Function, Type}, consol_inputs::Vector = []; Fn_ARGs::Vector=[])
	bffr = readavailable(stdin.buffer) # empty input stream to ensure later only the `consol_inputs` is in the  tdin buffer.
	bffr == UInt8[] || @warn "buffer not empty, see the perivious call to `exec_consol_unattended`"  buffer = String(bffr) 
	
	if 0 == length(consol_inputs)
		write(stdin.buffer, "\n")   # empty `consol_inputs` simulate return or enter .

	else
			for input in  string.(consol_inputs)
				write(stdin.buffer, input, "\n")
			end # for

	end #IF
	
	return Fn(Fn_ARGs...)		# call and return the value	
end
exec_consol_unattended(Fn::Union{Function, Type}, consol_inputs...; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, [consol_inputs...]; Fn_ARGs=Fn_ARGs)
exec_consol_unattended(Fn::Union{Function, Type}, consol_inputs::String; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, split(consol_inputs); Fn_ARGs=Fn_ARGs)

function poly(z::Float64, coffs::Vector{Float64})
	res::Float64 = 0.0
	for i= 1:length(coffs)
		res += coffs[i] * z^(i-1)
	end #for
	return res
end #function_poly
poly0(z::Float64) = poly(z, [1.0])
poly1(z::Float64) = poly(z, [1.0, 2.0])
poly2(z::Float64) = poly(z, [1.0, 2.0, 3.0])

end # Module

const H = Helper