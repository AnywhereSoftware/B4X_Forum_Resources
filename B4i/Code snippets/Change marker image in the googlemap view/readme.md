### Change marker image in the googlemap view by Mr.Coder
### 03/04/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/114573/)

Hi,  
  
Changing the marker image in the googlemap view,  
  
Usage :   
  

```B4X
Sub ChangeMarkerImage(Marker As Marker, NewImage As Bitmap)  
    Dim m As NativeObject = Marker  
    m.SetField("icon", NewImage)  
End Sub
```