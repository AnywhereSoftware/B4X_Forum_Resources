### [class]GoogleMapsExtra by Erel
### 11/05/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/56871/)

This class extends GoogleMaps library.  
Currently it supports:  
- AddCircle - Adds a circle at a give point.  
- AddGroundOverlay - Adds an image at the given bounds.  
- ZoomToPoints  
- SetSelectedMarker  
- SetMarkerRotation  
- SetGroundAnchor - sets the marker anchor.  
- AddPolygon  
  
  
Example:  

```B4X
gextra.Initialize(gmap)  
Dim ne, sw As LatLng  
ne.Initialize(20, 20)  
sw.Initialize(00, 00)  
Dim bounds As Object = gextra.CreateBounds(ne, sw)  
gextra.AddGroundOverlay(bounds, LoadBitmap(File.DirAssets, "up76.png"))
```

  
  
  
Updates:  
  
v2.15 - New AnimateCameraWithDuration method. Same as gmap.AnimateCamera with configurable duration.  
v2.10 - Adds support for custom info windows (appear when the user clicks on a marker).  
  
You need to add this event sub and create the custom panel or return Null:  

```B4X
'Return Null for the default marker layout  
Sub gmap_MarkerInfoWindow (OMarker As Object) As Object  
   Dim SelectedMarker As Marker = OMarker  
   Dim p As Panel  
   p.Initialize("")  
   p.Color = Colors.Red  
   p.SetLayoutAnimated(0, 1, 0, 0, 200, 200)  
   Dim lbl As Label  
   lbl.Initialize("")  
   lbl.Text = SelectedMarker.Title  
   p.AddView(lbl, 10, 10, 200, 200)  
   Return p  
End Sub
```

  
  
Project is available here: <https://www.b4x.com/b4i/files/GoogleMaps.zip>  
Don't miss the bundle under Files\Special.