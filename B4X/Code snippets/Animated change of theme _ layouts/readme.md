###  Animated change of theme / layouts by Erel
### 08/09/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/133267/)

[MEDIA=vimeo]584770841[/MEDIA]  
  
This is an example that demonstrates how Root.Snapshot + 2 BitmapCreators, with the old and new layouts can be used to create a nice transition between two layouts.  
  

```B4X
Private Sub SetNewTheme As ResumableSub  
    If bc1.IsInitialized = False Then  
        bc1.Initialize(Root.Width, Root.Height)  
        bc2.Initialize(Root.Width, Root.Height)  
        ImageViewForAnimation.Initialize("")  
    End If  
    If ImageViewForAnimation.As(B4XView).Parent.IsInitialized Then Return True 'already in progress…  
    bc1.CopyPixelsFromBitmap(Root.Snapshot)  
    UpdateTheme  
    bc2.CopyPixelsFromBitmap(Root.Snapshot)  
    Root.AddView(ImageViewForAnimation, 0, 0, Root.Width, Root.Height)  
    bc1.SetBitmapToImageView(bc1.Bitmap, ImageViewForAnimation)  
    Dim brush As BCBrush = bc1.CreateBrushFromBitmapCreator(bc2)  
    brush.BlendBorders = False  
    For r = 1 To Max(bc1.mWidth, bc1.mHeight) / 2 * 1.5 Step 20dip  
        Dim task As DrawTask = bc1.AsyncDrawCircle(bc1.mWidth / 2, bc1.mHeight / 2, r, brush, True, 0)  
        bc1.DrawBitmapCreatorsAsync(Me, "BC", Array(task))  
        Wait For BC_BitmapReady (bmp As B4XBitmap)  
        If xui.IsB4J Then bmp = bc1.Bitmap  
        bc1.SetBitmapToImageView(bc1.Bitmap, ImageViewForAnimation)  
        Sleep(16)  
    Next  
    ImageViewForAnimation.As(B4XView).RemoveViewFromParent  
    Return True  
End Sub
```

  
  
Test the transition in release mode.