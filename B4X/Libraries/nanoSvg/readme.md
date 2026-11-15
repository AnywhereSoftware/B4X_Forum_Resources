###  nanoSvg by mazezone
### 11/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172526/)

This is a direct port of the original C source codes.  
Github (C source): <https://github.com/memononen/nanosvg>  
  
**Support:** B4J, B4A, B4I (I haven't checked).  
  
**Description:**   
This is a very small SVG text to B4XImageView converter.  
Doesn't support fonts (need to be converted to curves in advance) and some other things.  
Read more on Github.  
  

```B4X
Private B4XImageView1 As B4XImageView  
  
Dim svg As nanoSvg  
svg.Initialize  
B4XImageView1.mBackgroundColor = 0 ' background transparent  
svg.Render(B4XImageView1, File.ReadString(File.DirAssets, "c.svg"))
```

  
  
Render function:  
 Img - target  
 SvgStr - Svg text  
 Align - Alignment svg. Take a look at the optional keyboard.  
 7: left/top, 8: center/top, 9: right/top,  
 4: left/center, 5: (default) center/center, 6: right/center,  
 1: left/bottom, 2: center/bottom, 3: right/bottom.  
 Scale - Scale final image  
 mScale - 0: auto scale, 1: scaling relative to width, 2: scaling relative to height  
 OffsetX and OffsetX: shift by X and Y