
<a id='Output_Interface-1'></a>

# Output_Interface

<a id='GeoEfficiency.calc' href='#GeoEfficiency.calc'>#</a>
**`GeoEfficiency.calc`** &mdash; *Function*.



```julia
calc(detector::Detector = Detector(), aSource::Tuple{Point, Float64, Float64,} = source())
```

calculate and display on the `console` the `geometrical efficiency` of the  detector `detector` for the tuple `aSource` describing the source.

**`Throw`** an Error if the source location is inappropriate.

**see also:** [`geoEff(::Detector, ::Tuple{Point, Float64, Float64})`](Calculations.html#GeoEfficiency.geoEff)

!!! note
    if source description `aSource` alone or even both source description and detector `detect`   are missing, the method prompt the user to complete the missing data via the `console`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L76-L91' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.calcN' href='#GeoEfficiency.calcN'>#</a>
**`GeoEfficiency.calcN`** &mdash; *Function*.



```julia
calcN()
```

calculate and display the `geometrical efficiency` repeatedly.  Prompt the user to input a `detector` and a `source` from the `console`. Prompt the user `repeatedly` until it exit (give a choice to use the same  detector or a new detector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L108-L117' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.batch' href='#GeoEfficiency.batch'>#</a>
**`GeoEfficiency.batch`** &mdash; *Function*.



```julia
batch()
```

provide batch calculation of the `geometrical efficiency` based on the information provided  by the **$CSV$** files by default located in **$C:\Users\Mohamed\GeoEfficiency$**.

results are saved on a **$CSV$**  file(s) named after the detector(s). the **$CSV$**  file(s)  by default found in **$C:\Users\Mohamed\GeoEfficiency\results$**, also a log of the results are displayed on the `console`.

**for more information on batch refer to [`batchInfo`](Output_Interface.html#GeoEfficiency.batchInfo).**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L172-L184' class='documenter-source'>source</a><br>


```
batch(
	detector::Detector,
	srcHeights_array::Vector{S},
	srcRhos_array::Vector{S}=[0.0],
	srcRadii_array::Vector{S}=[0.0],
	srcLengths_array::Vector{S}=[0.0],
	ispoint::Bool=true
	)::String 	where S <: Real
```

provide batch calculation of the `geometrical efficiency` for the detector `detector`.  results are saved on a **$CSV$**  file named after the detector.  the **$CSV$**  file by default found in **$C:\Users\Mohamed\GeoEfficiency\results$**. this method return the actual  path to the **$CSV$** file.  also a log of the results are displayed on the `console`.

  * `srcHeights_array`: list of source heights to feed to batch.
  * `srcRhos_array`: list of source off-axis distances to feed to batch.
  * `srcRadii_array`: list of source radii to feed to batch.
  * `srcLengths_array`: list of source lengths to feed to batch.

A set of sources is constructed of every valid **combination** of parameter in the `srcRhos_array`, `srcRadii_array` and `srcLengths_array` arrays with conjunction with `ispoint`.

!!! warning
      * If `ispoint` is $true$ the source type is a point source and the parameters   in `srcRadii_array` and `srcLengths_array` arrays is completely ignored.
      * If `ispoint` is $false$ the parameters in srcRhos_array is completely ignored.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L187-L217' class='documenter-source'>source</a><br>


```
batch( 
	detectors_array::Vector{<: Detector},
    srcHeights_array::Vector{S},
    srcRhos_array::Vector{S}=[0.0],
    srcRadii_array::Vector{S}=[0.0],
    srcLengths_array::Vector{S}=[0.0],
	ispoint::Bool=true
	)::Vector{String} where S <: Real
```

**same as [`batch(::Detector, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool)`](Output_Interface.html#GeoEfficiency.batch)** but accept a list of detectors `detectors_array`. return a list of paths to the **$CSV$** of files (file for each detector) storing the results.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L244-L258' class='documenter-source'>source</a><br>


```
batch(
	detector_info_array::Matrix{S},
	srcHeights_array::Vector{S},
	srcRhos_array::Vector{S}=[0.0],
	srcRadii_array::Vector{S}=[0.0],
	srcLengths_array::Vector{S}=[0.0],
	ispoint::Bool=true
	)::Vector{String} 	where S <: Real
```

**same as [`batch(::Vector{Detector}, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool)`](Output_Interface.html#GeoEfficiency.batch)** but provide batch calculation of the  `geometrical efficiency` for the detector in the `detector_info_array` after applying `getDetectors`. return a list of paths to the **$CSV$** of files (file for each detector) storing the results.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L296-L311' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.batchInfo' href='#GeoEfficiency.batchInfo'>#</a>
**`GeoEfficiency.batchInfo`** &mdash; *Constant*.



The function `batch()` can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved   Values [CSV] files, that can be easily edit by Microsoft Excel,  by default located in the directory **$C:\Users\Mohamed\GeoEfficiency$** .

results of batch calculation are saved on a **$CSV$**  file(s) named after the detector(s).  the **$CSV$**  file by default found in **$C:\Users\Mohamed\GeoEfficiency\results$**.

**CSV input files**

  * $Detectors.csv$ contains the detectors description; The line format is:

```
	 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |
	 ---------------| ---------------|-------------|----------- |
```

  * $srcHeights.csv$ contains the source heights;

```
	 Source_Heights | 
	 ---------------|
```

  * $srcRhos.csv$ contains the source off-axis distances;

```
	 Source_Rhos | 
 	 ------------|
```

  * $srcRadii.csv$ contains the source radii for disc and cylindrical sources;

```
	 Source_Radii| 
	 ------------|
```

  * $srcLengths.csv$ contains the source length for cylindrical sources;

```
	 Source_Lengths| 
	 --------------|
```

**CSV results files**

**$CSV$**  file containing the results has columns of headers   `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency` for `non-point` sources   and columns of headers `Height`, `Rho`, `GeoEfficiency` for `point` sources.

!!! note
    for Comma Saved Values [CSV] files each line represent an entry,   the first line is always treated as the header.


!!! warning
    the program expect each line to contain one number for all CSV files except  for $Detectors.csv$ each line should contain at least one number or at   most four separated numbers.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L495-L546' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.checkResultsDirs' href='#GeoEfficiency.checkResultsDirs'>#</a>
**`GeoEfficiency.checkResultsDirs`** &mdash; *Function*.



**UnExported**

```
checkResultsDirs()
```

make sure that directories for saving the results are already exist or create  them if necessary.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L28-L36' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.writecsv_head' href='#GeoEfficiency.writecsv_head'>#</a>
**`GeoEfficiency.writecsv_head`** &mdash; *Function*.



**unexported**

```
writecsv_head(filename::AbstractString, content::VecOrMat{<:Union{Int,Float64}}, head=[])
```

Write `content` to the comma delimited values file `filename`.  optionally with header `head`.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L152-L160' class='documenter-source'>source</a><br>

<a id='GeoEfficiency._max_batch' href='#GeoEfficiency._max_batch'>#</a>
**`GeoEfficiency._max_batch`** &mdash; *Constant*.



-ve value will display all batch results on


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L20-L22' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.max_batch' href='#GeoEfficiency.max_batch'>#</a>
**`GeoEfficiency.max_batch`** &mdash; *Function*.



```julia
max_batch(n<:Real)
```

set the value of '*max*batch' which default to 20 which control the maxumam number of  entries per detector that permit the detector efficiency calculation to be displayed on console.  this function `do not` affect the saving of the batch calculation. 

-ve value of n result in displaying all batch calculation results on the console.

**see also: [`max_batch()`](Output_Interface.html#GeoEfficiency.max_batch)**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L46-L58' class='documenter-source'>source</a><br>


```
max_batch()
```

set the value of '*max*batch' to its default value.

**see also: [`max_batch(::Integer)`](Output_Interface.html#GeoEfficiency.max_batch)**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L63-L70' class='documenter-source'>source</a><br>

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

batch calculation for specialized for **$point$** sources.  return a tuple of three arrays the `detector`, the `results`and the path of the **$CSV$**  file containing results. 

The `results` has columns of headers `Height`, `Rho`, `GeoEfficiency`.

!!! note
    for all arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array` and `srcLengths_array`   element type should be $Float64$. if any of them have other numerical element type it   should converted to $Float64$ using `float` before passing it to this method.


!!! warning
    both `srcRadii_array`, `srcLengths_array` are completely ignored as this method is for point sources.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L328-L354' class='documenter-source'>source</a><br>


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

batch calculation for specialized for **$non-point$** sources.  return a tuple of three arrays the `detector`, the `results`and the path of the **$CSV$**  file containing results. 

The `results` has columns of headers  `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency`.

!!! note
    for all arrays `srcHeights_array`, `srcRhos_array`, `srcRadii_array` and `srcLengths_array`  element type should be $Float64$. if any of them have other numerical element type it  should converted to $Float64$ using `float` before passing it to this method.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/Output_Interface.jl#L403-L427' class='documenter-source'>source</a><br>

