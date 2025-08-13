### jGoogleMaps library by Erel
### 05/22/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/56744/)

**The latest version of Google Maps isn't compatible with JavaFX WebView. Don't use this library.  
Alternative solution: <https://www.b4x.com/android/forum/threads/jsd_openmaps.166066/#content>**  
  
  
This library is similar to B4A and B4i GoogleMaps libraries.  
  
![](https://www.b4x.com/basic4android/images/SS-2015-07-30_15.35.52.jpg)  
  
It is based on this open source project: <https://github.com/dlsc-software-consulting-gmbh/GMapsFX/> (Apache 2 license).  
Under the hood it uses JavaFX WebView with GoogleMaps JavaScript API V3.  
  
Using the map is quite simple. You need to initialize GoogleMap and then wait for the Ready event.  
GoogleMap.AsPane returns the pane that holds the map. You should add this pane to the nodes tree.  
  
Once the ready event is fired you can add markers or change the position.  
  
**Updates**:  
  
V2.01 - Sets the Google Maps Javascript SDK version to 3.56. There is currently an issue with JavaFX and Google Maps v3.57. A big thank you to [USER=101440]@Star-Dust[/USER] for helping with solving this issue!  
V2.00 - Depends on OpenJDK 19. Previous versions will not work.  
  
1. OpenJDK 19.0.2 + OpenJFX 17.0.6: <https://www.b4x.com/b4j/files/jdk-19.0.2.7z>  
2. Add to main module:  

```B4X
#PackagerProperty: IncludedModules = javafx.web  
#PackagerProperty: AdditionalModuleInfoString = exports com.lynden.gmapsfx;    exports com.lynden.gmapsfx.javascript;    exports com.lynden.gmapsfx.javascript.event;  
#PackagerProperty: AdditionalModuleInfoString = exports com.lynden.gmapsfx.javascript.object;    exports com.lynden.gmapsfx.service.directions;    exports com.lynden.gmapsfx.service.elevation;  
#PackagerProperty: AdditionalModuleInfoString = exports com.lynden.gmapsfx.service.geocoding;    exports com.lynden.gmapsfx.shapes;    exports com.lynden.gmapsfx.zoom;
```

  
3. Add reference to jOkHttpUtils2.  
  
Tip: to fix logging encoding issues with Java 19+, add this:  

```B4X
#VirtualMachineArgs: -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8  
#PackagerProperty: VMArgs = -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8
```

  
  
The standalone package will not work without steps 2 and 3.