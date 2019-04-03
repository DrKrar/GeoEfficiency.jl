
<a id='Console-Input-1'></a>

# Console Input

<a id='GeoEfficiency.input' href='#GeoEfficiency.input'>#</a>
**`GeoEfficiency.input`** &mdash; *Function*.



**UnExported**

```
input(prompt::AbstractString = "? ", incolor::Symbol = :green)
```

return a string delimited by new line excluding the new line. prompt the user with the massage `prompt` defaults to `?`.  `incolor` specify the prompt text color, default to $green$.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Console.jl#L17-L25' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.getfloat' href='#GeoEfficiency.getfloat'>#</a>
**`GeoEfficiency.getfloat`** &mdash; *Function*.



**UnExported**

```
getfloat(prompt::AbstractString = "? ", from::Real = -Inf, to::Real = Inf; KW...)::Float64
```

prompts the user with the massage `prompt` defaults to `?` to input a numerical expression  evaluate to a numerical value and asserts that the value is by default in the semi open interval [`from`, `to`[ before returning it as a `Float64`. throws `ArgumentError` when the given interval is not valid.

**KW arguments**

  * value::AbstractString`="nothing"` : if provided the function will not ask for input from the   `console` and take it as if it where inputted from the  `console` [`for test propose mainly`].
  * lower::Bool`=true` : whether or not to inculde `from` as accepted value.
  * upper::Bool`=false` : whether or not to inculde `to` as accepted value.

!!! note
      * a blank input (i.e just a return) is considered as being `0.0`.
      * input from the `console` can be numerical expression not just a number.
      * All `5/2`, `5//2`, `exp(2)`, `pi`, `1E-2`, `5.2/3`, `sin(1)`, `pi/2/3`   are valid mathematical expressions.


**Examples**

```
julia> getfloat("input a number:", value="3")
3.0

julia> getfloat("input a number:", value="")
0.0

julia> getfloat("input a number:", value="5/2")
2.5

julia> getfloat("input a number:", value="5//2")
2.5

julia> getfloat("input a number:", value="pi")
3.141592653589793

julia> getfloat("input a number:", value="-2")
-2.0

julia> getfloat("input a number:", 1, 5, value="5", upper=true)
5.0
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Console.jl#L32-L77' class='documenter-source'>source</a><br>

