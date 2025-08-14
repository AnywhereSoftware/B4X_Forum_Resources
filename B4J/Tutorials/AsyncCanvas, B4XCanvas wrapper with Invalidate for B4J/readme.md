### AsyncCanvas, B4XCanvas wrapper with Invalidate for B4J by max123
### 08/02/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148736/)

Hi all,  
  
before I start this thread, I want to thank some peoples that contributed to make this a working project.  
Thanks to [USER=125673]@teddybear[/USER] , [USER=74499]@aeric[/USER] and in particular way many thanks to [USER=52836]@Daestrum[/USER] that helped a lot to solve any problem I encountered.  
  
I had necessity to have in B4J the same implementation of B4A B4XCanvas with working Invalidate.  
  
After I figured that Canvas.Invalidate do nothing on B4J side, I decided to work on this.  
  
Today I would like to share this, that is a **full wrapper of B4XCanvas with working Invalidate function on B4J**.  
  
It completely exposes regular B4XCanvas, after this I added some other useful things like draw ovals and more.  
  
Using this library you can draw more things on canvas and nothing is shown, when you Invalidate the canvas all drawings will be invalidated once, like in B4A Canvas, this will improve significatly the draw speed and reduce the overhead when you draw fast on canvas.  
  
It use List, so is very fast. Any command you send to the canvas will be appended to the list, when you call Invalidate method, the list is iterated, any command is executed and then removed from the list.  
  
Because I like to mantain it open, I decided to distribuite it as b4xlib so may you can improve or extend it or fix bugs if any.  
Please contact me if you improve or extend it.  
  
I developed this with B4A canvas in mind, by default AutoInvalidate property is False, so you have to call Invalidate to update the canvas (like in B4A).  
  
Note that this library is even B4A compatible, in this case it do the opposite, the canvas AutoInvalidate property do nothing because it is False by default, but if you set it to True, next the library will invalidate the canvas like in B4J every command, so you don't need to update it yourself in the code with Invalidate method, this can be useful on certain situations where you want the canvas is auto invalidated.  
  
Note that AutoInvalidate always is False unless you set it to True, and you can set it multiple times in the code, changing the canvas way to work with, depending on what you need to do.  
  
Note that you don't need to use a Pane/Panel and then initialize canvas on it, just use the one line initializer and pass a B4XView .  
  
Some drawing functions have been added to original B4XCanvas:  
  
- DrawPixel  
- DrawPixel2  
- DrawLineTo  
- DrawRoundRect  
- DrawRoundRectRotated  
- DrawOval  
- DrawOvalRotated  
- Cls  
- Clear  
  
I attached the AsyncCanvas b4xlib with some demo examples, all are B4XPages cross platform and they works on B4J and B4A only, may some people can adapt to B4i, I don't use it.  
  
Note than in examples you cannot see any differences expecially on fast computers, unless you draw hundreds or thousands of commands and then invalidate them once, but if you just want to see if library is working (just for test) try to draw something with B4J and do not invalidate, you will notice that the canvas do not draw nothing, then test back and try to invalidate it, this time the canvas will show you all the drawings.  
  
UPDATED: v1.08  
Add a command to get native B4XCanvas from AsyncCanvas, this code now works.  

```B4X
Dim NativeCanvas As B4XCanvas = b4xCvs.GetNativeCanvas
```

  
  
**AsyncCanvas  
Author:** Massimo Meli  
**Version:** 1.08  

- **AsyncCanvas**
Methods:

- **Initialize** (Parent As B4XView, Left As Double, Top As Double, Width As Double, Height As Double) **As**
*Initializes the canvas object.*- **GetDrawingCount As Long**
*Get the drawing counter.  
 NOTE: GetDrawingCount, ClearDrawingCount, Invalidate, AutoInvalidate and any getter command will be excluded from count.*- **ClearDrawingCount As**
*Clear the drawing counter.*- **Cls As**
*Clear the full canvas with the black color.  
 This is a short hand to clear the screen black.*- **Clear** (Color As Int) **As**
