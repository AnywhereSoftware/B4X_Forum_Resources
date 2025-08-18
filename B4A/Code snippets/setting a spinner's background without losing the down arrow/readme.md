### setting a spinner's background without losing the down arrow by Dave O
### 08/14/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133428/)

I wanted to change the background color of a spinner, but doing this normally loses the down arrow at the right end of the control.  
  
Here's a simple sub to fix that:  
  

```B4X
'set the background colour and add an arrow on the right  
Sub setSpinnerBackground(spinnerArg As Spinner, colorArg As Int)  
   dim const ICON_SIZE as int = 48dip      
   Dim tempBitmap As Bitmap  
   tempBitmap.InitializeMutable(spinnerArg.width, ICON_SIZE)  
   Dim tempCanvas As Canvas  
   tempCanvas.Initialize2(tempBitmap)  
   tempCanvas.DrawColor(colorArg)  
   tempCanvas.DrawText(Chr(0xE5C5), spinnerArg.width - ICON_SIZE/2, ICON_SIZE/1.3, Typeface.MATERIALICONS, 20, colors.black, "CENTER")  
   Dim bmd As BitmapDrawable  
   bmd.Initialize(tempBitmap)  
   spinnerArg.Background = bmd  
End Sub
```

  
  
Hope this helps!