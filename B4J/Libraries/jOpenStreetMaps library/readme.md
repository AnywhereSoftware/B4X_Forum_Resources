### jOpenStreetMaps library by Starchild
### 02/28/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/89089/)

Thanks to "WarWound" and his original library project "JfxtrasMapPane" in the post [OSM Open Street Map for B4J](https://www.b4x.com/android/forum/threads/osm-open-street-map-for-b4j.35554/) back in 2014 which was based on the jfxtras 2.2 r5 source, I have been able to release this updated library.<https://www.b4x.com/android/forum/threads/jopenstreetmaps-library.8>  
  
Bug fixes:  
… Left mouse click now works. In fact all 3 mouse buttons are resolved.  
  
Additions:  
… Polygons can now be added/removed from map (MapPolygon class)  
… Map tile providers have been updated.  
… proper attributions for map tile providers have been added to the maps.  
… now supports a local map cache for faster redraws.  
… added a default Map Icon class containing ready to use icons (pins, car, truck, etc)  
… map markers and can have their size, rotation, shadow set at initialisation.  
  
Most Classes have been renamed and additional properties/functions added to classes.  
… MapPane class is now OpenStreetMaps class.  
… SimpleMapMarker class is now MapSpot class.  
… MapLine is now MapPolyline.  
… Initialisation functions for many classes have been changed and added.  
  
Generally this library is a lot more friendly, in fact similar in a lot of ways to jGooleMaps library.  
  
Just to note that the OpenStreetMap[®](https://www.openstreetmap.org/copyright#trademarks) is *open data*, licensed under the [Open Data Commons Open Database License](https://opendatacommons.org/licenses/odbl/) (ODbL) by the [OpenStreetMap Foundation](https://osmfoundation.org/) (OSMF).  
  
*Mapnik map tiles are released under [LGPL](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt) (GNU Lesser General Public Licence v2.1).  
  
The included map tile sets by © Stamen Design, are under a* [*Creative Commons Attribution (CC BY 3.0)*](http://creativecommons.org/licenses/by/3.0) *license.*  
  
———————————————-  
  
Here is the new library "jOpenStreetMaps" now v1-03  
  
for v1-03 changes refer to [post #14 below](https://www.b4x.com/android/forum/threads/jopenstreetmaps-library.89089/post-714586).  
  
I have also made available an example B4j project called "My OSM Demo".  
The demo has also been updated to demonstrate some of the new features.