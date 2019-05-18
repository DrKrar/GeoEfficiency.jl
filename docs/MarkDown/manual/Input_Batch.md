
<a id='Batch-Mode-Input-1'></a>

# Batch Mode Input

<a id='GeoEfficiency.typeofSrc' href='#GeoEfficiency.typeofSrc'>#</a>
**`GeoEfficiency.typeofSrc`** &mdash; *Function*.



```
typeofSrc()::SrcType
```

return the current value of the global `GeoEfficiency.srcType`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/8f47899e8f15f4237d51d4c0e73027a14a8275aa/src/Input_Batch.jl#L29-L35' class='documenter-source'>source</a><br>


```
typeofSrc(x::Int)::SrcType
```

set and return the value of the global `GeoEfficiency.srcType` corresponding to `x`.

  * srcUnknown = -1 also any negative integer treated as so,
  * srcPoint   = 0,
  * srcLine    = 1,
  * srcDisk    = 2,
  * srcVolume  = 3,
  * srcNotPoint = 4 also any greater than 4 integer treated as so.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/8f47899e8f15f4237d51d4c0e73027a14a8275aa/src/Input_Batch.jl#L38-L51' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.setSrcToPoint' href='#GeoEfficiency.setSrcToPoint'>#</a>
**`GeoEfficiency.setSrcToPoint`** &mdash; *Function*.



```
setSrcToPoint()::Bool
```

return whether the source type is a point or not.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/8f47899e8f15f4237d51d4c0e73027a14a8275aa/src/Input_Batch.jl#L65-L70' class='documenter-source'>source</a><br>


```
setSrcToPoint(yes::Bool)::Bool
```

return whether the source type is a point or not after setting `srcType` to `srcPoint` if  `yes` = `true` else if `yes` = `false` setting it to `srcNotPoint` if it was not already  set to other non-point type (`srcDisk`, `srcLine`, `srcVolume`).

!!! note
      * The user can use this function to change the source type any time.
      * The source type is set the fist time asked for source.


**see also:** [`typeofSrc(::Int)`](Input_Batch.md#GeoEfficiency.typeofSrc).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/8f47899e8f15f4237d51d4c0e73027a14a8275aa/src/Input_Batch.jl#L73-L88' class='documenter-source'>source</a><br>


```
setSrcToPoint(prompt::AbstractString)::Bool
```

return whether the source type is a point or not. only prompt the user to set the source  type if it were not already set before. 

**see also:** [`typeofSrc(::Int)`](Input_Batch.md#GeoEfficiency.typeofSrc), [`setSrcToPoint(::Bool)`](Input_Batch.md#GeoEfficiency.setSrcToPoint).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/8f47899e8f15f4237d51d4c0e73027a14a8275aa/src/Input_Batch.jl#L100-L109' class='documenter-source'>source</a><br>


!!! warnning
    Currently, the source type has no effect but to decide if the source is a point source or a higher dimension source.


