This section is provided for devloper who are intrested in extending the functionality of the `GeoEfficiency` package or just make use of some of its functionality. this softawre is licenced under
the MIT licence. 

```
MIT "Expat" License

 Copyright (c) 2019: Mohamed Krar.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software with an appropriate reference to 
 the original work.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
```

# Configuration

found in the source file `Config.jl`

parameter | describtion| default value
:----------|:------------|:--------------:
dataFolder | name of the root directory | "GeoEfficiency"
dataDir    |  root directory            | joinpath(homedir(), dataFolder)
integrate  |  use the package `QuadGK` to perform integration | begin using QuadGK; QuadGK.quadgk; end
relativeError |                         | 1.0E-4  
absoluteError |                         | eps(1.0)
resultsFolder | name of the result directory inside the root directory | "results"  
max_display   | define the default for maximum number of entries shown in the `console` in batch mode | 20 **see [`max_batch`](@ref)**

# Error System

```@docs
GeoEfficiency.GeoException
```

```@docs
GeoEfficiency.InValidDetectorDim
```

```@docs
GeoEfficiency.@validateDetector
```

```@docs
GeoEfficiency.NotImplementedError
```

```@docs
GeoEfficiency.@notImplementedError

```

# Console Input
Julia language is quite reach langauge but it seems a good idea thought to collect repeated tasks involing input from console in compact and coustumized to the need function.
this section provid two essential functions to deal with inputs from the console. the first:

```@docs
GeoEfficiency.input
```

while the secand is a more complex function:

```@docs
GeoEfficiency.getfloat
```

Those function are not exported that is normally the user will not need to use them but they are documented here to allow a develober ranked user to make use of them.

# Physics Model

Two abstract detector types defined in the package to classify the detectors, the top most super type,

```@docs
GeoEfficiency.RadiationDetector
```

any future detector defination should inhert from `RadiationDetector`. The secand abstract detector   `Detector` is also a sub-type of `RadiationDetector` but it only acomodates cylinderical type only.

```@docs
GeoEfficiency.Detector
```

can be used to constract leaf detector.

```@docs
Detector()
```

also it can be used to construct a concrete detector depend on the provided arguments.

```@docs
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real, HoleDepth::Real)
```

```@docs
Detector(CryRadius::Real)
```

```@docs
Detector(CryRadius::Real, CryLength::Real)
```

```@docs
Detector(CryRadius::Real, CryLength::Real, HoleRadius::Real)
```

# Output Interface

```@docs
GeoEfficiency.checkResultsDirs
```

```@docs
GeoEfficiency.writecsv_head
```

```@docs
GeoEfficiency._max_batch
```

```@docs
GeoEfficiency.max_batch
```

```@docs
GeoEfficiency._batch
```