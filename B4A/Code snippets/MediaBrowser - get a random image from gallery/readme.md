### MediaBrowser - get a random image from gallery by Alexander Stolte
### 08/27/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/121653/)

```B4X
Dim MB As MediaBrowser  
MB.Initialize("MB")  
Dim tmp_m As Map = MB.GetMediaImageList(True, "datetaken DESC")  
xiv.SetBitmap(LoadBitmapResize(tmp_m.Get("Location" & Rnd(0,tmp_m.Size/7)),"",xiv.Width,xiv.Height,True))
```