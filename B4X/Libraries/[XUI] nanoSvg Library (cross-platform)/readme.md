###  [XUI] nanoSvg Library (cross-platform) by mazezone
### 11/18/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164187/)

[SIZE=5]**nanoSvg Library** [/SIZE]  
[SIZE=4]*****Support: B4A and B4J.*****[/SIZE]  
  
wrapper C/C++ nanoSvg ([Gihub](https://github.com/memononen/nanosvg))  
  
For B4J, copy the dll(x64) to B4J/Objects of the project.  
  
[SIZE=3]NanoSVG is a simple stupid single-header-file SVG parse. The output of the parser is a list of cubic bezier shapes.  
The library suits well for anything from rendering scalable icons in your editor application to prototyping a game.  
NanoSVG supports a wide range of SVG features, but something may be missing, feel free to create a pull request!  
The shapes in the SVG images are transformed by the viewBox and converted to specified units. That is, you should get the same looking data as your designed in your favorite app.[/SIZE]  
  

```B4X
Dim svg As nanoSvg  
svg.Initialize(B4XImageView1.mBase.Width, B4XImageView1.mBase.Height)  
    
svg.Scale = 0.5  
Dim imgRGBA() As Byte = svg.Render(File.ReadString(File.DirAssets, "23.svg"))  
    
If imgRGBA.Length > 0 Then  
    B4XImageView1.mBackgroundColor = 0  
    B4XImageView1.Bitmap = nanoSvgAlphaBitmap(imgRGBA)  
End If  
    
' ***  
    
svg.Width = B4XImageView2.mBase.Width  
svg.Height = B4XImageView2.mBase.Height  
  
svg.Scale = 0.8  
svg.Align = 6  
Dim imgRGBA() As Byte = svg.Render(File.ReadString(File.DirAssets, "telegram-plane.svg"))  
    
If imgRGBA.Length > 0 Then  
    B4XImageView2.mBackgroundColor = xui.Color_ARGB(255,255,255,255)  
    B4XImageView2.Bitmap = nanoSvgAlphaBitmap(imgRGBA)  
End If  
  
Public Sub nanoSvgAlphaBitmap(img() As Byte) As B4XBitmap  
    Dim w As Int = Bit.Or(Bit.And(img(img.Length-4) ,0xFF), Bit.ShiftLeft(Bit.And(img(img.Length-3) ,0xFF), 8))  
    Dim h As Int = Bit.Or(Bit.And(img(img.Length-2) ,0xFF), Bit.ShiftLeft(Bit.And(img(img.Length-1) ,0xFF), 8))  
  
    Dim bc As BitmapCreator  
    bc.Initialize(w, h)  
    
    Dim lick As Int  
    For y = 0 To h - 1  
        For x = 0 To w - 1  
            bc.SetColor(x, y, xui.Color_ARGB( _  
                Bit.And(0xff, img(lick + 3)), Bit.And(0xff, img(lick)), _  
                Bit.And(0xff, img(lick + 1)), Bit.And(0xff, img(lick + 2))))  
            lick = lick + 4  
        Next  
    Next  
    Return bc.Bitmap  
End Sub
```