*Clear the full canvas with the given color.*- **ClearTargetRect As**
*This is a short hand of cvs.ClearRect(cvs.TargetRect)*- **ClearRect** (Rect As B4XRect) **As**
*Clears the given rectangle. Does not work with clipped paths.*- **ClipPath** (Path As B4XPath) **As**
*Clips the drawings to a closed path.*- **RemoveClip As**
*Removes a previously set clip region.*- **DrawPath** (Path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float) **As**
*Draws the given path.*- **DrawPathRotated** (Path As B4XPath, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float, CenterX As Float, CenterY As Float) **As**
*Similar to DrawPath. Rotates the path based on the degrees and center parameters.*- **DrawBitmap** (Bitmap As Image, Dest As B4XRect) **As**
*Draws the bitmap in the given destination.  
 Use B4XBitmap.Crop To draw part of a bitmap.*- **DrawBitmapRotated** (Bitmap As Image, Dest As B4XRect, Degrees As Float) **As**
*Similar to DrawBitmap. Draws a rotated bitmap.*- **DrawPixel** (x As Float, y As Float, Color As Int) **As**
*Draws a single pixel.*- **DrawPixel2** (x As Float, y As Float, Color As Int, Radius As Float) **As**
*Similar to DrawPixel but permits to specify the pixel Radius.*- **DrawLine** (x1 As Float, y1 As Float, x2 As Float, y2 As Float, Color As Int, StrokeWidth As Float) **As**
*Draws a line from x1,y1 to x2,y2.*- **DrawLineTo** (x As Float, y As Float, Color As Int, StrokeWidth As Float) **As**
*Draws a line from last position (from DrawLine, DrawLineTo, DrawPixel, DrawPixel2 commands) to x,y.*- **DrawRect** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float) **As**
*Draws a rectangle.*- **DrawRectRotated** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float) **As**
*Similar to DrawRect. Draw a rotated rectangle.*- **DrawRoundRect** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float) **As**
*Draws a rectangle with round corners specified by CornerRadius.*- **DrawRoundRectRotated** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, CornerRadius As Float, Degrees As Float) **As**
*Similar to DrawRoundRect. Draw a rectangle with round corners and rotated by Degrees angle.*- **DrawCircle** (x As Float, y As Float, Radius As Float, Color As Int, Filled As Boolean, StrokeWidth As Float) **As**
*Draws a circle.*- **DrawOval** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float) **As**
*Draws an oval.*- **DrawOvalRotated** (Rect As B4XRect, Color As Int, Filled As Boolean, StrokeWidth As Float, Degrees As Float) **As**
*Similar to DrawOval. Draw the oval rotated by Degrees angle.*- **DrawText** (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object) **As**
*Draws the text at the given position. For alignment use one of following values "LEFT", "CENTER", "RIGHT".*- **DrawTextRotated** (Text As String, x As Double, y As Double, Font As B4XFont, Color As Int, Alignment As Object, Degrees As Float) **As**
*Similar to DrawText. Rotates the text before it is drawn.*- **Invalidate As**
*Commits the drawings.  
 If AutoInvalidate is False (default) this must be called for the drawings to be updated.*- **MeasureText** (Text As String, Font As B4XFont) **As B4XRect**
*Measures single line texts and returns their width, height and the height above the baseline.  
 Rect.Top returns the height above the baseline.*- **Release As**
*Releases native resources related to the canvas.   
 Only B4i, does nothing on B4 and B4J.  
 Just mantained for code compatibility.*- **Resize** (Width As Double, Height As Double) **As**
*Resizes the canvas.*- **CreateBitmap As B4XBitmap**
*Returns a copy of B4XBitmap.*- **CreateRect** (Left As Float, Top As Float, Width As Float, Height As Float) **As B4XRect**
*Returns a B4XRect by passing position, width and height.*- **Canvas As B4XCanvas**
*Returns the native B4XCanvas.*- **Panel As B4XView**
*Returns the canvas panel.*- **TargetRect As B4XRect**
*Returns a B4XRect with the same dimensions as the target view.*- **TargetView As B4XView**
*Returns a target view.*- Properties:
- **AutoInvalidate As Boolean**
*Sets or gets AutoInvalidate property.  
 By default AutoInvalidate is False, you will need to call Invalidate to update the drawings.  
 If you set AutoInvalidate to True, then the drawings will be auto updated every command.*- **Width As Double**
*Gets or sets the canvas Width (You can use Resize instead to resize it).*- **Height As Double**
*Gets or sets the canvas Height (You can use Resize instead to resize it).*