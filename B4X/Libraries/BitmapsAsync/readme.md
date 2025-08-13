###  BitmapsAsync by Erel
### 02/28/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/119589/)

**Don't use this. Better implementation in SimpleMediaManager: <https://www.b4x.com/android/forum/threads/b4x-simplemediamanager-smm-framework-for-images-videos-and-more.134716/#content>**  
A cross platform library that allows loading images using background threads. It can be useful with keeping the app responsive while loading many images.  
  
It is specifically built to work with HttpJobs.  
  
It has two methods:  
LoadFromHttpJob (HttpJob, MaxWidth, MaxHeight) - Loads a bitmap that was downloaded with HttpJob.  
LoadFromFile (Dir, FileName, MaxWidth, MaxHeight) - Loads a local file  
  
Usage example:  

```B4X
Wait For (j) JobDone (j As HttpJob)  
If j.Success Then  
Wait For (ImageLoader.LoadFromHttpJob(j, 500dip, 500dip)) Complete (bmp As B4XBitmap)  
If Bmp.IsInitialized Then  
   'work with bitmap  
End If  
End If
```

  
  
If the image size is larger than MaxWidth or MaxHeight then the image will be downsampled, similar to LoadBitmapSample (not LoadBitmapResize).  
The best way to work with such images is by setting the ImageView gravity to Fill and resizing the ImageView based on the bitmap size. See the attached example.  
  
Notes:  
  
- In B4J the images are loaded synchronously.  
- In B4i the images are never downsampled. The reason behind it is that the OS takes care of uncompressing the image data right before it is displayed with the correct size.  
- The example shows two ways to resize the ImageView. In both methods there is an assumption that each ImageView is inside a panel and the dimensions are based on that panel. Each ImageView should be in its own panel.  
  
  
![](https://www.b4x.com/android/forum/attachments/96374)