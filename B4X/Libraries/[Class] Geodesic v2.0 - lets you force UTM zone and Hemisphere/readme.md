###  [Class] Geodesic v2.0 - lets you force UTM zone and Hemisphere by knutf
### 07/02/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171433/)

WGS84 UTM <-> Latitude/Longitude conversion  
  
Based on the original Geodesic class by Erel that is in [this](https://www.b4x.com/android/forum/threads/b4x-class-geodesic-convert-lat-lon-utm-coordinates.30702/) thread. The interface of version 2.0 is fully compatible with Erel's class  
  
The great thing about UTM is that you can, for example, calculate the distance between two points on the Earth's surface in meters with simple geometry (It will fail if the points are to many degrees apart in east-west direction).  
  
The old class automatically calculates the UTM zone. However, this means that if two points you want to work with are in different UTM zones, the geometry is not quite as easy to handle anymore.  
  
In the 2.0 version, there is a new method, WGS84LatLonToUTM2, which makes it possible to lock the transformation from LatLon to UTM to a specific UTM zone, so that you are sure that all the points you are working with are transformed to the same UTM zone.  
  
The mathematical model used in Erel's version of the class is inaccurate when you go outside the current UTM zone. I am not a mathematician so I have had good help from Claude to create this version of the class, Claude says that the new class is based on Kruger's series in the third flattening n (Karney 2011, "Transverse Mercator with an accuracy of a few nanometers", eqs. 12 & 17), so accuracy stays sub-millimetre even several degrees from the zone's central meridian  
  
As I said, I am not a mathematician and cannot vouch for this, but I can test whether the result is correct. Still with good help from Claude I have created a test app that tests the results against known transformations. I have used <https://epsg.io/> to create known transformations.  
  
The test app is attached, so you can test yourself whether the transformations are correct. I would like you to test!  
  
Add known transformations in the BuildCases sub of the Geodesictest class and run the test!  
  

```B4X
    Dim geo As Geodesic  
    geo.Initialize  
    Dim BrusselsLL As LatLon  
    BrusselsLL.Initialize  
    BrusselsLL.Lat = 50.840527  
    BrusselsLL.Lon = 4.339600  
    Dim BrusselsUTM As UTM = geo.WGS84LatLonToUTM(BrusselsLL)  
    Dim Oxford As LatLon  
    Oxford.Initialize  
    Oxford.Lat = 51.760934  
    Oxford.Lon = -1.252441  
    Dim OxfordUTM As UTM = geo.WGS84LatLonToUTM2(Oxford,BrusselsUTM.UtmXZone,BrusselsUTM.NorthHemisphere)  
    Dim distance As Double = Sqrt( Power(OxfordUTM.X - BrusselsUTM.X,2)+Power(OxfordUTM.Y-BrusselsUTM.Y,2))
```