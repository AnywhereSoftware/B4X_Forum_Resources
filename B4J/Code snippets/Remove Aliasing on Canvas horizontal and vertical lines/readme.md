### Remove Aliasing on Canvas horizontal and vertical lines by max123
### 06/18/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/72236/)

Hi all,  
  
After many days searching on the web, finally I found a solution to my current problem.  
  
javafx.scenes.canvas by default use antialiasing, this maybe is good on some cases, but if we draw Horizontal and Vertical lines we can see a pixel width of 2 pixels, not 1 pixel even if we use 1 as StrokeWidth for DrawLine method.  
  
I've tried to decrease a StrokeWidth Double value to 0.5 - 0.3 - 0.1 but this not solved the problem, this just add a more light color, but the line width remain 2 pixels.  
  
Now, starting from Java code and following this thread:  
<http://stackoverflow.com/questions/27846659/how-to-draw-an-1-pixel-line-using-javafx-canvas>  
  
after I converted this code to B4J, I figured that solved my problem and now I can view horizontal and vertical lines with real 1 pixel line width.  
  
The solution is really simple, just add 0.5 pixels offset to any X and Y coordinates (when draw line).  
It is important to pass a real Double (or maybe even Float) value in the DrawLine method.  
  
It is possible to add a variant inside B4J Canvas class for next releases?  
Maybe it can do an illusion that antialias is turned off, so just may add a method to turn on or off and, if turned off translate any coordinate by 0.5 pixels  
Or may the real solution is another? I'm unable to find a way to disable antialias on entire canvas, but may there is a way, tried with JavaObject but just fails….  
  
I hope this can help many users with same problem.  
  
This is a simple demostration of code, I also attached a B4J zip project and an image.  
  
Enjoy.  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 620  
    #MainFormHeight: 630  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.Title="This demo show how to remove aliasing on Canvas horizontal and vertical lines"  
    Dim sharpCanvas As Canvas = createCanvasGrid(MainForm, 10, 10, 601, 301, True)  
    Dim blurryCanvas As Canvas = createCanvasGrid(MainForm, 10, 320, 600, 300, False)  
  
    sharpCanvas.DrawLine(0, 0, sharpCanvas.Width, sharpCanvas.Height, fx.Colors.Black, .7)  
    sharpCanvas.DrawLine(0, sharpCanvas.Height, sharpCanvas.Width, 0, fx.Colors.Black, .7)  
    blurryCanvas.DrawLine(0, 0, blurryCanvas.Width, blurryCanvas.Height, fx.Colors.Black, .7)  
    blurryCanvas.DrawLine(0, blurryCanvas.Height, blurryCanvas.Width, 0, fx.Colors.Black, .7)  
    MainForm.Show  
End Sub  
  
Sub createCanvasGrid(form As Form, x As Int, y As Int, width As Int, height As Int, sharp As Boolean) As Canvas  
  
  Dim cvs As Canvas  
  cvs.Initialize("")  
  form.RootPane.AddNode(cvs, x, y, width, height)  
  
  For x = 0 To width Step 10  
      Dim x1 As Double  
      If sharp Then x1 = x + 0.5 Else x1 = x  
      cvs.DrawLine(x1, 0, x1, height, fx.Colors.Black, 1.0)  
  Next  
  
  For y = 0 To  height Step 10  
      Dim y1 As Double  
      If sharp Then y1 = y + 0.5 Else y1 = y  
      cvs.DrawLine(0, y1, width, y1, fx.Colors.Black, 1.0)  
  Next  
  
  Return cvs  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/49261)