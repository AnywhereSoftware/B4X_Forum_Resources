### OSMDroid 6 by Ivica Golubovic
### 12/22/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/147200/)

The time has finally come to release a new version of the **OSMDroid** library that is based on the original version **6.1.15 from GitHub**. This new version is completely new and is not based on an upgrade of the previous version found in this forum. The new version works on new versions of Android because it places the cache files in a location allocated by the system, and not in external memory like the previous one. Of course, in addition to that, it is much improved and supports a larger number of online map providers.  
  
In addition to standard tile source providers such as **MAPNIK, WIKIMEDIA, PUBLIC TRANSPORT**, etc. also supports **BingMaps, HereWeGo, MapBox, MapQuest and ThunderForest** (all of these require a free or paid API key).  
  
The main object of this library is the **MapView** which can be added via the designer. All other objects are added to the existing **MapView** as **Overlays** (**Marker, Polygon, Polyline, Compass**, etc.). Also a very important object is a static class module called **OSMDroid6Configuration** through which you can set the basic parameters of the library.  
  
In addition to standard multiline coding, this library enables single line coding like some more advanced programming languages. For this, the **OSMDroid6** static class module is used where you can find constructors like **NewMarker, NewPolyline, NewPolygon, NewBingMapTileSource** and constructors for all objects in the library. Of course, it's up to you to decide which programming method works best for you (I personally prefer a combination of both methods).  
  

```B4X
Dim mMarker As Marker  
mMarker.Initialize(MapView1)  
mMarker.SetPosition2(45,21)  
mMarker.SetIcon2(LoadBitmap(File.DirAssets,"DrivingModeMarker.png"))  
mMarker.SetDraggable(True)
```

  
  

```B4X
Dim mMarker As Marker = OSMDroid6.NewMarker(MapView1).SetPosition2(45,21).SetIcon2(LoadBitmap(File.DirAssets,"DrivingModeMarker.png")).SetDraggable(True)
```

  
  
The library contains a large number of static class modules that allow easier access to certain methods and constants. For these classes, it is not necessary to define and initialize a variable, but they behave like B4X modules.  
  
Due to the limitation in the size of the file that can be uploaded, the rar archive is divided into several files that need to be unzipped with the help of **WinRar**. Unrar all the files from the archive to the Additional library folder. Also, the **OSMD6\_Doc** archive file is attached.  
  
There are no examples or tutorials attached because the library is large and compact and its functions are impossible to fit into a few short examples. For all necessary tutorials, post in this thread. Of course, try to figure out the basics from the shaded Doc file. Anyone who has used **GoogleMaps** or previous versions of **OSMDroid** should have no problem using this library because it is based on a similar principle.  
  
**Small example added!!! To run example you must download [OSMDroid6BonusPack](https://www.b4x.com/android/forum/threads/osmdroid-6-bonuspack.147211/) library.**  
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>