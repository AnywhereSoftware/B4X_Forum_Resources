### "high-contrast text" system setting - work-around for colored text (or font icons) by Dave O
### 07/31/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141867/)

Android 5+ has an accessibility system setting called "high-contrast fonts", which lets the user force text (or icons rendered using fonts like Material or FontAwesome) to be outlined black or white (instead of the color you set). If you use colored text (or text-based icons) to indicate important things, this can play havoc with your UI.  
  
One solution is to [detect this setting](https://www.b4x.com/android/forum/threads/android-system-setting-for-high-contrast-fonts-how-to-detect.141425/) and tell the user to turn it off. However, they might need it for other apps, so that would be a bit rude. Also, many users will either not bother to turn it off, or will not know how to.  
  
A better solution is to bypass this system setting for the specific bits of colored text that you think should not be reduced to black or white. I initially did this by replacing the text with a bitmap created using **canvas.drawText**. But Android 9+ overrides this as well, so I did some research and found that **canvas.drawTextPath** does the trick on all Android versions (as far as I know). This function is easy to use via the (excellent) ABExtDrawing library.  
  
Here's the code I used for changing Material icons (characters using the Material font) to bitmaps. You could easily adapt this for FontAwesome or for normal text.  
  

```B4X
sub whereverYouSetTheColoredText  
    const ICON_GROUP as int = 0xE2C7    'sample icon from Material font  
    someLabel.SetBackgroundImage(generateBitmapFromIconCode(ICON_GROUP, colors.Red, 16, someLabel.Height))  
end sub  
  
Sub generateBitmapFromIconCode(iconArg As Int, colorArg As Int, textSizeArg As Int, bitmapSizeArg As Int) As Bitmap  
    Dim tempBitmap As Bitmap  
    tempBitmap.InitializeMutable(bitmapSizeArg, bitmapSizeArg)  
    Dim tempCanvas As Canvas  
    tempCanvas.Initialize2(tempBitmap)  
       
    Dim textPaint As ABPaint = buildTextPaint(FONT_MATERIAL, colorArg, textSizeArg)  
    Dim x As Float = bitmapSizeArg / 2  
    Dim y As Float = bitmapSizeArg + 0dip    'depending on the arguments, you may need a vertical offset here  
    drawTextPath(tempCanvas, textPaint, iconArg, x, y)  
  
    Return tempBitmap  
End Sub  
  
Sub buildTextPaint(typefaceArg As Typeface, colorArg As Int, textSizeArg As Int) As ABPaint  
    Dim tempPaint As ABPaint  
    tempPaint.Initialize  
    tempPaint.SetStyle(tempPaint.Style_FILL)  
    tempPaint.SetTextAlign(tempPaint.Align_CENTER)  
    tempPaint.SetColor(colorArg)  
    tempPaint.setTypeface(typefaceArg)  
    tempPaint.SetTextSize(textSizeArg * GetDeviceLayoutValues.Scale)  
    Return tempPaint  
End Sub  
  
Sub drawTextPath(canvasArg As Canvas, paintArg As ABPaint, iconArg As Int, x As Float, y As Float)  
    paintArg.GetTextPath(Chr(iconArg), 0, 1, x, y, textPath)  
    Dim abDraw As ABExtDrawing  
    abDraw.drawPath(canvasArg, textPath, paintArg)  
End Sub
```