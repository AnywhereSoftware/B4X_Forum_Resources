### ImageDownloader - The simple way to download images by Erel
### 10/10/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/30875/)

**Don't use this. SimpleMediaManager is 100 times more powerful: [[B4X] SimpleMediaManager (SMM) - framework for images, videos and more](https://www.b4x.com/android/forum/threads/134716/#content)**  
  
Downloading images with HttpUtils2 is quite simple.  
  
However correctly managing multiple downloads without downloading the same image multiple times, for example when the user changes the screen orientation, is more complicated.  
  
ImageDownloader makes it very simple to efficiently download images and show them in ImageViews.  
  
Example code:  

```B4X
Sub Globals  
   Dim ImageView3 As ImageView  
   Dim ImageView2 As ImageView  
   Dim ImageView1 As ImageView  
   Dim ImageView4 As ImageView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   Activity.LoadLayout("1")  
End Sub  
  
Sub Activity_Resume  
   Dim links As Map  
   links.Initialize  
   links.Put(ImageView1, "http://www.b4x.com/basic4android/images/SS-2012-08-29_12.55.42.png")  
   links.Put(ImageView2, "http://www.b4x.com/basic4android/images/SS-2013-03-04_11.42.38.png")  
   links.Put(ImageView3, "http://www.b4x.com/basic4android/images/SS-2013-03-04_11.52.19.png")  
   links.Put(ImageView4, "http://www.b4x.com/basic4android/images/SS-2012-02-06_12.45.56.png")  
   CallSubDelayed2(ImageDownloader, "Download", links)  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
   CallSub(ImageDownloader, "ActivityIsPaused")  
End Sub
```

  
  
**How to use?**  
  
1. In Activity\_Resume you should create a Map with the ImageViews as keys and the links as values. Use CallSubDelayed to call ImageDownloader.Download.  
2. In Activity\_Pause you should use CallSub to call ImageDownloader.ActivityIsPaused.  
3. That's it.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-07-09_16.03.45.png)