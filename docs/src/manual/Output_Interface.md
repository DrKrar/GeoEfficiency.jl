# Output Interface
Calculation of the geometrical efficiency can be run in one of two modes aside from using `geoEff`, 
the interactive/direct mode and the batch mode.

## Interactive/Direct Mode

```@docs
GeoEfficiency.calc
```
for repeated calculations.

```@docs
GeoEfficiency.calcN
```

## Batch Mode
Use `batch()` to let the program inspect the excel files containing the required information and run the calculations.

```@docs
GeoEfficiency.batch
```

As mentioned above, the batch calculation controlled by CSV files. the following refer to information on the CSV files structure and location.

```@docs
GeoEfficiency.batchInfo
```

The result of the batch calculation is also displayed in the `console`. the function `max_batch(n::Real)` can be used to give a hint (thus it may or may not apply) to the program to limit displayed results.

```@docs
GeoEfficiency.max_batch(n::Real)
```

Also the without arguments `max_batch()` restore back the default value.

```@docs
GeoEfficiency.max_batch()
```

Before the batch mode start  the user is asked to decide the source type. once the calculation is done the user can check the current setting for the source or modify it. for details see the next section.