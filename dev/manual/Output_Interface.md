
<a id='Output-Interface-1'></a>

# Output Interface


Calculation of the geometrical efficiency can be run in one of two modes aside from using `geoEff`,  the interactive mode and the batch mode.


<a id='Interactive-Mode-1'></a>

## Interactive Mode

<a id='GeoEfficiency.calc' href='#GeoEfficiency.calc'>#</a>
**`GeoEfficiency.calc`** &mdash; *Function*.



```
calc(detector::Detector = Detector(), aSource::Tuple{Point, Float64, Float64,} = source())
```

calculate and display on the `console` the `geometrical efficiency` of the  detector `detector` for the tuple `aSource` describing the source.

**`Throw`** an  `inValidGeometry` if the source location is inappropriate.

**see also:** [`geoEff(::Detector, ::Tuple{Point, Float64, Float64})`](Calculations.md#GeoEfficiency.geoEff)

!!! note "Missing/No Argument(s)"
    if source description `aSource` alone or even both source description and detector `detect`   are missing, the method prompt the user to complete the missing data via the `console`.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L90-L106' class='documenter-source'>source</a><br>


for repeated calculations.

<a id='GeoEfficiency.calcN' href='#GeoEfficiency.calcN'>#</a>
**`GeoEfficiency.calcN`** &mdash; *Function*.



```
calcN()
```

calculate and display the `geometrical efficiency` repeatedly.  Prompt the user to input a `detector` and a `source` from the `console`. Prompt the user `repeatedly` until it exit (give a choice to use the same  detector or a new detector).


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L123-L133' class='documenter-source'>source</a><br>


<a id='Batch-Mode-1'></a>

## Batch Mode

<a id='GeoEfficiency.batch' href='#GeoEfficiency.batch'>#</a>
**`GeoEfficiency.batch`** &mdash; *Function*.



```
batch()
```

provide batch calculation of the `geometrical efficiency` based on the information provided  by the **`CSV`** files by default located in **`/home/travis/GeoEfficiency`**.

results are saved on a **`CSV`**  file(s) named after the detector(s). the **`CSV`**  file(s)  by default found in **`/home/travis/GeoEfficiency/results`**, also a log of the results are displayed on the `console`.

**for more information on batch refer to [`batchInfo`](Output_Interface.md#GeoEfficiency.batchInfo).**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L189-L202' class='documenter-source'>source</a><br>


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

provide batch calculation of the `geometrical efficiency` for the detector `detector`.  results are saved on a **`CSV`**  file named after the detector.  the **`CSV`**  file by default found in **`/home/travis/GeoEfficiency/results`**. this method return the actual  path to the **`CSV`** file.  also a log of the results are displayed on the `console`.

  * `srcHeights_array`: list of source heights to feed to batch.
  * `srcRhos_array`: list of source off-axis distances to feed to batch.
  * `srcRadii_array`: list of source radii to feed to batch.
  * `srcLengths_array`: list of source lengths to feed to batch.

A set of sources is constructed of every valid **combination** of parameter in the `srcRhos_array`, `srcRadii_array` and `srcLengths_array` arrays with conjunction with `ispoint`.

!!! warning "point/cylinder source"
      * If `ispoint` is `true` (the default) the source type is a point source and the parameters   in `srcRadii_array` and `srcLengths_array` arrays is completely ignored.
      * If `ispoint` is `false` the parameters in srcRhos_array is completely ignored.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L205-L236' class='documenter-source'>source</a><br>


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

**same as [`batch(::Detector, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool)`](Output_Interface.md#GeoEfficiency.batch)** but accept a list of detectors `detectors_array`. return a list of paths to the **`CSV`** of files (file for each detector) storing the results.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L263-L279' class='documenter-source'>source</a><br>


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

**same as [`batch(::Vector{Detector}, ::Vector{Real},::Vector{Real},::Vector{Real},::Vector{Real},::Bool)`](Output_Interface.md#GeoEfficiency.batch)** but provide batch calculation of the  `geometrical efficiency` for the detector in the `detector_info_array` after applying `getDetectors`. return a list of paths to the **`CSV`** of files (file for each detector) storing the results.


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L317-L334' class='documenter-source'>source</a><br>


The batch calculation controlled by CSV files. the following refer to information on the CSV files structure and location.

<a id='GeoEfficiency.batchInfo' href='#GeoEfficiency.batchInfo'>#</a>
**`GeoEfficiency.batchInfo`** &mdash; *Constant*.



The function `batch()` can be called with or without arrangement(s).  The without argument version relay on previously prepared Comma Saved   Values [CSV] files, that can be easily edit by Microsoft Excel,  by default located in the directory **`/home/travis/GeoEfficiency`** .

results of batch calculation are saved on a **`CSV`**  file(s) named after the detector(s).  the **`CSV`**  file by default found in **`/home/travis/GeoEfficiency/results`**.

**CSV input files**

  * `Detectors.csv` contains the detectors description; The line format is:

```
	 Crystal_Radius | Crystal_Length | Hole_Radius | Hole_Depth |
	 ---------------| ---------------|-------------|----------- |
```

  * `srcHeights.csv` contains the source heights;

```
	 Source_Heights | 
	 ---------------|
```

  * `srcRhos.csv` contains the source off-axis distances;

```
	 Source_Rhos | 
 	 ------------|
```

  * `srcRadii.csv` contains the source radii for disc and cylindrical sources;

```
	 Source_Radii| 
	 ------------|
```

  * `srcLengths.csv` contains the source length for cylindrical sources;

```
	 Source_Lengths| 
	 --------------|
```

**CSV results files**

**`CSV`**  file containing the results has columns of headers   `AnchorHeight`, `AnchorRho`, `srcRadius`, `srcLength`, `GeoEfficiency` for `non-point` sources   and columns of headers `Height`, `Rho`, `GeoEfficiency` for `point` sources.

!!! note
    for Comma Saved Values [CSV] files each line represent an entry,   the first line is always treated as the header.


!!! warning
    the program expect each line to contain one number for all CSV files except  for `Detectors.csv` each line should contain at least one number or at   most four separated numbers.



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L516-L569' class='documenter-source'>source</a><br>


The result of the batch calculation is also displayed in the `console`. the function `max_batch(n::Real)` can be used to give a hint (thus it may or may not apply) to the program to limit displayed results.

<a id='GeoEfficiency.max_batch-Tuple{Real}' href='#GeoEfficiency.max_batch-Tuple{Real}'>#</a>
**`GeoEfficiency.max_batch`** &mdash; *Method*.



```
max_batch(n::Real)
```

set the value of `_max_batch` which give a hint to the program on maximum number of entries per  detector displayed on the `console` in batch mode. This function `do not` affect the saving of the batch calculation. 

!!! note



```
Negative value will display prevent batch results from printed to the `console`. 
while `Inf` will print all  batch results to the `console`.
```

**see also: [`max_batch()`](Output_Interface.md#GeoEfficiency.max_batch-Tuple{})**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L55-L70' class='documenter-source'>source</a><br>


also the without arguments `max_batch()` restore back the default vaule.

<a id='GeoEfficiency.max_batch-Tuple{}' href='#GeoEfficiency.max_batch-Tuple{}'>#</a>
**`GeoEfficiency.max_batch`** &mdash; *Method*.



```
max_batch()
```

set the value of `_max_batch` which give a hint to the program on maximum number of entries per  detector displayed on the `console` in batch mode. to its default value set by the constant [`max_display`](Development.md#GeoEfficiency.max_display).

**see also: [`max_batch(n::Real)`](Output_Interface.md#GeoEfficiency.max_batch-Tuple{Real})**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/dc26f093229830eb5c29cddc2172c996844d1f0e/src/Output_Interface.jl#L75-L84' class='documenter-source'>source</a><br>


Before the batch mode start  the user is asked to decide the source type. once the calculation is done the user can check the current seting for the source or modifiy it. for details see the next section.

