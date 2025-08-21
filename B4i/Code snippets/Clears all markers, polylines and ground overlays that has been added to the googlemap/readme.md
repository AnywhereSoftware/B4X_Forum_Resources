### Clears all markers, polylines and ground overlays that has been added to the googlemap by Mr.Coder
### 03/04/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/114572/)

Hi,  
  
Clears all markers, polylines and ground overlays that has been added to the googlemap.  
  
Usage :  
  

```B4X
Sub ClearTheMap(gMapView As GoogleMap)     
    Dim NO As NativeObject = Me  
    NO.RunMethod("clearMap:", Array As Object(gMapView))  
End Sub
```

  
  

```B4X
#If OBJC  
- (void) clearMap:(GMSMapView *)gMapView {  
   [gMapView clear];  
   }  
#End If
```

  
  
Note : This will not clear the visible location dot or reset the current mapType.