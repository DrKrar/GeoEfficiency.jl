module Helper
using Compat
using Compat: stdin, @warn #, split

"""# UnExported

	@consol 	expresion 	[consol_inputs...]

execute the expresion `expresion` after putting `consol_inputs` into the standar input buffer.

for functions that meant to run iteractivelly while require user intput, this macro provid a tool to 
allow for noninteractive testing such functions by providing the input in advance in `consol_inputs`.
"""
macro consol(expresion, consol_inputs...)
	bffr = readavailable(stdin.buffer) # empty input stream to ensure later only the `consol_inputs` is in the `stdin` buffer.
	bffr == UInt8[] || @warn "buffer not empty, see the perivious procees to the 'stdin'"  buffer = String(bffr)
	if 0 == length(consol_inputs)
		write(stdin.buffer, "\n")   # empty `consol_inputs` simulate return or enter .
	else
		for input in  (consol_inputs)
			if typeof(input) == String
				for npt in split(input)
					write(stdin.buffer, npt, "\n")
				end
			else
				write(stdin.buffer, string(input), "\n")
			end
		end # for
	end #IF
	expresion
end


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

const H = Helper