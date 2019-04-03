
<a id='Batch-Input-1'></a>

# Batch Input

<a id='GeoEfficiency.typeofSrc' href='#GeoEfficiency.typeofSrc'>#</a>
**`GeoEfficiency.typeofSrc`** &mdash; *Function*.



```julia
typeofSrc()::SrcType
```

return the current value of the global `GeoEfficiency.srcType`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L30-L35' class='documenter-source'>source</a><br>


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


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L38-L50' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.setSrcToPoint' href='#GeoEfficiency.setSrcToPoint'>#</a>
**`GeoEfficiency.setSrcToPoint`** &mdash; *Function*.



```julia
setSrcToPoint()::Bool
```

return whether the source type is a point or not.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L64-L68' class='documenter-source'>source</a><br>


```
setSrcToPoint(yes::Bool)::Bool
```

return whether the source type is a point or not after setting `srcType` to `srcPoint` if  `yes` = `true` else if `yes` = `false` setting it to `srcNotPoint` if it was not already  set to other non-point type (`srcDisk`, `srcLine`, `srcVolume`).

!!! note
      * The user can use this function to change the source type any time.
      * The source type is set the fist time asked for source.


**see also:** [`typeofSrc(::Int)`](Input_Batch.html#GeoEfficiency.typeofSrc).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L71-L85' class='documenter-source'>source</a><br>


```
setSrcToPoint(prompt::AbstractString)::Bool
```

return whether the source type is a point or not. only prompt the user to set the source  type if it were not already set before. 

**see also:** [`typeofSrc(::Int)`](Input_Batch.html#GeoEfficiency.typeofSrc), [`setSrcToPoint(::Bool)`](Input_Batch.html#GeoEfficiency.setSrcToPoint).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L97-L105' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.detector_info_from_csvFile' href='#GeoEfficiency.detector_info_from_csvFile'>#</a>
**`GeoEfficiency.detector_info_from_csvFile`** &mdash; *Function*.



**UnExported**

```
 detector_info_from_csvFile(detectors::AbstractString = Detectors, 
                                  datadir::AbstractString = dataDir)
```

return a vector{Detector} based on information in the file of name `detectors` found in the  directory `datadir`.

!!! note
      * if no path is given the second argument `datadir` is default to `C:\Users\Mohamed\GeoEfficiency` as set by   the constant `dataDir`.
      * if no file name is specified the name of the predefined file `Detectors.csv` as set by   the constant `Detectors`.
      * the no argument method is the most useful; other methods are mainly for `test propose`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/80fc863a779b15110f68d913df38b318e3410150/src/Input_Batch.jl#L112-L127' class='documenter-source'>source</a><br>

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

