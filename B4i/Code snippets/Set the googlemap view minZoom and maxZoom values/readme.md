### Set the googlemap view minZoom and maxZoom values by Mr.Coder
### 03/04/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/114571/)

Hi,  
  
to set the googlemap view minZoom and maxZoom values .  
  
Usage :  
  

```B4X
Sub SetMapMinAndMaxZoom(gMapView As GoogleMap,gMin As Float,gMax As Float)  
    Dim NO As NativeObject = Me  
    NO.RunMethod("setMapMinAndMaxZoom:::", Array As Object(gMapView,gMin,gMax))  
End Sub
```

  
  

```B4X
#If OBJC  
- (void) setMapMinAndMaxZoom:(GMSMapView *)gMapView :(float)gMin :(float)gMax {  
   [gMapView setMinZoom:gMin maxZoom:gMax];  
   }  
#End If
```