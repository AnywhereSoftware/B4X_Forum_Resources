### Professional picture downloader by darabon
### 09/02/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/133958/)

I made a class for download pictures and apply filters on them with OKHttp  
Look like Picasso or other  
  
**This module support below function:**  
AnimationDuration: for show picture with animation after download  
Resize: resize picture with keep ratio  
SetRadius: change the radius of the picture (circle or rectangle)  
SetPlaceHolder: set holder picture if the download failed  
Rotate: rotate the picture  
CenterCrop: crop picture according to of image view  
ShowFade: show picture on image view with animation  
  
I think you can use that in B4i and B4j because I use XUI codes  
  
Example:  

```B4X
Dim p1 As Picture : p1.Initialize  
p1.SetRadius(imglogo.Height/2).Resize(imglogo.Width,imglogo.Height).CenterCrop(imglogo)  
Wait For (p1.Download(URL)) Complete(logo As Bitmap)  
     p1.ShowFade(imgv,logo)
```