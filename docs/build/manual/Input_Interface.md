
<a id='[Input_Interface]-1'></a>

# [Input_Interface]

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

<a id='GeoEfficiency.getDetectors' href='#GeoEfficiency.getDetectors'>#</a>
**`GeoEfficiency.getDetectors`** &mdash; *Function*.



```julia
getDetectors(detectors_array::Vector{<:Detector} = Detector[])::Vector{Detector}
```

return the `detectors_array` as Vector{Detector} extended by the entered detectors and sorted according to the  detector volume.  prompt the user to input detector parameters from the `console`.

!!! note
    If no array received in the input an empty array will be created to receive the converted detectors.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L282-L293' class='documenter-source'>source</a><br>


```
getDetectors(detector_info_array::Matrix{<:Real}, 
				 detectors_array::Vector{<:Detector} = Detector[]; 
				 						   console_FB=true)::Vector{Detector}
```

return `detectors_array` as Vector{Detector}, after extending it with the successfully converted detectors. while,  attempt to convert detectors from the information in `detector_info_array`. 

!!! note
    if `console_FB` argument is set to true , the function will call `getDetectors()` to take input from the `console` if the `detector_info_array` is empty or contain no numerical element.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L315-L328' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.read_from_csvFile' href='#GeoEfficiency.read_from_csvFile'>#</a>
**`GeoEfficiency.read_from_csvFile`** &mdash; *Function*.



**UnExported**

```
read_from_csvFile(csv_data::AbstractString, 
                   datadir::AbstractString = dataDir)::Vector{Float64}
```

return Vector{Float64} based on data in csv file named `csv_data`. directory `datadir` point to    where the file is located default to $C:\Users\Mohamed\GeoEfficiency$ as set by the constant `dataDir`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L148-L157' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.read_batch_info' href='#GeoEfficiency.read_batch_info'>#</a>
**`GeoEfficiency.read_batch_info`** &mdash; *Function*.



**UnExported**

```
read_batch_info()
```

read `detectors` and `sources` parameters from the predefined csv files.

Return a tuple 	   (detectors*array, 		srcHeights*array, 		srcRhos*array, 		srcRadii*array, 		srcLengths*array, 		GeoEfficiency*isPoint)


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L179-L194' class='documenter-source'>source</a><br>


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


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L202-L223' class='documenter-source'>source</a><br>

