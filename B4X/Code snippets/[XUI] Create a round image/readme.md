###  [XUI] Create a round image by Erel
### 01/21/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/85102/)

**Better implementation in B4XImageView (XUI Views)**  
  
This code snippet is based on XUI library and it is compatible with B4A, B4i and B4J.  
The input is a bitmap and the output is a round bitmap (with no distortions).  
  
![](https://www.b4x.com/basic4android/images/SS-2017-10-17_12.59.56.png)  
  

```B4X
'xui is a global XUI variable.  
Sub CreateRoundBitmap (Input As B4XBitmap, Size As Int) As B4XBitmap  
   If Input.Width <> Input.Height Then  
       'if the image is not square then we crop it to be a square.  
       Dim l As Int = Min(Input.Width, Input.Height)  
       Input = Input.Crop(Input.Width / 2 - l / 2, Input.Height / 2 - l / 2, l, l)  
   End If  
   Dim c As B4XCanvas  
   Dim xview As B4XView = xui.CreatePanel("")  
   xview.SetLayoutAnimated(0, 0, 0, Size, Size)  
   c.Initialize(xview)  
   Dim path As B4XPath  
   path.InitializeOval(c.TargetRect)  
   c.ClipPath(path)  
   c.DrawBitmap(Input.Resize(Size, Size, False), c.TargetRect)  
   c.RemoveClip  
   c.DrawCircle(c.TargetRect.CenterX, c.TargetRect.CenterY, c.TargetRect.Width / 2 - 2dip, xui.Color_White, False, 5dip) 'comment this line to remove the border  
   c.Invalidate  
   Dim res As B4XBitmap = c.CreateBitmap  
   c.Release  
   Return res  
End Sub
```

  
  
Usage example:  

```B4X
'ImageView1 type is B4XView  
Dim img As B4XBitmap = xui.LoadBitmap(File.DirAssets, "myimage.jpg")  
ImageView1.SetBitmap(CreateRoundBitmap(img, ImageView1.Width))
```

  
If you don't want to set the ImageView type to B4XView then you can do it locally:  

```B4X
Dim xIV As B4XView = ImageView1  
xIV.SetBitmap(CreateRoundBitmap(img, xIV .Width))
```