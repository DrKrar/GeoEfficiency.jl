module Helper
using Compat
using Compat: stdin, @warn #, split

"""# UnExported

	@console 	expresion 	[consol_inputs...]

execute the expresion `expresion` after putting `consol_inputs` into the standar input buffer.

for functions that meant to run iteractivelly while require user intput, this macro provid a tool to 
allow for noninteractive testing such functions by providing the input in advance by `consol_inputs`.
"""
macro console(expresion, consol_inputs...)
	quote
		bffr = readavailable(stdin.buffer) # empty input stream to ensure later only the `consol_inputs` is in `stdin` buffer.
		bffr == UInt8[] || @warn "buffer not empty, see the pervious process to 'stdin'"  buffer = String(bffr)
		if 0 == length($consol_inputs)
			write(stdin.buffer, "\n")   					# [1of2] empty `consol_inputs` simulate return or enter .
		else
			for input in $consol_inputs
				if typeof(input) == String && input != "" 	# [2of2]empty `consol_inputs` simulate return or enter .
					for npt in string.(split(input))
						write(stdin.buffer, npt, "\n")
					end
				else
					write(stdin.buffer, string(input), "\n")
				end #if
			end # for
		end #IF
		$expresion		#:($(esc(expresion)))
	end |> esc
end


function exec_console_unattended(Fn::Union{Function, Type}, consol_inputs::Vector = []; Fn_ARGs::Vector=[])
	bffr = readavailable(stdin.buffer) # empty input stream to ensure later only the `consol_inputs` is in `stdin` buffer.
	bffr == UInt8[] || @warn "buffer not empty, see the pervious process to 'stdin'"  buffer = String(bffr) 
	
	if 0 == length(consol_inputs)
		write(stdin.buffer, "\n")   # empty `consol_inputs` simulate return or enter .

	else
		for input in  string.(consol_inputs)
			write(stdin.buffer, input, "\n") 
		end # for

	end #IF
	
	return Fn(Fn_ARGs...)		# call and return the value	
end
exec_console_unattended(Fn::Union{Function, Type}, consol_inputs...; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, [consol_inputs...]; Fn_ARGs=Fn_ARGs)
exec_console_unattended(Fn::Union{Function, Type}, consol_inputs::String; Fn_ARGs::Vector=[]) = exec_consol_unattended(Fn, split(consol_inputs); Fn_ARGs=Fn_ARGs)

end
const H = Helper
