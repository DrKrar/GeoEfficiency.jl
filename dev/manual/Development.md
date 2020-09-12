
<a id='Introduction-1'></a>

# Introduction


This section is provided for developer who are interested in extending the functionality of the `GeoEfficiency` package or just make use of some of its functionality. this software is licensed under the MIT license. 


<a id='Configuration-1'></a>

# Configuration


The package contain many parameters that can be set within the program sourcecode. they can be found in the source file `Config.jl`


| parameter     | description                                                                           |                                   default value                                   |
|:------------- |:------------------------------------------------------------------------------------- |:---------------------------------------------------------------------------------:|
| dataFolder    | name of the root directory                                                            |                                  "GeoEfficiency"                                  |
| dataDir       | root directory                                                                        |                          joinpath(homedir(), dataFolder)                          |
| integrate     | use the package `QuadGK` to perform integration                                       |                      begin using QuadGK; QuadGK.quadgk; end                       |
| relativeError |                                                                                       |                                      1.0E-4                                       |
| absoluteError |                                                                                       |                                     eps(1.0)                                      |
| resultsFolder | name of the result directory inside the root directory                                |                                     "results"                                     |
| max_display   | define the default for maximum number of entries shown in the `console` in batch mode | 20 **see [`max_batch`](Output_Interface.md#GeoEfficiency.max_batch-Tuple{Real})** |


<a id='Error-System-1'></a>

# Error System

<a id='GeoEfficiency.GeoException' href='#GeoEfficiency.GeoException'>#</a>
**`GeoEfficiency.GeoException`** &mdash; *Type*.



custom abstract `Exception` that is the parent of all Exception in the `GeoEfficiency` package


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L15-L17' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.InValidDetectorDim' href='#GeoEfficiency.InValidDetectorDim'>#</a>
**`GeoEfficiency.InValidDetectorDim`** &mdash; *Type*.



custom `Exception` indicating invalid radiation detector dimensions


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L24-L26' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.@validateDetector' href='#GeoEfficiency.@validateDetector'>#</a>
**`GeoEfficiency.@validateDetector`** &mdash; *Macro*.



```
@validateDetector cond [text]
```

throw an [`InValidDetectorDim`](Development.md#GeoEfficiency.InValidDetectorDim) if `cond` is `false`.  Message `text` is optionally displayed upon validation failure.

**Examples**

```julia-repl
julia> @validateDetector iseven(3) "3 is an odd number!"
ERROR: InValidDetectorDim: 3 is an odd number!

julia> @validateDetector isodd(3) "What even are numbers?"
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L31-L46' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.InValidGeometry' href='#GeoEfficiency.InValidGeometry'>#</a>
**`GeoEfficiency.InValidGeometry`** &mdash; *Type*.



custom `Exception` indicating a not valid source to detector geometry


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L71-L73' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.@inValidGeometry' href='#GeoEfficiency.@inValidGeometry'>#</a>
**`GeoEfficiency.@inValidGeometry`** &mdash; *Macro*.



```
@inValidGeometry [msg]
```

custom macro to throw [`NotImplementedError`](Development.md#GeoEfficiency.NotImplementedError) `Exception`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L78-L84' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.NotImplementedError' href='#GeoEfficiency.NotImplementedError'>#</a>
**`GeoEfficiency.NotImplementedError`** &mdash; *Type*.



custom `Exception` indicating a source-to-detector geometry which may be valid but not implemented yet


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L52-L54' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.@notImplementedError' href='#GeoEfficiency.@notImplementedError'>#</a>
**`GeoEfficiency.@notImplementedError`** &mdash; *Macro*.



```
@notImplementedError [msg]
```

custom macro to throw [`NotImplementedError`](Development.md#GeoEfficiency.NotImplementedError) `Exception`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Error.jl#L59-L64' class='documenter-source'>source</a><br>


<a id='Console-Input-1'></a>

# Console Input


Julia language is quite reach language but it seems a good idea thought to collect repeated tasks involving input from console in compact and customized to the need function. this section provide two essential functions to deal with inputs from the console. the first:

<a id='GeoEfficiency.input' href='#GeoEfficiency.input'>#</a>
**`GeoEfficiency.input`** &mdash; *Function*.



**UnExported**

```
input(prompt::AbstractString = "?: ", incolor::Symbol = :green)
```

return a string represent the user respond delimited by new line excluding the new line. prompt the user with the massage `prompt` defaults to `?`.  wait until the user type its respond and press return.  `incolor` specify the prompt text color, default to $:green$ may take any of the values  `:black`, `:blue`, `:cyan`, `:green`, `:light_black`, `:light_blue`, `:light_cyan`, `:light_green`, `:light_magenta`, `:light_red`, `:light_yellow`, `:magenta`, `:red`, `:white`, or `:yellow`.

!!! color



```
	The effect of color is not allways respected in all teriminals as some color may be simplly 
	ignored by some teriminals.
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Console.jl#L16-L33' class='documenter-source'>source</a><br>


while the second is a more complex function:

<a id='GeoEfficiency.getfloat' href='#GeoEfficiency.getfloat'>#</a>
**`GeoEfficiency.getfloat`** &mdash; *Function*.



**UnExported**

```
getfloat(prompt::AbstractString = "?: ", from::Real = -Inf, to::Real = Inf; KW...)::Float64
```

prompts the user with the massage `prompt` defaults to `?:` to input a numerical **expression**  evaluate to a numerical value. check that the numerical value is in interval [`from`, `to`[ by default [-∞,	∞[ before returning it as a `Float64`.  throws `ArgumentError` when the given interval is not valid. if the numerical expression fail to evaluated to numerical value or the numerical value is not in the valid interval  the function will warn the user and **reprompt** him to give a valid expresion.

**KW arguments**

  * value::AbstractString`="nothing"` : if provided the function will not ask for input from the   `console` and take it as if it where inputted from the  `console` [`for test propose mainly`].
  * lower::Bool`=true` : whether or not to inculde `from` as accepted value.
  * upper::Bool`=false` : whether or not to inculde `to` as accepted value.

!!! note



```
	A blank input (i.e just a return) is considered as being `0.0`. 
	Input from the `console` can be numerical expression not just a number. 
	expression like ``5/2`` ; ``5//2`` ; ``pi`` ; ``π/2`` ; ``exp(2)`` ; ``1E-2 `` ; ``5.2/3`` ; 
	``sin(1)`` ;  ``sin(1)^2`` are all valid expressions.
```

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

julia> getfloat("input a number:", value="sin(1)^2")
0.7080734182735712

julia> getfloat("input a number:", 1, 5, value="5", upper=true)
5.0
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Console.jl#L40-L92' class='documenter-source'>source</a><br>


Those function are not exported that is normally the user will not need to use them but they are documented here to allow a developer ranked user to make use of them.


<a id='Physics-Model-1'></a>

# Physics Model


Two abstract detector types defined in the package to classify the detectors, the top most super type,

<a id='GeoEfficiency.RadiationDetector' href='#GeoEfficiency.RadiationDetector'>#</a>
**`GeoEfficiency.RadiationDetector`** &mdash; *Type*.



abstract super-supertype of all detectors types


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L146-L148' class='documenter-source'>source</a><br>


any future detector definition should inherit from `RadiationDetector`. The second abstract detector   `Detector` is also a sub-type of `RadiationDetector` but it only accommodates cylindrical type only.

<a id='GeoEfficiency.Detector' href='#GeoEfficiency.Detector'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Type*.



```
Detector
```

abstract supertype of all detectors types of cylidericalish shapes. also can be used to construct any leaf type.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L151-L159' class='documenter-source'>source</a><br>


can be used to construct leaf detector.

<a id='GeoEfficiency.Detector-Tuple{}' href='#GeoEfficiency.Detector-Tuple{}'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Method*.



```
Detector()
```

construct and return an object of the `Detector` leaf types  (`CylDetector`, `BoreDetector` or `WellDetector`) according to the input from the console.

!!! note
    all required information is acquired from the `console` and would warn user on invalid data.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L345-L356' class='documenter-source'>source</a><br>


also it can be used to construct a concrete detector depend on the provided arguments.

<a id='GeoEfficiency.Detector-NTuple{4,Real}' href='#GeoEfficiency.Detector-NTuple{4,Real}'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Method*.



```
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

construct and return `well-type`, `bore-hole` or `cylindrical` detector according to the arguments.  it inspect the arguments and call the appropriate leaf type constructor.

!!! note "Missing Argument(s)"
    if the value(s) of the last argument(s) isre `zero`, it acts as a missing argument(s).


**see also:** [`CylDetector`](Physics_Model.md#GeoEfficiency.CylDetector), [`BoreDetector`](Physics_Model.md#GeoEfficiency.BoreDetector), [`WellDetector`](Physics_Model.md#GeoEfficiency.WellDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L406-L419' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Detector-Tuple{Real}' href='#GeoEfficiency.Detector-Tuple{Real}'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Method*.



```
Detector(CryRadius::Real)
```

same as [`CylDetector(CryRadius::Real)`](Physics_Model.md#GeoEfficiency.CylDetector-Tuple{Real}).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L373-L380' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Detector-Tuple{Real,Real}' href='#GeoEfficiency.Detector-Tuple{Real,Real}'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Method*.



```
Detector(CryRadius::Real, CryLength::Real)
```

same as [`CylDetector(CryRadius::Real, CryLength::Real)`](Physics_Model.md#GeoEfficiency.CylDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L383-L390' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.Detector-Tuple{Real,Real,Real}' href='#GeoEfficiency.Detector-Tuple{Real,Real,Real}'>#</a>
**`GeoEfficiency.Detector`** &mdash; *Method*.



```
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

same as [`BoreDetector(CryRadius::Real, CryLength::Real, HoleRadius::Real)`](Physics_Model.md#GeoEfficiency.BoreDetector) except when `HoleRadius` = `0.0` it acts as  [`CylDetector(CryRadius::Real, CryLength::Real)`](Physics_Model.md#GeoEfficiency.CylDetector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Physics_Model.jl#L393-L401' class='documenter-source'>source</a><br>


<a id='Batch-Mode-Input-1'></a>

# Batch Mode Input

<a id='GeoEfficiency.detector_info_from_csvFile' href='#GeoEfficiency.detector_info_from_csvFile'>#</a>
**`GeoEfficiency.detector_info_from_csvFile`** &mdash; *Function*.



**UnExported**

```
 detector_info_from_csvFile(detectors::AbstractString = Detectors, 
                                  datadir::AbstractString = dataDir)
```

return a vector{Detector} based on information in the file of name `detectors` found in the  directory `datadir`.

!!! note
      * if no path is given the second argument `datadir` is default to `/home/travis/GeoEfficiency` as set by   the constant `dataDir`.
      * if no file name is specified the name of the predefined file `Detectors.csv` as set by   the constant `Detectors`.
      * the no argument method is the most useful; other methods are mainly for `test propose`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L116-L132' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.read_from_csvFile' href='#GeoEfficiency.read_from_csvFile'>#</a>
**`GeoEfficiency.read_from_csvFile`** &mdash; *Function*.



**UnExported**

```
read_from_csvFile(csv_data::AbstractString, 
                   datadir::AbstractString = dataDir)::Vector{Float64}
```

return Vector{Float64} based on data in csv file named `csv_data`. directory `datadir` point to    where the file is located default to $/home/travis/GeoEfficiency$ as set by the constant `dataDir`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L153-L163' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.read_batch_info' href='#GeoEfficiency.read_batch_info'>#</a>
**`GeoEfficiency.read_batch_info`** &mdash; *Function*.



**UnExported**

```
read_batch_info()
```

read `detectors` and `sources` parameters from the predefined csv files.

Return a tuple 	   (detectors*array, 		srcHeights*array, 		srcRhos*array, 		srcRadii*array, 		srcLengths*array, 		GeoEfficiency*isPoint)


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L185-L201' class='documenter-source'>source</a><br>


**UnExported**

```
read_batch_info(datadir::AbstractString,
              detectors::AbstractString, 
             srcHeights::AbstractString,
                srcRhos::AbstractString,
               srcRadii::AbstractString,
             srcLengths::AbstractString)
```

read `detectors` and `sources` parameters from the location given in the argument list.

Return a tuple

```
   (detectors_array,
	srcHeights_array,
	srcRhos_array,
	srcRadii_array,
	srcLengths_array,
	isPoint)
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L209-L231' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.getDetectors' href='#GeoEfficiency.getDetectors'>#</a>
**`GeoEfficiency.getDetectors`** &mdash; *Function*.



```
getDetectors(detectors_array::Vector{<:Detector} = Detector[])::Vector{Detector}
```

return the `detectors_array` as Vector{Detector} extended by the entered detectors and sorted according to the  detector volume.  prompt the user to input detector parameters from the `console`.

!!! note
    If no array received in the input an empty array will be created to receive the converted detectors.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L288-L300' class='documenter-source'>source</a><br>


```
getDetectors(detector_info_array::Matrix{<:Real}, 
				 detectors_array::Vector{<:Detector} = Detector[]; 
				 						   console_FB=true)::Vector{Detector}
```

return `detectors_array` as Vector{Detector}, after extending it with the successfully converted detectors. while,  attempt to convert detectors from the information in `detector_info_array`. 

!!! note
    if `console_FB` argument is set to true , the function will call `getDetectors()` to take input from the `console` if the `detector_info_array` is empty or contain no numerical element.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Input_Batch.jl#L321-L335' class='documenter-source'>source</a><br>


<a id='Output-Interface-1'></a>

# Output Interface

<a id='GeoEfficiency.checkResultsDirs' href='#GeoEfficiency.checkResultsDirs'>#</a>
**`GeoEfficiency.checkResultsDirs`** &mdash; *Function*.



**UnExported**

```
checkResultsDirs()
```

make sure that directories for saving the results are already exist or create  them if necessary.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Output_Interface.jl#L35-L44' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.writecsv_head' href='#GeoEfficiency.writecsv_head'>#</a>
**`GeoEfficiency.writecsv_head`** &mdash; *Function*.



**UnExported**

```
writecsv_head(filename::AbstractString, content::VecOrMat{<:Union{Int,Float64}}, head=[])
```

Write `content` to the comma delimited values file `filename`.  optionally with header `head`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Output_Interface.jl#L168-L177' class='documenter-source'>source</a><br>

<a id='GeoEfficiency._max_batch' href='#GeoEfficiency._max_batch'>#</a>
**`GeoEfficiency._max_batch`** &mdash; *Constant*.



Global variable that give a hint to the program on maxumam number of entries per detector displayed  on the `console` in btach mode.

!!! note "Special Values"



```
Negative value will display prevent batch results from printed to the `console`. 
while `Inf` will print all batch results to the `console`.
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Output_Interface.jl#L19-L28' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.max_display' href='#GeoEfficiency.max_display'>#</a>
**`GeoEfficiency.max_display`** &mdash; *Constant*.



set the default value for the global variable `_max_batch`


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Config.jl#L33-L35' class='documenter-source'>source</a><br>

<a id='GeoEfficiency._batch' href='#GeoEfficiency._batch'>#</a>
**`GeoEfficiency._batch`** &mdash; *Function*.



**UnExported**

```
_batch(
	::Val{true},
	detector::Detector,
	srcHeights_array::Vector{Float64},
	srcRhos_array::Vector{Float64},
	srcRadii_array::Vector{Float64},
	srcLengths_array::Vector{Float64}
	)
```

batch calculation for specialized for **`point`** sources.  return a tuple of three arrays the `detector`, the `results`and the path of the **`CSV`**  file containing results. 

The `results` has columns of headers `Height`, `Rho`, `GeoEfficiency`.

!!! note
    for all arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array` and `srcLengths_array`   element type should be `Float64`. if any of them have other numerical element type it   should converted to `Float64` using `float` before passing it to this method.


!!! warning
    both `srcRadii_array`, `srcLengths_array` are completely ignored as this method is for point sources.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Output_Interface.jl#L351-L378' class='documenter-source'>source</a><br>


**UnExported**

```
_batch(
	::Val{false},
	detector::Detector,
	srcHeights_array::Vector{Float64},
	srcRhos_array::Vector{Float64},
	srcRadii_array::Vector{Float64},
	srcLengths_array::Vector{Float64},
	)
```

batch calculation for specialized for **`non-point`** sources.  return a tuple of three arrays the `detector`, the `results`and the path of the **`CSV`**  file containing results. 

The `results` has columns of headers  `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency`.

!!! note
    for all arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array` and `srcLengths_array`  element type should be `Float64`. if any of them have other numerical element type it  should converted to `Float64` using `float` before passing it to this method.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/aa8fbdca6b605bd4a77600d9cd5183afcdf6c9b2/src/Output_Interface.jl#L425-L450' class='documenter-source'>source</a><br>

