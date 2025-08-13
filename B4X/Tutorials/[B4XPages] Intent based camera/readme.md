###  [B4XPages] Intent based camera by Erel
### 07/23/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/120721/)

**This solution will not work with Android 14+. Please use the more powerful MediaChooser instead: [[B4X] MediaChooser - cross platform videos and images chooser](https://www.b4x.com/android/forum/threads/161093/#content)**  
  
B4A + B4i project that uses an intent in B4A and the Camera object in B4i to take a picture using the default camera app.  
  
The B4A code depends on JpegUtils: <https://www.b4x.com/android/forum/threads/11629/#content>  
It rotates the bitmap based on the EXIF orientation attribute.  
  
Don't miss:  
- Manifest code in B4A.  
- #PListExtra in main module in B4i.  
  
B4i code was updated to fix an issue with the top page being removed from B4XPages stack.  
  
The change adds a line before and after the Wait For Camera\_Complete call:  

```B4X
Dim TopPage As String = B4XPages.GetManager.GetTopPage.Id  
Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)  
B4XPages.GetManager.mStackOfPageIds.Add(TopPage) 'this is required as the page will be removed from the stack when the external camera page appears.
```