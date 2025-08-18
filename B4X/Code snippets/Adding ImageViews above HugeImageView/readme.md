###  Adding ImageViews above HugeImageView by Erel
### 09/22/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/134476/)

Step 1: add an Updated event at the end of HugeImageView.SetImageViewLayout:  

```B4X
CallSub(mCallBack, mEventName & "_Updated")
```

  
  
Step 2: in the page class  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private HugeImageView1 As HugeImageView  
    Private ImageView1 As B4XView  
    Private ImageView1LayoutInPercentage As B4XRect  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    'Left - 10%, Top - 10%, Right - 20%, Bottom - 20%  
    ImageView1LayoutInPercentage.Initialize(0.10, 0.10, 0.20, 0.20) 'ignore (these are not pixels so we don't need dip units).  
    HugeImageView1.SetBitmap(File.DirAssets, "CCI20210918.jpg")  
    XUIViewsUtils.SetBitmapAndFill(ImageView1, xui.LoadBitmap(File.DirAssets, "logo.png"))  
End Sub  
  
Public Sub HugeImageView1_Updated  
    UpdateImageViewBasedOnRect(ImageView1, ImageView1LayoutInPercentage)  
End Sub  
  
Private Sub UpdateImageViewBasedOnRect(ImageView As B4XView, PercentageRect As B4XRect)  
    Dim ZoomOutLeft As Int = HugeImageView1.mBase.Left + HugeImageView1.pnlBackground.Left + HugeImageView1.ZoomOutImageView.Left  
    Dim ZoomOutTop As Int = HugeImageView1.mBase.Top + HugeImageView1.pnlBackground.Top + HugeImageView1.ZoomOutImageView.Top  
    ImageView.Left = ZoomOutLeft + PercentageRect.Left * HugeImageView1.ZoomOutImageView.Width  
    ImageView.Top = ZoomOutTop + PercentageRect.Top * HugeImageView1.ZoomOutImageView.Height  
    ImageView.Width = PercentageRect.Width * HugeImageView1.ZoomOutImageView.Width  
    ImageView.Height = PercentageRect.Height * HugeImageView1.ZoomOutImageView.Height  
End Sub
```

  
  
The new ImageViews position and size are relative to the huge image. They will move and zoom together with the large image.