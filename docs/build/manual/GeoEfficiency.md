
<a id='GeoEfficiency-1'></a>

# GeoEfficiency

<a id='GeoEfficiency.GeoEfficiency' href='#GeoEfficiency.GeoEfficiency'>#</a>
**`GeoEfficiency.GeoEfficiency`** &mdash; *Module*.



**GeoEfficiency Package**

introduce a fast and flexible tool to calculate in batch or individually the `geometrical efficiency`  for a set of common radiation detectors shapes (cylindrical,Bore-hole, Well-type) as seen form  a source. The source can be a point, a disc or even a cylinder.

**Quick Usage**

  * geoEff()	: Calculate the geometrical efficiency for one geometrical setup return only the value of the geometrical efficiency.
  * calc() 	: Calculate the geometrical efficiency for one geometrical setup and display full information on the console.
  * calcN()	: Calculate the geometrical efficiency for geometrical setup(s) and display full information on the console until the user quit.
  * batch()	: Calculate the geometrical efficiency using data in the **`C:\Users\Mohamed\GeoEfficiency`** folder in batch mode.

**for more information and updates refer to the repository at [`GitHub.com`](https://github.com/DrKrar/GeoEfficiency.jl/)**


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/GeoEfficiency.jl#L3-L21' class='documenter-source'>source</a><br>

<a id='GeoEfficiency.about' href='#GeoEfficiency.about'>#</a>
**`GeoEfficiency.about`** &mdash; *Function*.



```julia
 *************************************************
 **            -=) GeoEfficiency (=-            **
 **  Accurate Geometrical Efficiency Calculator **
 **   First Created on Fri Aug 14 20:12:01 2015 **
 *************************************************

 Author:        Mohamed E. Krar,  @e-mail: DrKrar@gmail.com 
 Auth_Profile:  https://www.researchgate.net/profile/Mohamed_Krar3
 Repository:    https://github.com/DrKrar/GeoEfficiency.jl/
 Version:       v"0.9.3-DEV" - (1 day old master)  
 Documentation: http://geoefficiencyjl.readthedocs.org



Batch mode 
-  read files by defaul from directory `C:\Users\Mohamed\GeoEfficiency`
-  save results by default to directory `C:\Users\Mohamed\GeoEfficiency\results`

for more information see `batch`, `batchInfo`.
```


<a target='_blank' href='https://github.com/DrKrar/GeoEfficiency.jl/blob/e5ffee5e1fad9546674a2a8813770c7d81cf1064/src/GeoEfficiency.jl#L85-L109' class='documenter-source'>source</a><br>

