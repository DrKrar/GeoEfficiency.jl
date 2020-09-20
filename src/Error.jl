function to_string(msg)
    if isa(msg, AbstractString)
        msg # pass-through

    elseif isa(msg, Expr) || isa(msg, Symbol) # && !isempty(msg) 
        # message is an expression needing evaluating
        :(Main.Base.string($(esc(msg))))

    else
        Main.Base.string(msg)

    end #if
end #function

"""
custom abstract `Exception` that is the parent of all Exception in the `GeoEfficiency` package
"""
abstract type GeoException <: Exception end

import Base: showerror

showerror(io::IO, err::GeoException) = print(io, nameof(typeof(err)), ": ", err.msg)

"""
custom `Exception` indicating invalid radiation detector dimensions
"""
struct  InValidDetectorDim <: GeoException
   	msg::AbstractString
end

"""


    @validateDetector cond [text]

throw an [`InValidDetectorDim`](@ref) if `cond` is `false`. 
Message `text` is optionally displayed upon validation failure.

# Examples
```jldoctest
julia> using GeoEfficiency;

julia> GeoEfficiency.@validateDetector iseven(3) "3 is an odd number!"
ERROR: InValidDetectorDim: 3 is an odd number!

julia> GeoEfficiency.@validateDetector isodd(3) "What even are numbers?"
```
"""
macro validateDetector(ex, msgs...)
    msg = isempty(msgs) ? "'$ex' is not satisfied" : to_string(msgs[1])
    return :($(esc(ex)) ? $(nothing) : throw(InValidDetectorDim($msg)))
end

"""
custom `Exception` indicating a source-to-detector geometry which may be valid but not implemented yet
"""
struct  NotImplementedError <: GeoException
   	msg::AbstractString
end

"""

    @notImplementedError [msg]

custom macro to throw [`NotImplementedError`](@ref) `Exception`.
"""
macro notImplementedError(msgs...)
    msg = isempty(msgs) ? "" : to_string(msgs[1])
    return :(throw(NotImplementedError($msg)))
end


"""
custom `Exception` indicating a not valid source to detector geometry
"""
struct  InValidGeometry <: GeoException
   	msg::AbstractString
end

"""


    @inValidGeometry [msg]

custom macro to throw [`NotImplementedError`](@ref) `Exception`.
"""
macro inValidGeometry(msgs...)
    msg = isempty(msgs) ? "" : to_string(msgs[1])
    return :(throw(InValidGeometry($msg)))
end
