### [XUI] Fill and Fit images without distortion by Erel
### 01/26/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/86627/)

**Don't use this code. Better solution in B4XImageView (XUI Views)** (<https://www.b4x.com/android/forum/threads/b4x-b4ximageview-imageview-resize-modes.121359/#content>)  
  
[SPOILER]Fit = Resize the image to the container size while preserving the image ratio. Leaves empty space if the image aspect ratio is different than the container aspect ratio.  
  
Fill (without distortion) = Crops the image to make it with the same aspect ratio as the container aspect ratio and then resizes the image.  
  
Example of fit:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-11-28_12.08.59.png)  
  
Example of fill:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-11-28_12.08.26.jpg)  
  

```B4X
Sub FitImageToView(bmp As B4XBitmap, ImageView As B4XView)  
    Dim scale As Float = 1  
    #if B4i  
    scale = GetDeviceLayoutValues.NonnormalizedScale  
    #End If  
    ImageView.SetBitmap(bmp.Resize(ImageView.Width * scale, ImageView.Height * scale, True))  
End Sub  
  
Sub FillImageToView(bmp As B4XBitmap, ImageView As B4XView)  
    Dim bmpRatio As Float = bmp.Width / bmp.Height  
    Dim viewRatio As Float = ImageView.Width / ImageView.Height  
    If viewRatio > bmpRatio Then  
        Dim NewHeight As Int = bmp.Width / viewRatio  
        bmp = bmp.Crop(0, bmp.Height / 2 - NewHeight / 2, bmp.Width, NewHeight)  
    Else if viewRatio < bmpRatio Then  
        Dim NewWidth As Int = bmp.Height * viewRatio  
        bmp = bmp.Crop(bmp.Width / 2 - NewWidth / 2, 0, NewWidth, bmp.Height)  
    End If  
    Dim scale As Float = 1  
    #if B4i  
    scale = GetDeviceLayoutValues.NonnormalizedScale  
    #End If  
    ImageView.SetBitmap(bmp.Resize(ImageView.Width * scale, ImageView.Height * scale, True))  
End Sub
```

  
  
Usage example (B4J):  

```B4X
Sub Process_Globals  
   Private fx As JFX  
   Private MainForm As Form  
   Private xui As XUI '<————-  
   Private ImageView1 As ImageView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
   MainForm = Form1  
   MainForm.RootPane.LoadLayout("1")  
   MainForm.Show  
   Dim bmp As B4XBitmap = xui.LoadBitmap(File.DirAssets, "image.png")  
   FillImageToView(bmp, ImageView1)  
End Sub
```

[/SPOILER]