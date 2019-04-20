
<a id='Summery-1'></a>

# Summery

<a id='GeoEfficiency.about' href='#GeoEfficiency.about'>#</a>
**`GeoEfficiency.about`** &mdash; *Function*.



```
 *************************************************
 **            -=) GeoEfficiency (=-             **
 **  Accurate Geometrical Efficiency Calculator  **
 **   First Created on Fri Aug 14 20:12:01 2015  **
 *************************************************

 Author:        Mohamed E. Krar,  @e-mail: DrKrar@gmail.com 
 Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3
 Repository:    https://github.com/DrKrar/GeoEfficiency.jl/
 Version:       v"0.9.4-dev" - (2 days old master)  
 Documentation: https://GeoEfficiency.GitHub.io/dev/index.html
 PDF_Manual:    https://GeoEfficiency.GitHub.io/dev/GeoEfficiency.jl.pdf



Batch Mode Calculations 
-  read files by defaul from directory `/home/GeoEfficiency`
-  save results by default to directory `/home/GeoEfficiency/results`

for more information see `batch`, `batchInfo`.
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/7c1c83a3b86d70ff37ea1ddf467eba19f6ee7986/src/GeoEfficiency.jl#L91-L116' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.GeoEfficiency' href='#GeoEfficiency.GeoEfficiency'>#</a>
**`GeoEfficiency.GeoEfficiency`** &mdash; *Module*.



**GeoEfficiency Package**

introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency`  for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form  a source. The source can be a point, a disc or even a cylinder.

**Quick Usage**

  * geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.
  * calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.
  * calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.
  * batch()	: Calculate the geometrical efficiency using data in the **`/home/GeoEfficiency`** folder in batch mode.

!!! note
    for more information and updates refer to the repository at [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)



<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/7c1c83a3b86d70ff37ea1ddf467eba19f6ee7986/src/GeoEfficiency.jl#L3-L23' class='documenter-source'>source</a><br>

