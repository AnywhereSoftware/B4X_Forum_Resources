### [b4x][XUI] Imageslider ios blurry image tweak / tip by Andrew (Digitwell)
### 11/04/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/124221/)

I have been using image slider and I noticed that the images on iOS were a bit blurred.  
  
I tried using the tip here <https://www.b4x.com/android/forum/threads/loadbitmapresize-image-is-blurred-if-the-image-scale-down.100068/post-629511>, but this resulted in images that were too large and still blurred.  
  
It seems that the code within ImageSlider needs a bit of a tweak as well.  
  
The tweak is to update the code inside the imageslider class.  
  
Change the following line in **ShowImage** from  

```B4X
    NextPanel.GetView(0).SetLayoutAnimated(0, WindowBase.Width / 2 - bmp.Width / 2, _  
        WindowBase.Height / 2 - bmp.Height / 2, bmp.Width, bmp.Height)
```

  
to  

```B4X
    NextPanel.GetView(0).SetLayoutAnimated(0, Max(0,WindowBase.Width / 2 - bmp.Width / 2), _  
        Max(0,WindowBase.Height / 2 - bmp.Height / 2), _  
         Min(WindowBase.Width,bmp.Width), Min(WindowBase.Height,bmp.Height))
```

  
  
and you will get nice sharp images ! :)  
  
  
NOTE: the GetImage Callback needs to be changed as well.  
  

```B4X
Sub isImages_GetImage (Index As Int) As ResumableSub  
  
    Private myFile As String = $"splash${NumberFormat(Index + 1,1,0)}.png"$  
   ' scale image for non blurry rendering on iOS  
    Dim scale As Float  
    #if B4a or B4j  
      scale = 1  
    #else if B4i  
     scale = GetDeviceLayoutValues.NonnormalizedScale  
   #end if  
    Return xui.LoadBitmapResize(File.DirAssets,myFile , isimages.WindowBase.Width*scale, isimages.WindowBase.Height*scale, True)  
End Sub
```

  
  
[SPOILER="Sample images"]  
![](https://www.b4x.com/android/forum/attachments/102487)![](https://www.b4x.com/android/forum/attachments/102489)  
  
[/SPOILER]