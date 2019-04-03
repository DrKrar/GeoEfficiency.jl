
<a id='Error-1'></a>

# Error

<a id='GeoEfficiency.GeoException' href='#GeoEfficiency.GeoException'>#</a>
**`GeoEfficiency.GeoException`** &mdash; *Type*.



coustom abstract `Exception` that is the parent of all exception in the `GeoEfficiency` package


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Error.jl#L2' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.InValidDetectorDim' href='#GeoEfficiency.InValidDetectorDim'>#</a>
**`GeoEfficiency.InValidDetectorDim`** &mdash; *Type*.



coustom `Exception` indicating inValid radiation detector dimentions


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Error.jl#L9' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.@validateDetector' href='#GeoEfficiency.@validateDetector'>#</a>
**`GeoEfficiency.@validateDetector`** &mdash; *Macro*.



```julia
@validateDetector cond [text]
```

Throw an [`InValidDetectorDim`](Error.html#GeoEfficiency.InValidDetectorDim) if `cond` is `false`.  Message `text` is optionally displayed upon validation failure.

**Examples**

```julia-repl
julia> @validateDetector iseven(3) "3 is an odd number!"
ERROR: InValidDetectorDim: 3 is an odd number!

julia> @validateDetector isodd(3) "What even are numbers?"
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Error.jl#L14-L27' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.NotImplementedError' href='#GeoEfficiency.NotImplementedError'>#</a>
**`GeoEfficiency.NotImplementedError`** &mdash; *Type*.



coustom `Exception` source to detector condation which may be valid but not implemented yet


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Error.jl#L48' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.@notImplementedError' href='#GeoEfficiency.@notImplementedError'>#</a>
**`GeoEfficiency.@notImplementedError`** &mdash; *Macro*.



coustom macro to throw [`NotImplementedError`](Error.html#GeoEfficiency.NotImplementedError) `Exception` 


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Error.jl#L53' class='documenter-source'>source</a><br>

