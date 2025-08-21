### ActivityViewController in B4XPages? by Nicolás Cieri
### 08/20/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/121420/)

Hi, how can I pass the parameter Page1 (for example), if I'm using B4XPages.?  
  
I tried.. Dim mp As Page = B4XPages.GetPage("B4XMapPage")  
  
But I get an error….  
  

```B4X
   Dim avc As ActivityViewController  
  
   avc.Initialize("avc", Array("Some text to share together with an image", LoadBitmap(File.DirAssets, "smiley.png")))  
  
   avc.Show(Page1, Page1.RootPanel) 'Second parameter is relevant for iPad only. The arrow will point to the view.
```

  
  
  
  
Updated (sorry, this is not tutorial)… the solution is  
  

```B4X
    Dim mp As Page = B4XPages.GetNativeParent(Me)
```